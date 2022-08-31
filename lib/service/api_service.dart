import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:noteapp/model/note_model.dart';
import 'package:noteapp/model/user_model.dart';
import 'package:noteapp/utils/dialogs.dart';
import 'package:noteapp/utils/preferences.dart';
import 'package:noteapp/utils/singleton.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final db = FirebaseFirestore.instance;
final Preferences prefs = Preferences();

class Api_Service {
// <---------------------- USER --------------------> //
  // Get info User
  static Future<List<QueryDocumentSnapshot<UserModel>>> getInfoUser(
    String userId,
    Function finish,
    Function catchError,
  ) async {
    List<QueryDocumentSnapshot<UserModel>> user = await db
        .collection("users")
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (appointment, _) => appointment.toJson(),
        )
        .where("userId", isEqualTo: userId)
        .get()
        .then((snapshot) => snapshot.docs)
        .catchError((error) => catchError(error));

    finish(user);
    return user;
  }

  // Update info user
  static Future updateUser(
      UserModel user, PlatformFile? imageUser, Function callBack) async {
    final noteRef = db.collection("users").doc(user.uuid);

    if (imageUser != null) {
      if (user.image!.isNotEmpty) {
        await deleteImage(user.image!);
        user.image = await uploadImage(imageUser);
      } else {
        user.image = await uploadImage(imageUser);
      }
    }

    await noteRef.update(
      {
        "address": user.address,
        "name": user.name,
        "phone": user.phone,
        "image": user.image
      },
    ).then((value) async {
      callBack(true);
      Singleton().prefs?.setUserPreference(user);
      Singleton().signInCompleted(user);
      Singleton().user =
          await Singleton().prefs!.getUserPreference() as UserModel;
    }, onError: (e) => callBack(false));
  }

  // Register with Email
  static registerEmail(
      email, password, Function(String smg, bool isSuccess) callBack) async {
    var uid = '';
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // UUID User
      uid = userCredential.user!.uid;
      // Add user -> db
      addUser(uid, email, (msg) {
        callBack(msg, true);
      });
      // Register success

    } on FirebaseAuthException catch (e) {
      // Register Failed
      callBack(e.message!, false);
    }
  }

  // Add user
  static addUser(String userId, String email, callBack) {
    var person = UserModel();
    person.email = email;
    person.userId = userId;
    db.collection("users").add(person.toJson()).then(
      (DocumentReference data) {
        // Update uuid
        db.collection("users").doc(data.id).update({
          "uuid": data.id,
        });
      },
    );
    callBack("Success !");
  }

  // Sign in with Email vs Password
  static void signIn(String email, String password,
      Function(bool isLogin, String msg) callBack) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      List<UserModel> users = [];
      User? user = FirebaseAuth.instance.currentUser;
      // If login success
      if (check()) {
        getInfoUser(user!.uid, (data) async {
          List<dynamic> listUser = data;
          for (var element in listUser) {
            users.add(element.data());
          }
          if (users.isNotEmpty && users[0].uuid != null) {
            Singleton().prefs!.setUserPreference(users[0]);
            Singleton().signInCompleted(users[0]);
            Singleton().user =
                await Singleton().prefs!.getUserPreference() as UserModel;
            callBack(true, "Đăng nhập thành công");
          }
        }, () {});
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        callBack(false, 'Email chưa được đăng ký');
      } else if (e.code == 'wrong-password') {
        callBack(false, 'Mật khẩu không chính xác');
      }
    }
  }

// Check account
  static bool check() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    } else {
      return true;
    }
  }

// <---------------------- NOTE --------------------> //
// Update note
  static Future updateNote(
    NoteModel note,
    PlatformFile? file,
    Function callBack,
  ) async {
    print(note.title!);
    print(note.content!);
    if (file != null) {
      // Delete old file
      await deleteImage(note.image!);
      // Insert new file
      note.image = await uploadImage(file);
    }
    print(note.image!);
    final noteRef = db.collection("note").doc(note.idNote);
    noteRef.update({
      "title": note.title,
      "content": note.content,
      "image": note.image,
    }).then((value) {
      callBack(true);
    }, onError: (e) => callBack(false));
  }

  // Delete note
  static Future deleteNote(NoteModel note, Function callBack) async {
    await db.collection("note").doc(note.idNote).delete().then(
      (doc) {
        deleteImage(note.image!);
        callBack("Success");
      },
      onError: (e) => callBack(e),
    );
  }

  // Get list note
  static Future<List<QueryDocumentSnapshot<NoteModel>>> getNote(
    String uuid,
    Function finish,
    Function catchError,
  ) async {
    List<QueryDocumentSnapshot<NoteModel>> appointments = await db
        .collection("note")
        .withConverter<NoteModel>(
          fromFirestore: (snapshot, _) => NoteModel.fromJson(snapshot.data()!),
          toFirestore: (appointment, _) => appointment.toJson(),
        )
        .where("uuid", isEqualTo: uuid)
        .get()
        .then((snapshot) => snapshot.docs)
        .catchError((error) => catchError(error));

    finish(appointments);
    return appointments;
  }

  // Add new note
  static Future<void> addNewNote(BuildContext context, NoteModel noteModel,
      PlatformFile file, Function callBack) async {
    Dialogs.showProgressDialog(context);

    final urlImage = await uploadImage(file);

    // add note to db
    noteModel.image = urlImage;

    await db.collection("note").add(noteModel.toJson()).then(
      (data) => {
        db.collection("note").doc(data.id).update(
          {
            "idNote": data.id,
          },
        )
      },
      onError: (e) {
        callBack(false);
      },
    );
    // Close progress dialog
    Navigator.of(context).pop();
    callBack(true);
  }

  // Upload image to storage
  static Future<String> uploadImage(PlatformFile file) async {
    // Show progress dialog

    // Path Storage
    final pathStorage = "images/${file.name}";

    // Image
    final fileImage = File(file.path!);

    // Reference Storage
    final refImage = FirebaseStorage.instance.ref().child(pathStorage);
    UploadTask? uploadTask = refImage.putFile(fileImage);

    final snapshot = await uploadTask.whenComplete(() => () {});

    // Get URL image
    final urlImage = await snapshot.ref.getDownloadURL();

    return urlImage;
    // Add new note to DB
  }

  static deleteImage(String url) {
    FirebaseStorage.instance.refFromURL(url).delete();
  }
}
