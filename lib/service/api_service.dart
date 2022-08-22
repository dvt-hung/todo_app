import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final db = FirebaseFirestore.instance;

class Api_Service {
  static registerEmail(email, password) async {
    var uid = '';
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      uid = userCredential.user!.uid;

      print(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  static addUser() {
    final user = <String, dynamic>{
      "first": "Ada",
      "last": "Lovelace",
      "born": 1815
    };

    db.collection("users").add(user).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
  }
}
