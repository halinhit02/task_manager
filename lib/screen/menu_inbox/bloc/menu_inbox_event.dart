part of 'menu_inbox_bloc.dart';

class MenuInboxEvent {
  const MenuInboxEvent();
}

class GetListCommentEvent extends MenuInboxEvent {}

class TitleEvent extends MenuInboxEvent {
  String title;
  TitleEvent(this.title);
}

class DescriptionEvent extends MenuInboxEvent {
  String description;
  DescriptionEvent(this.description);
}

class DateEvent extends MenuInboxEvent {
  DateTime day;
  DateEvent(this.day);
}

class TimeEvent extends MenuInboxEvent {
  TimeOfDay time;
  TimeEvent(this.time);
}
