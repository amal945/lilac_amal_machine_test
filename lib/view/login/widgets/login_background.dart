import 'package:flutter/material.dart';
import '../../../utils/app_dimensions.dart';

class LoginBackground extends StatelessWidget {
  final Widget child;

  const LoginBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.screenWidth,
      height: AppDimensions.screenHeight,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/login_background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
