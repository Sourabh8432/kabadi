import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../utils/app_prefrences.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    startTimeCount();
  }


  startTimeCount() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, navigateInside);
  }

  void navigateInside() async => {
    AppPrefrence.getBoolean("isLogin")
        .then((value) async {
      if (value)
        {
          Get.toNamed(Routes.sellScrapView);
        }
      else
        {
          Get.offNamed(Routes.welcomeView);
        }
    }),


  };
  void navigateHomeInside() async => Get.offNamed(Routes.signupView);

}