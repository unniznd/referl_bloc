import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referl/wallet/api/wallet_api.dart';
import 'package:referl/wallet/bloc/payment/payment_event.dart';
import 'package:referl/wallet/bloc/payment/payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    final apiProvider = WalletApiProvider();
    on<MakeOrder>(
      (event, emit) async {
        // print("here");
        emit(PaymentLoading());
        try {
          final res = await apiProvider.makeOrder(event.amount);
          emit(PaymentRedirected(res));
          await Future.delayed(const Duration(seconds: 2));
          emit(PaymentInitial());
          if (res.errorMsg != null) {
            emit(PaymentError(res.errorMsg));
          }
        } catch (e) {
          emit(PaymentError("Failed To Make Order Data"));
        }
      },
    );
  }
}
