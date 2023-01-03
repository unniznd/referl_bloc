import 'package:flutter_bloc/flutter_bloc.dart';

class ValidatorSubmitCubit extends Cubit<bool> {
  ValidatorSubmitCubit() : super(false);

  void setLoading(bool state) => emit(state);
}
