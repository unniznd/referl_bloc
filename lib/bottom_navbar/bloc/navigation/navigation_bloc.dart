import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationScreen(0)) {
    on<NavigateToScreen>((event, emit) {
      emit(NavigationScreen(event.index));
    });
  }
}
