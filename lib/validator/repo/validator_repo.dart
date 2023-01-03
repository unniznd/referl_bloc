import 'package:referl/validator/api/validator_api.dart';

class ValidatorRepo {
  final ValidatorApiProvider _apiProvider = ValidatorApiProvider();

  Future<String> addReferral(
    String platform,
    String refCode,
    String phone,
    String amount,
  ) =>
      _apiProvider.addReferal(platform, refCode, phone, amount);
}
