import 'package:flutter/material.dart';
import '../../utils/app_dimensions.dart';
import '../../utils/constants.dart';
import 'widgets/facebook_sign_in_button.dart';
import 'widgets/login_background.dart';
import 'widgets/logo_widget.dart';
import 'widgets/google_signin_button.dart';

import 'widgets/phone_signin_button.dart';
import 'widgets/terms_and_policy_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSpacing.height(0.08),
            const LogoWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                "Connect.Meet.Love.With Fliq Dating",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            const GoogleSignInButton(),
            const FacebookSignInButton(),
            const PhoneSignInButton(),
            const TermsAndPolicyText(),
            AppSpacing.height(0.03)
          ],
        ),
      ),
    );
  }
}
