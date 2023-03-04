class WalletModel {
  int? balance;
  String? errorMsg;

  WalletModel.fromJson(Map<String, dynamic> json) : balance = json["balance"];

  WalletModel.withError(String error) : errorMsg = error;
}
