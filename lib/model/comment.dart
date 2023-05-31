import 'package:thuc_tap_chuyen_nganh/model/comment_type.dart';

class Comment {
  String id;
  String content; // If type == IMAGE OR FILE then content is Link of them.
  CommentType type;
  int time; //use DateTime.now().millisecondsSinceEpoch to get time

  Comment(
      {required this.id,
      required this.content,
      this.type = CommentType.TEXT,
      required this.time});

  factory Comment.fromMap(Map<dynamic, dynamic> map) => Comment(
        id: map['id'] ?? '',
        content: map['content'] ?? '',
        type: CommentType.values[map['type'] ?? 0],
        time: map['time'] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'content': content,
        'type': type.index,
        'time': time,
      };
}
