import 'package:flutter/material.dart';
import '../../../utils/app_dimensions.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.screenHeight * 0.08,
      width: AppDimensions.screenWidth * 0.9,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/logo.png"),
        ),
      ),
    );
  }
}
