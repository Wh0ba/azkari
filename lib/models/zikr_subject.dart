import 'package:azkari/models/zikr_item.dart';

class ZikrSubject {
  int id;
  String category;
  String audio;
  List<ZikrItem> items;

  ZikrSubject({required this.id,required  this.category, required this.audio,required  this.items});

  factory ZikrSubject.fromJson(Map<String, dynamic> json) {
    return ZikrSubject(
      id: json['id'] as int,
      category: json['category'] as String,
      audio: json['audio'] as String,
      items: (json['items'] as List<dynamic>)
          .map((item) => ZikrItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

