class PaymentModel {
  int? transactionId;
  String? key;
  String? orderId;
  String? name;
  String? email;
  int? amount;
  String? description;
  String? errorMsg;

  PaymentModel.fromJson(Map<String, dynamic> json)
      : transactionId = json["transaction_id"],
        key = json["key"],
        orderId = json["order_id"],
        name = json["name"],
        email = json["email"],
        amount = json["amount"],
        description = json["description"];

  PaymentModel.withError(String error) : errorMsg = error;
}
