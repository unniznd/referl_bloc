import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referl/wallet/api/wallet_api.dart';
import 'package:referl/wallet/bloc/balance/balance_state.dart';
import 'package:referl/wallet/bloc/balance/balance_event.dart';

class WalletBalanceBloc extends Bloc<WalletBalanceEvent, WalletBalanceState> {
  WalletBalanceBloc() : super(WalletBalanceInitial()) {
    final apiProvider = WalletApiProvider();
    on<FetchWalletBalance>(
      (event, emit) async {
        emit(WalletBalanceLoading());
        try {
          final res = await apiProvider.fetchBalance();
          emit(WalletBalanceLoaded(res));
          if (res.errorMsg != null) {
            emit(WalletBalanceError(res.errorMsg));
          }
          // emit(AddMoneyFailed());
        } catch (e) {
          emit(WalletBalanceError("Failed To Fetch Data"));
        }
      },
    );
    on<SuccessfulPayment>(
      (event, emit) async {
        emit(ProcessingPayment());
        final res = await apiProvider.successCallBackOrder(
          event.paymentId.toString(),
          event.orderId.toString(),
          event.signature.toString(),
        );
        if (res["status"] == "Failure") {
          emit(AddMoneyFailed());
        } else {
          emit(AddMoneySuccesful());
        }
      },
    );
    on<FailedPayment>(
      (event, emit) async {
        emit(ProcessingPayment());
        await Future.delayed(const Duration(seconds: 2));
        emit(AddMoneyFailed());
      },
    );
  }
}
