// const String baseURL = "https://referlbackend-production.up.railway.app";
const String baseURL = 'https://unnikuznd.pythonanywhere.com';

getToken() async {
  String token = "4b0b4c5ae5afa31f20f02451b31958e68b99de3d";
  if (token != '') {
    return {
      "status": true,
      "token": token,
    };
  }
  return {"status": false};
}
