import 'dart:convert';
import 'package:japx/japx.dart';
import 'package:lilac_machine_test/model/send_otp_response_model.dart';
import 'package:lilac_machine_test/utils/urls.dart';
import 'package:http/http.dart' as http;

import '../model/user_model.dart';

class OtpService {
  static Future<SendOtpResponseModel?> sendOtp(
      {required String phoneNumber, required String countryCode}) async {
    try {
      final url = Uri.parse(
          "${Urls.baseUrl}/auth/registration-otp-codes/actions/phone/send-otp");
      Map<String, dynamic> requestBody = {
        "data": {
          "type": "registration_otp_codes",
          "attributes": {
            "phone": "${countryCode}${phoneNumber}",
          }
        }
      };

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        final data = SendOtpResponseModel.fromJson(json);

        return data;
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<UserModel>> verifyOtp(
      {required String phoneNumber,
      required String countryCode,
      required String otp}) async {
    try {
      final url = Uri.parse(
          "${Urls.baseUrl}/auth/registration-otp-codes/actions/phone/verify-otp");

      final requestBody = jsonEncode({
        "data": {
          "type": "registration_otp_codes",
          "attributes": {
            "phone": "${countryCode}${phoneNumber}",
            "otp": int.parse(otp),
            "device_meta": {
              "type": "web",
              "name": "HP Pavilion 14-EP0068TU",
              "os": "Linux x86_64",
              "browser": "Mozilla Firefox Snap for Ubuntu (64-bit)",
              "browser_version": "112.0.2",
              "user_agent":
                  "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/112.0",
              "screen_resolution": "1600x900",
              "language": "en-GB"
            }
          }
        }
      });

      final response = await http.post(
        url,
        body: requestBody,
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        final decodeData = Japx.decode(json);

        final customer = UserModel.fromJson(decodeData['data']);

        return [customer];
      } else {
        final json = jsonDecode(response.body);
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }
}
