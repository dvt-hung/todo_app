import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noteapp/model/note_model.dart';
import 'package:noteapp/model/user_model.dart';
final FirebaseAuth auth = FirebaseAuth.instance;
final db = FirebaseFirestore.instance;

class Api_Service {

  // Register with Email
  static registerEmail(email, password,callBack) async {
    var uid = '';
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // UUID User
      uid = userCredential.user!.uid;
      // Register success
      if (addUser(uid, email))
        {
          callBack("Success !");
        }

      print(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      // Register Failed
      callBack(e);
    }
  }
  static bool addUser(String userId, String email) {
    var person = UserModel();
    bool result = true;
    person.email = email;
    person.userId = userId;
    db.collection("users").add(person.toJson()).then((DocumentReference data) {
      // Update uuid
      db.collection("users").doc(data.id).update({
         "uuid": data.id,
      });
    },
        onError: (e)=> result = false,
    );

    return result;
  }

  static void addNewNote()
  {
    NoteModel note = NoteModel();
    note.content = "Content";
    note.uuid = "EjlWQQCX3JnntgJOKkI3";
    note.create = Timestamp.now();

    db.collection("note").add(note.toJson())
    .then((data) => {
      db.collection("note").doc(data.id).update({
        "idNote" : data.id,
      },
      )
    },);
  }

  static void deleteUser()
  {
    db.collection("users").doc("Pz7UwLKLYtJT23D85zgW").delete().then((value) => print("Success"), onError: () => print("Erorr"),);
  }


  // Sign in with Email vs Password
  static void signIn(String email, String password) async
  {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      print("Success");
    }on FirebaseAuthException catch(e)
    {
      print(e.message);
    }
  }

  // Sign out account
static void signOut() async{
    await FirebaseAuth.instance.signOut();
}

// Check account
static void check(){
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
          if (user == null)
            {
              print("User is currently signed out");
            }
          else
            {
              print("User is sign in");
            }
    });
}

// Get list note
  static Future<List<QueryDocumentSnapshot<NoteModel>>> getNote(Function finish, Function catchError,) async {
    List<QueryDocumentSnapshot<NoteModel>> appointments = await db.collection("note").withConverter<NoteModel>(
      fromFirestore: (snapshot, _) => NoteModel.fromJson(snapshot.data()!),
      toFirestore: (appointment, _) => appointment.toJson(),
    ).where("uuid", isEqualTo: "EjlWQQCX3JnntgJOKkI3")
        .get()
        .then((snapshot) => snapshot.docs)
        .catchError((error) => catchError(error));

    finish(appointments);
    return appointments;
  }

// Update note

}