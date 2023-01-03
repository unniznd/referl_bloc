import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:referl/common/config.dart';

class ValidatorApiProvider {
  static const allPlatform = {
    'Instagram': 1,
    'WhatsApp': 2,
    "Facebook": 3,
    "Twitter": 4,
    "Snapchat": 5,
    "Other": 6,
  };
  Future<String> addReferal(
    String platform,
    String refCode,
    String phone,
    String amount,
  ) async {
    var resToken = await getToken();

    if (resToken["status"]) {
      String token = resToken["token"].toString();
      dynamic res;
      try {
        res = await http.post(
          Uri.parse("$baseURL/shopowner/influencer/referal/"),
          headers: {
            "Authorization": "Token $token",
          },
          body: {
            "platform": allPlatform[platform].toString(),
            "referal_code": refCode,
            "phone_number": phone,
            "bill_amount": amount,
          },
        ).timeout(const Duration(seconds: 10));
      } catch (e) {
        return "Error Occured";
      }

      if (res.statusCode == 200) {
        return "OK";
      }
      if (res.statusCode == 401) {
        return "LOGGED_OUT";
      }

      return json.decode(res.body)["res"];
    }
    return "LOGGED_OUT";
  }
}
