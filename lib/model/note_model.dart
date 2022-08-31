import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String? idNote;
  String? uuid;
  String? title;
  String? content;
  Timestamp? create;
  String? image;
  NoteModel(
      {this.idNote,
      this.uuid,
      this.title,
      this.content,
      this.create,
      this.image});

  NoteModel.fromJson(dynamic json) {
    idNote = json['idNote'] ?? '';
    uuid = json['uuid'] ?? '';
    title = json['title'] ?? '';
    content = json['content'] ?? '';
    image = json['image'] ?? '';
    create = json['create'] ?? '';
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['idNote'] = idNote;
    map['uuid'] = uuid;
    map['content'] = content;
    map['title'] = title;
    map['create'] = create;
    map['image'] = image;
    return map;
  }

  NoteModel.create(dynamic json) {
    idNote = json['idNote'] ?? '';
    uuid = json['uuid'] ?? '';
    title = json['title'] ?? '';
    content = json['content'] ?? '';
    create = json['create'] ?? '';
    image = json['image'] ?? '';
  }
}
