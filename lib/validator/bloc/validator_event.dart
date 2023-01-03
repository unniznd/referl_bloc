abstract class ValidatorEvent {}

class AddReferral extends ValidatorEvent {
  String platform;
  String refCode;
  String phone;
  String amount;
  AddReferral(this.platform, this.refCode, this.phone, this.amount);
}
