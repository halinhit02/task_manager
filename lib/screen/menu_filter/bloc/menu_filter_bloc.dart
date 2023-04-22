import 'package:flutter_bloc/flutter_bloc.dart';

part 'menu_filter_event.dart';
part 'menu_filter_state.dart';

class MenuFilterBloc extends Bloc<MenuFilterEvent, MenuFilterState> {
  MenuFilterBloc() : super(MenuFilterInitial());
}
