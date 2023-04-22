import 'package:flutter_bloc/flutter_bloc.dart';

part 'menu_homepage_event.dart';
part 'menu_homepage_state.dart';

class MenuHomepageBloc extends Bloc<MenuHomepageEvent, MenuHomepageState> {
  MenuHomepageBloc() : super(MenuHomepageInitial());
}
