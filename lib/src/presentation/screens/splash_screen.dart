import 'package:bloc_ecommerce/src/utils/asset_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      body: Center(
        child: SvgPicture.asset(
          AssetManager.APP_LOGO,
          height: 50.h,
          width: 50.w,
        ),
      ),
    );
  }
}
