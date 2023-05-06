import 'package:thuc_tap_chuyen_nganh/model/comment_type.dart';

class Comment {
  String content; // If type == IMAGE OR FILE then content is Link of them.
  CommentType type;
  int time; //use DateTime.now().millisecondsSinceEpoch to get time

  Comment({required this.content, required this.type, required this.time});
}
