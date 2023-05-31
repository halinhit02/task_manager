import 'package:thuc_tap_chuyen_nganh/model/task_type.dart';

class Task {
  String id; // id = DateTime.now().millisecondsSinceEpoch
  String title;
  String description;
  int time; // use DateTime.now().millisecondsSinceEpoch to get time
  TaskType type;

  Task(
      {required this.id,
      required this.title,
      required this.description,
      this.type = TaskType.Waiting,
      required this.time});

  factory Task.fromMap(Map<dynamic, dynamic> map) => Task(
        id: map['id'] ?? '',
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        type: map['type'] == 0
            ? TaskType.Waiting
            : map['type'] == 1
                ? TaskType.Running
                : map['type'] == 2
                    ? TaskType.Finished
                    : TaskType.Finished,
        time: map['time'] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'type': type.index,
        'time': time,
      };
}
