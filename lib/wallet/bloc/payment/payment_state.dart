import 'package:referl/wallet/model/payment_model.dart';

abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentRedirected extends PaymentState {
  final PaymentModel paymentModel;
  PaymentRedirected(this.paymentModel);
}

class PaymentError extends PaymentState {
  final String? error;
  PaymentError(this.error);
}
