class LoginModel {
  String? authToken;

  String? errorMsg;

  LoginModel.fromJson(Map<String, dynamic> json) : authToken = json["token"];

  LoginModel.withError(String error) : errorMsg = error;
}
