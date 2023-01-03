class DashBoardSummaryModel {
  int? totalEarning;
  int? totalCustomer;
  String? errorMsg;
  DashBoardSummaryModel.fromJson(Map<String, dynamic> json)
      : totalEarning = json["total_earning"],
        totalCustomer = json["total_customer"];

  DashBoardSummaryModel.withError(String error) : errorMsg = error;
}
