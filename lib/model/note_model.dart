import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel{
  String? idNote;
  String? uuid;
  String? content;
  Timestamp? create;
  NoteModel({this.idNote, this.uuid, this.content,this.create});

  NoteModel.fromJson(dynamic json) {
    idNote = json['idNote'] ?? '';
    uuid = json['uuid'] ?? '';
    content = json['content'] ?? '';
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['idNote'] = idNote;
    map['uuid'] = uuid;
    map['content'] = content;
    map['create'] = create;
    return map;
  }

  NoteModel.create(dynamic json) {
    idNote = json['idNote'] ?? '';
    uuid = json['uuid'] ?? '';
    content = json['content'] ?? '';
    create = json['create'] ?? '';
  }


}