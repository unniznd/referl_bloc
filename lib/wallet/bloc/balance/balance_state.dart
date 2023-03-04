import 'package:referl/wallet/model/wallet_model.dart';

abstract class WalletBalanceState {}

class WalletBalanceInitial extends WalletBalanceState {}

class WalletBalanceLoaded extends WalletBalanceState {
  final WalletModel walletModel;
  WalletBalanceLoaded(this.walletModel);
}

class WalletBalanceLoading extends WalletBalanceState {}

class WalletBalanceError extends WalletBalanceState {
  final String? error;
  WalletBalanceError(this.error);
}

class ProcessingPayment extends WalletBalanceState {}

class AddMoneySuccesful extends WalletBalanceState {}

class AddMoneyFailed extends WalletBalanceState {}
