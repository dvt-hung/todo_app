import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noteapp/model/note_model.dart';
import 'package:noteapp/model/user_model.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final db = FirebaseFirestore.instance;

class Api_Service {
  // Register with Email
  static registerEmail(email, password, callBack) async {
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
        callBack(msg);
      });
      // Register success

    } on FirebaseAuthException catch (e) {
      // Register Failed
      callBack(e);
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

  // Add new note
  static void addNewNote(NoteModel noteModel) {
    db.collection("note").add(noteModel.toJson()).then(
          (data) => {
            db.collection("note").doc(data.id).update(
              {
                "idNote": data.id,
              },
            )
          },
        );
  }

  // Sign in with Email vs Password
  static void signIn(String email, String password, Function callBack) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (check()) {
        callBack("Login Success");
      } else {
        callBack("Login Failed");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  // Sign out account
  static void signOut() async {
    await FirebaseAuth.instance.signOut();
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

// Update note
  static void updateNote(NoteModel note, Function callBack) {
    final noteRef = db.collection("note").doc(note.idNote);
    noteRef.update({"content": note.content}).then(
        (value) => callBack("Success"),
        onError: (e) => callBack(e));
  }

  // Delete note
  static void deleteNote(NoteModel note, Function callBack) {
    db.collection("note").doc(note.idNote).delete().then(
          (doc) => callBack("Success"),
          onError: (e) => callBack(e),
        );
  }

  // Update info user
  static void updateUser(UserModel user, Function callBack) {
    final noteRef = db.collection("users").doc(user.uuid);
    noteRef.update(
      {"address": user.address, "name": user.name, "phone": user.phone},
    ).then((value) => callBack("Success"), onError: (e) => callBack(e));
  }
}
