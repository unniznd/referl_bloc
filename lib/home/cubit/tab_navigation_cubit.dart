import 'package:flutter_bloc/flutter_bloc.dart';

class TabNavigationCubit extends Cubit<int> {
  TabNavigationCubit() : super(0);
  void setIndex(int currentState) => emit(currentState);
}
