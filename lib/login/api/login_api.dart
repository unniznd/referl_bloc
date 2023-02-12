import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:referl/common/config.dart';
import 'package:referl/login/model/login_model.dart';

class LoginApiProvider {
  Future<LoginModel> authenticate(String username, String password) async {
    dynamic res;
    try {
      res = await http.post(
          Uri.parse(
            "$baseURL/account/login/",
          ),
          body: {
            "username": username,
            "password": password,
          }).timeout(const Duration(seconds: 10));
    } catch (e) {
      return LoginModel.withError("Authentication Failed");
    }

    if (res.statusCode == 200) {
      return LoginModel.fromJson(json.decode(res.body));
    }

    return LoginModel.withError("Authentication Failed");
  }
}
