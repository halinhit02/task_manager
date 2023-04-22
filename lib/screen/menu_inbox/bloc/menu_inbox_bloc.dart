import 'package:flutter_bloc/flutter_bloc.dart';

part 'menu_inbox_event.dart';
part 'menu_inbox_state.dart';

class MenuInboxBloc extends Bloc<MenuInboxEvent, MenuInboxState> {
  MenuInboxBloc() : super(MenuInboxInitial());
}
