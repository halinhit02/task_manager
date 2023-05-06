class Task {

  String id; // id = DateTime.now().millisecondsSinceEpoch
  String title;
  String description;
  int time; // use DateTime.now().millisecondsSinceEpoch to get time
  Task({required this.id, required this.title, required this.description, required this.time});
}