import 'package:referl/wallet/model/payment_model.dart';
import 'package:referl/wallet/model/wallet_model.dart';
import 'package:http/http.dart' as http;
import 'package:referl/common/config.dart';
import 'dart:convert';

class WalletApiProvider {
  Future<WalletModel> fetchBalance() async {
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
        return WalletModel.withError("Failed to fetch data");
      }

      if (res.statusCode == 200) {
        return WalletModel.fromJson(json.decode(res.body));
      }
      return WalletModel.withError("Failed to fetch data");
    }
    return WalletModel.withError("Failed to fetch data");
  }

  Future<PaymentModel> makeOrder(int amount) async {
    var resToken = await getToken();

    if (resToken["status"]) {
      String token = resToken["token"].toString();

      dynamic res;
      try {
        res = await http.post(
            Uri.parse(
              "$baseURL/payment/order/",
            ),
            headers: {
              "Authorization": "Token $token",
            },
            body: {
              "amount": amount.toString(),
            }).timeout(const Duration(seconds: 10));
      } catch (e) {
        return PaymentModel.withError("Failed to fetch data");
      }

      if (res.statusCode == 200) {
        return PaymentModel.fromJson(json.decode(res.body));
      }
      return PaymentModel.withError("Failed to fetch data");
    }
    return PaymentModel.withError("Failed to fetch data");
  }

  Future successCallBackOrder(
    String paymentId,
    String orderId,
    String signature,
  ) async {
    var resToken = await getToken();

    if (resToken["status"]) {
      String token = resToken["token"].toString();

      dynamic res;
      try {
        res = await http.post(
          Uri.parse(
            "$baseURL/payment/callback/",
          ),
          headers: {
            "Authorization": "Token $token",
          },
          body: {
            "razorpay_order_id": orderId,
            "razorpay_payment_id": paymentId,
            "razorpay_signature": signature
          },
        ).timeout(const Duration(seconds: 10));
      } catch (e) {
        return {
          "status": "Failure",
        };
      }

      if (res.statusCode == 200) {
        return json.decode(res.body);
      }
      return {
        "status": "Failure",
      };
    }
    return {
      "status": "Failure",
    };
  }

  Future failureCallBackOrder(
    String paymentId,
    String orderId,
  ) async {
    var resToken = await getToken();

    if (resToken["status"]) {
      String token = resToken["token"].toString();

      dynamic res;
      try {
        res = await http.post(
          Uri.parse(
            "$baseURL/payment/callback/",
          ),
          headers: {
            "Authorization": "Token $token",
          },
          body: {
            "razorpay_order_id": orderId,
            "razorpay_payment_id": paymentId,
          },
        ).timeout(const Duration(seconds: 10));
      } catch (e) {
        return {
          "status": "Failure",
        };
      }

      if (res.statusCode == 200) {
        return json.decode(res.body);
      }
      return {
        "status": "Failure",
      };
    }
    return {
      "status": "Failure",
    };
  }
}
