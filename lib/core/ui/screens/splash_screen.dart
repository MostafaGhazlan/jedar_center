import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/Navigation/navigation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../features/root/screen/root_screen.dart';
import '../../constant/app_colors/app_colors.dart';
import '../../constant/app_images/app_images.dart';
import '../../utils/functions/location.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  void initializeApp() async {
 
    await GetLocation().getLocation();
    Navigation.pushAndRemoveUntil(const RootScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200.w,
          height: 200.h,
          child: Shimmer.fromColors(
            baseColor: AppColors.pink,
            highlightColor: AppColors.babyBlue,
            child: Image.asset(logoPngImage),
          ),
        ),
      ),
    );
  }
}
