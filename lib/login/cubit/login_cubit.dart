import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<bool> {
  LoginCubit() : super(false);
  void setLoading(bool state) => emit(state);
}
