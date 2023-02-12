import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referl/validator/api/validator_api.dart';
import 'package:referl/validator/bloc/validator_event.dart';
import 'package:referl/validator/bloc/validator_state.dart';

class ValidatorBloc extends Bloc<ValidatorEvent, ValidatorState> {
  ValidatorBloc() : super(ValidatorInitial()) {
    final ValidatorApiProvider validatorApiProvider = ValidatorApiProvider();
    on<AddReferral>(
      (event, emit) async {
        final res = await validatorApiProvider.addReferal(
          event.platform,
          event.refCode,
          event.phone,
          event.amount,
        );
        if (res == "OK") {
          emit(ValidatorSuccessful());
        } else if (res == "LOGGED_OUT") {
          emit(ValidatorTokenExpired());
        } else {
          emit(ValidatorError(res));
        }
      },
    );
  }
}
