class ZikrItem {
  int id;
  String text;
  int count;
  String audio;

  ZikrItem(
      {required this.id,
      required this.text,
      required this.count,
      required this.audio});

  factory ZikrItem.fromJson(Map<String, dynamic> json) {
    return ZikrItem(
      id: json['id'] as int,
      text: json['text'] as String,
      count: json['count'] as int,
      audio: json['audio'] as String,
    );
  }
}
