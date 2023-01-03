import 'package:flutter_bloc/flutter_bloc.dart';

class YourOfferEditCubit extends Cubit<bool> {
  YourOfferEditCubit() : super(false);
  void setEditing(bool state) => emit(state);
  // void setTrue() => emit(true);
  // void setFalse() => emit(false);
}
