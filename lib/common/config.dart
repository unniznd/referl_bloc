// const String baseURL = 'https://unnikuznd.pythonanywhere.com';
import 'package:referl/main.dart';

const String baseURL = "http://10.0.2.2:8000";

getToken() async {
  final token = await storage.read(key: "token");

  if (token != null) {
    return {
      "status": true,
      "token": token,
    };
  }
  return {"status": false};
}
