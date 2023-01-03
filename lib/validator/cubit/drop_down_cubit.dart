import 'package:flutter_bloc/flutter_bloc.dart';

class DropDownCubit extends Cubit<String?> {
  DropDownCubit() : super(null);
  void setCurrentState(String? currentState) => emit(currentState);
}
