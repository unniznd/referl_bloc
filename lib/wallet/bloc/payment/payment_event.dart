abstract class PaymentEvent {}

class MakeOrder extends PaymentEvent {
  int amount;
  MakeOrder(this.amount);
}
