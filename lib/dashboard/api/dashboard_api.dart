import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:referl/common/config.dart';
import 'package:referl/dashboard/model/dashboard_summary_model.dart';
import 'package:referl/dashboard/model/influencer_list_model.dart';

class DashBoardApiProvider {
  Future<DashBoardSummaryModel> fetchDashBoardSummary() async {
    var resToken = await getToken();
    if (resToken["status"]) {
      String token = resToken["token"].toString();
      dynamic res;
      try {
        res = await http.get(
          Uri.parse(
            "$baseURL/shopowner/referal/all/",
          ),
          headers: {
            "Authorization": "Token $token",
          },
        ).timeout(const Duration(seconds: 10));
      } catch (e) {
        return DashBoardSummaryModel.withError("Failed to fetch data");
      }

      if (res.statusCode == 200) {
        return DashBoardSummaryModel.fromJson(json.decode(res.body));
      }
      if (res.statusCode == 401) {
        return DashBoardSummaryModel.withError("LOGGED_OUT");
      }
      return DashBoardSummaryModel.withError("Failed to fetch data");
    }
    return DashBoardSummaryModel.withError("Failed to fetch data");
  }

  Future<InfluencerListModel> fetchActiveInfluencer() async {
    var resToken = await getToken();
    if (resToken["status"]) {
      String token = resToken["token"].toString();
      dynamic res;
      try {
        res = await http.get(
          Uri.parse(
            "$baseURL/shopowner/influencer/active/",
          ),
          headers: {
            "Authorization": "Token $token",
          },
        ).timeout(const Duration(seconds: 10));
      } catch (e) {
        return InfluencerListModel.withError("Failed to fetch data");
      }

      if (res.statusCode == 200) {
        return InfluencerListModel.fromJson(json.decode(res.body));
      }
      if (res.statusCode == 401) {
        return InfluencerListModel.withError("LOGGED_OUT");
      }
      InfluencerListModel.withError("Failed to fetch data");
    }
    return InfluencerListModel.withError("LOGGED_OUT");
  }
}
