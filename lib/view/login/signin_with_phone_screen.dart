import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lilac_machine_test/controller/login_controller.dart';
import 'package:lilac_machine_test/utils/constants.dart';
import 'package:lilac_machine_test/view/home/home_screen.dart';

class SignInWithPhoneScreen extends StatelessWidget {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.isOtpScreen.value) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45.0),
                    child: const Text(
                      'Enter your verification code',
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  AppSpacing.height(0.05),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Row(
                      children: [
                        Text(
                          "${controller.selectedCountryCode.value}${controller.phoneController.text.trim()}.",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                           controller.isOtpScreen.value = false;
                          },
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.height(0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: 45,
                        height: 50,
                        child: TextField(
                          controller: controller.otpControllers[index],
                          // Bind to controller
                          focusNode: controller.focusNodes[index],
                          // Bind to focus node
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            counterText: "",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.green, width: 2),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 5) {
                              controller.focusNodes[index + 1]
                                  .requestFocus(); // Move to next field
                            } else if (value.isEmpty && index > 0) {
                              controller.focusNodes[index - 1]
                                  .requestFocus(); // Move back on delete
                            }
                          },
                        ),
                      );
                    }),
                  ),
                  AppSpacing.height(0.009),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 12,
                              color: const Color(0xFF3C1E1E),
                              height: 1.5,
                            ),
                        children: [
                          const TextSpan(
                            text:
                                "Didn't get anything? No worries, let's try again.\n",
                          ),
                          TextSpan(
                            text: 'Resent',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                controller.sendOtp();
                                print('Resent tapped');
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0.0, vertical: 8),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.verifyOtp();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.zero,
                          // Important for gradient fill
                          elevation: 2,
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFF06180),
                                // lighter shade of #E94269
                                Color(0xFFE94269),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            alignment: Alignment.center,
                            child: Text(
                              'Verify',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 65.0),
                    child: const Text(
                      'Enter your phone number',
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  AppSpacing.height(0.05),
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        const Icon(Icons.phone_android,
                            color: Color(0xFF3C1E1E), size: 20),
                        const SizedBox(width: 8),

                        // Country code dropdown
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: '+91',
                            icon: const Icon(Icons.arrow_drop_down,
                                color: Colors.grey),
                            items: ['+91', '+1', '+44'].map((code) {
                              return DropdownMenuItem<String>(
                                value: code,
                                child: Text(
                                  code,
                                  style: const TextStyle(
                                    color: Color(0xFF3C1E1E),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              controller.selectedCountryCode.value =
                                  value ?? "+91";
                            },
                          ),
                        ),

                        Container(
                          height: 24,
                          width: 1,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          color: const Color(0xFFDDDDDD),
                        ),

                        // Phone number input
                        Expanded(
                          child: TextField(
                            controller: controller.phoneController,
                            keyboardType: TextInputType.phone,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF3C1E1E),
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Phone number',
                              labelStyle: TextStyle(
                                color: Color(0xFF3C1E1E),
                                fontWeight: FontWeight.w500,
                              ),
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.height(0.009),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Fliq will sent you a text with a verification code.",
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF3C1E1E),
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0.0, vertical: 8),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.sendOtp();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.zero,
                          // Important for gradient fill
                          elevation: 2,
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFF06180),
                                // lighter shade of #E94269
                                Color(0xFFE94269),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            alignment: Alignment.center,
                            child: Text(
                              'Next',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
              ],
            ),
          )),
    );
  }
}
