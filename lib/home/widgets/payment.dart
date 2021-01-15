    import 'dart:convert';
    import 'package:flutter/services.dart';
    import 'package:http/http.dart' as http;
    import 'package:stripe_payment/stripe_payment.dart';
    class StripeTransactionResponse {
      String message;
      bool success;
      StripeTransactionResponse({this.message, this.success});
    }
    class StripeService {
      static String apiBase = 'https://api.stripe.com/v1';
      static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
      static String secret = 'secret key';
      static Map<String, String> headers = {
        'Authorization': 'Bearer ${StripeService.secret}',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      
      static void init() {
        StripePayment.setOptions(StripeOptions(
            publishableKey: "publish key",
            merchantId: "Test",
            androidPayMode: 'test'));
      }
      static Future<StripeTransactionResponse> payViaExistingCard(
          {String amount, String currency, CreditCard card}) async {
        try {
          var paymentMethod = await StripePayment.createPaymentMethod(
              PaymentMethodRequest(card: card));
          dynamic paymentIntent =
              await StripeService.createPaymentIntent(amount, currency);
          var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
              clientSecret: paymentIntent['client_secret'].toString(),
              paymentMethodId: paymentMethod.id));
          if (response.status == 'succeeded') {
            return new StripeTransactionResponse(
                message: 'Transaction successful', success: true);
          } else {
            return new StripeTransactionResponse(
                message: 'Transaction failed', success: false);
          }
        } on PlatformException catch (err) {
          return StripeService.getPlatformExceptionErrorResult(err);
        } catch (err) {
          return new StripeTransactionResponse(
              message: 'Transaction failed: ${err.toString()}', success: false);
        }
      }
      static Future<StripeTransactionResponse> payWithNewCard(
          {String amount, String currency}) async {
        try {
          var paymentMethod = await StripePayment.paymentRequestWithCardForm(
              CardFormPaymentRequest());
          dynamic paymentIntent =
await StripeService.createPaymentIntent(amount, currency);
          var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
              clientSecret: paymentIntent['client_secret'].toString(),
              paymentMethodId: paymentMethod.id));
          if (response.status == 'succeeded') {
            return new StripeTransactionResponse(
                message: 'Transaction successful', success: true);
          } else {
            return new StripeTransactionResponse(
                message: 'Transaction failed', success: false);
          }
        } on PlatformException catch (err) {
          return StripeService.getPlatformExceptionErrorResult(err);
        } catch (err) {
          return new StripeTransactionResponse(
              message: 'Transaction failed: ${err.toString()}', success: false);
        }
      }
      static StripeTransactionResponse getPlatformExceptionErrorResult(dynamic err) {
        String message = 'Something went wrong';
        if (err.code == 'cancelled') {
          message = 'Transaction cancelled';
        }
        return new StripeTransactionResponse(message: message, success: false);
      }
      static dynamic createPaymentIntent(
          String amount, String currency) async {
        try {
          var body = <String, dynamic>{
            'amount': amount,
            'currency': currency,
            'payment_method_types[]': 'card'
          };
          var response = await http.post(StripeService.paymentApiUrl,
              body: body, headers: StripeService.headers);
          return jsonDecode(response.body);
        } catch (err) {
          print('err charging user: ${err.toString()}');
        }
        return null;
      }
    }