abstract class WalletBalanceEvent {}

class FetchWalletBalance extends WalletBalanceEvent {}

class SuccessfulPayment extends WalletBalanceEvent {
  String paymentId, orderId, signature;

  SuccessfulPayment(this.paymentId, this.orderId, this.signature);
}

class FailedPayment extends WalletBalanceEvent {
  String paymentId;
  FailedPayment(this.paymentId);
}
