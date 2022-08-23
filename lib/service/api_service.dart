import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noteapp/model/user_model.dart';
final FirebaseAuth auth = FirebaseAuth.instance;
final db = FirebaseFirestore.instance;

class Api_Service {
  static registerEmail(email, password,callBack) async {
    var uid = '';
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      uid = userCredential.user!.uid;
      addUser(uid, email);
      callBack("Thanh cong");

      print(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
    callBack(e);
    }
  }
  static addUser(String userId, String email) {
    var person = UserModel();
    person.email = email;
    person.userId = userId;
    db.collection("users").add(person.toJson()).then((DocumentReference data) {

      db.collection("users").doc(data.id).update({
         "uuid": data.id,
      });
    }
    );
  }


  static deleteUser()
  {
    db.collection("users").doc("Pz7UwLKLYtJT23D85zgW").delete().then((value) => print("Success"), onError: () => print("Erorr"),);
  }

}