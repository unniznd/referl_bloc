import 'package:flutter_bloc/flutter_bloc.dart';

class YourOfferSubmitCubit extends Cubit<bool> {
  YourOfferSubmitCubit() : super(false);

  void setSubmiting(bool state) => emit(state);
}
