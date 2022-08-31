// class Users{
//   late String idUser;
//   final String? nameUser;
//
//   Users({this.nameUser});
//
//   Map<String, dynamic> toFirestore(){
//     return {
//       if (nameUser != null) "nameUser" : nameUser,
//       "uuid" : null,
//     };
//   }
//   set setIdUser(String id) => idUser = id;
// }

class UserModel {
  String? name;
  String? uuid;
  String? userId;
  String? email;
  String? phone;
  String? address;
  String? image;
  UserModel({
    this.name,
    this.uuid,
    this.userId,
    this.email,
    this.phone,
    this.address,
    this.image,
  });

  UserModel.fromJson(dynamic json) {
    name = json['name'] ?? '';
    uuid = json['uuid'] ?? '';
    userId = json['userId'] ?? '';
    email = json['email'] ?? '';
    phone = json['phone'] ?? '';
    address = json['address'] ?? '';
    image = json['image'] ?? '';
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['uuid'] = uuid;
    map['userId'] = userId;
    map['email'] = email;
    map['phone'] = phone;
    map['address'] = address;
    map['image'] = image;
    return map;
  }

  String? get getName => name;
}
