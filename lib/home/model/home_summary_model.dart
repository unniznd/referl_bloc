class HomeSummaryModel {
  int? balance;
  int? referal;
  int? earning;
  int? payout;
  int? validity;
  String? errorMsg;

  HomeSummaryModel.fromJson(Map<String, dynamic> json)
      : balance = json["balance"],
        referal = json["referal"],
        earning = json["earned"],
        payout = json["payout"],
        validity = json["validity"];

  HomeSummaryModel.withError(String error) : errorMsg = error;
}
