import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lilac_machine_test/model/user_model.dart';
import 'package:lilac_machine_test/services/otp_service.dart';
import 'package:lilac_machine_test/view/custom_widgets/custom_snacbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/home/home_screen.dart';

class LoginController extends GetxController {
  final phoneController = TextEditingController();
  RxBool isOtpScreen = false.obs;
  var phoneNumber = "".obs;
  var selectedCountryCode = "+91".obs;
  List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  List<UserModel> userData = [];

  Future<void> sendOtp() async {
    if (validatePhoneNumber()) {
      try {
        final response = await OtpService.sendOtp(
            phoneNumber: phoneController.text.trim(),
            countryCode: selectedCountryCode.value);
        if (response != null) {
          showCustomSnackBar(
              title: "Success",
              message: "OTP Sent Successfully",
              color: Colors.green);
          isOtpScreen.value = true;
        }
      } catch (e) {
        showCustomSnackBar(
            title: "Caught Exception", message: "$e", color: Colors.red);
      }
    }
  }

  void verifyOtp() async {
    // Combine all digits from the OTP fields
    String otp = otpControllers.map((controller) => controller.text).join();

    if (otp.isEmpty) {
      showCustomSnackBar(
        title: "Failed",
        message: "Please enter your OTP",
        color: Colors.red,
      );
    } else if (otp.length < 6 || otp.contains(RegExp(r'[^0-9]'))) {
      showCustomSnackBar(
        title: "Failed",
        message: "Enter a valid 6-digit OTP",
        color: Colors.red,
      );
    } else {
      try {
        final response = await OtpService.verifyOtp(
            phoneNumber: phoneController.text.trim(),
            countryCode: selectedCountryCode.value,
            otp: otp);

        if (response.isNotEmpty) {
          userData.add(response.first);

          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString("token", response.first.accessToken);
          preferences.setString("token_type", response.first.tokenType);

          Get.offAll(() => HomeScreen(
                userData: userData.first,
              ));
        } else {
          showCustomSnackBar(
              title: "Error", message: "Login Failed", color: Colors.red);
        }
      } catch (e) {
        showCustomSnackBar(
            title: "Exception", message: "$e", color: Colors.red);
      }
    }
  }

  bool validatePhoneNumber() {
    String phone = phoneController.text.trim();
    if (phone.isEmpty) {
      showCustomSnackBar(
          title: "Phone number is empty",
          message: "Enter you phone number",
          color: Colors.red);
      return false;
    } else if (!RegExp(r'^\d{10,}$').hasMatch(phone)) {
      showCustomSnackBar(
          title: "Failed", message: "Invalid Phone Number", color: Colors.red);

      return false;
    }

    return true;
  }
}
