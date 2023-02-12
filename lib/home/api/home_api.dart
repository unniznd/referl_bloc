import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:referl/home/model/home_summary_model.dart';
import 'package:referl/home/model/influencer_request_model.dart';
import 'package:referl/common/config.dart';

class HomeApiProvider {
  Future<HomeSummaryModel> fetchMonthlySummary() async {
    var resToken = await getToken();

    if (resToken["status"]) {
      String token = resToken["token"].toString();

      dynamic res;
      try {
        res = await http.get(
          Uri.parse(
            "$baseURL/shopowner/referal/monthly/summary/",
          ),
          headers: {
            "Authorization": "Token $token",
          },
        ).timeout(const Duration(seconds: 10));
      } catch (e) {
        return HomeSummaryModel.withError("Failed to fetch data");
      }

      if (res.statusCode == 200) {
        return HomeSummaryModel.fromJson(json.decode(res.body));
      }
      if (res.statusCode == 401) {
        return HomeSummaryModel.withError("LOGGED_OUT");
      }

      return HomeSummaryModel.withError("Failed to fetch data");
    }
    return HomeSummaryModel.withError("LOGGED_OUT");
  }

  Future<InfluencerRequestModel> fetchInfluencerRequest() async {
    var resToken = await getToken();
    if (resToken["status"]) {
      String token = resToken["token"].toString();
      dynamic res;
      try {
        res = await http.get(
          Uri.parse(
            "$baseURL/shopowner/influencer/pending/",
          ),
          headers: {
            "Authorization": "Token $token",
          },
        ).timeout(const Duration(seconds: 10));
      } catch (e) {
        return InfluencerRequestModel.withError("Failed to fetch data");
      }

      if (res.statusCode == 200) {
        return InfluencerRequestModel.fromJson(json.decode(res.body));
      }
      if (res.statusCode == 401) {
        return InfluencerRequestModel.withError("LOGGED_OUT");
      }
      return InfluencerRequestModel.withError("Failed to fetch data");
    }
    return InfluencerRequestModel.withError("LOGGED_OUT");
  }

  Future<String> acceptInfluencerRequest(int id) async {
    var resToken = await getToken();
    if (resToken["status"]) {
      String token = resToken["token"].toString();
      dynamic res;
      try {
        res = await http.post(
          Uri.parse(
            "$baseURL/shopowner/influencer/active/$id/",
          ),
          headers: {
            "Authorization": "Token $token",
          },
        ).timeout(const Duration(seconds: 10));
      } catch (e) {
        return "FAILED";
      }

      if (res.statusCode == 200) {
        return "OK";
      }
      if (res.statusCode == 401) {
        return "LOGGED_OUT";
      }
      return "FAILED";
    }
    return "LOGGED_OUT";
  }

  Future<String> rejectInfluencerRequest(int id) async {
    var resToken = await getToken();
    if (resToken["status"]) {
      String token = resToken["token"].toString();
      dynamic res;
      try {
        res = await http.delete(
          Uri.parse(
            "$baseURL/shopowner/influencer/active/$id/",
          ),
          headers: {
            "Authorization": "Token $token",
          },
        ).timeout(const Duration(seconds: 10));
      } catch (e) {
        return "FAILED";
      }

      if (res.statusCode == 200) {
        return "OK";
      }
      if (res.statusCode == 401) {
        return "LOGGED_OUT";
      }
      return "FAILED";
    }
    return "LOGGED_OUT";
  }

  Future<String> updateYourOffer(int payout, int validity) async {
    var resToken = await getToken();
    if (resToken["status"]) {
      String token = resToken["token"].toString();
      dynamic res;
      try {
        res = await http.patch(
          Uri.parse(
            "$baseURL/shopowner/profile/",
          ),
          headers: {
            "Authorization": "Token $token",
          },
          body: {
            "payout": payout.toString(),
            "validity": validity.toString(),
          },
        ).timeout(const Duration(seconds: 10));
      } catch (e) {
        return "FAILED";
      }

      if (res.statusCode == 200) {
        return "OK";
      }
      if (res.statusCode == 401) {
        return "LOGGED_OUT";
      }
      return "FAILED";
    }
    return "LOGGED_OUT";
  }
}
