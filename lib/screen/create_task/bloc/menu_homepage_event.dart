part of 'menu_homepage_bloc.dart';

class MenuHomepageEvent {
  const MenuHomepageEvent();
}

class TitleEvent extends MenuHomepageEvent {
  String title;
  TitleEvent(this.title);
}

class DescriptionEvent extends MenuHomepageEvent {
  String description;
  DescriptionEvent(this.description);
}

class DateEvent extends MenuHomepageEvent {
  DateTime day;
  DateEvent(this.day);
}

class TimeEvent extends MenuHomepageEvent {
  TimeOfDay time;
  TimeEvent(this.time);
}

class CreateTaskEvent extends MenuHomepageEvent {}

class GetListTaskEvent extends MenuHomepageEvent {}

class DeleteTaskEvent extends MenuHomepageEvent {
  Task task;
  DeleteTaskEvent(this.task);
}
