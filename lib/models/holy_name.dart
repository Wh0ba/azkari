// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HolyName {
  final int id;
  final String name;
  final String meaning;

  HolyName({required this.id, required this.name, required this.meaning});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'meaning': meaning,
    };
  }

  factory HolyName.fromJSON(Map<String, dynamic> map) {
    return HolyName(
      id: map['id'] as int,
      name: map['name'] as String,
      meaning: map['meaning'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  
}
