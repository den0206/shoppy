import 'package:flutter/services.dart';
import 'package:shoppy/Extension/secKey.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';
import 'dart:convert';

class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static Uri paymentApiUri = Uri.parse(paymentApiUrl);

  static Map<String, String> header = {
    'Authorization': 'Bearer ${SecKey.paymentSecKey}',
    'Content-type': 'application/x-www-form-urlencoded'
  };

  static init() {
    StripePayment.setOptions(
      StripeOptions(
        publishableKey: SecKey.paymentPublishKey,
        merchantId: "test",
        androidPayMode: "test",
      ),
    );
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
    String amount,
    String currency,
  ) async {
    try {
      Map<String, dynamic> body = {
        StripeKey.amount: amount,
        StripeKey.currency: currency,
      };

      var response =
          await http.post(paymentApiUri, headers: header, body: body);

      return jsonDecode(response.body);
    } catch (e) {
      print("Payment Error ${e.toString()}");
    }

    return null;
  }

  static Future<StripeTransactionResponse> payWithNewCard(
    String amount,
    String currency,
  ) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      var paymentIntent =
          await StripeService.createPaymentIntent(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
          clientSecret: paymentIntent[StripeKey.clientSecret],
          paymentMethodId: paymentMethod.id));

      if (response.status == StripeKey.succeeded) {
        return StripeTransactionResponse(message: "Success", success: true);
      } else {
        return StripeTransactionResponse(
            message: "Transaction Failed", success: false);
      }
    } on PlatformException catch (e) {
      return StripeService.getPlatformExceptionErrorResult(e);
    } catch (e) {
      return StripeTransactionResponse(
          message: 'Transaction failed : $e', success: false);
    }
  }

  static getPlatformExceptionErrorResult(e) {
    String message = 'Something went wrong';
    if (e.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return new StripeTransactionResponse(message: message, success: false);
  }
}

class StripeKey {
  static final amount = "amount";
  static final currency = "currency";
  static final clientSecret = "client_secret";

  static final succeeded = "succeeded";
}
