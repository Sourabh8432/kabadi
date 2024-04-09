import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kabadi_app/view/splash_screen/splash_controller.dart';
import '../../utils/app_images.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: SplashController(),
        builder: (controller) {
          return Scaffold(
              backgroundColor: Colors.black,
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  AppImages.splashImagePng,
                  fit: BoxFit.fill,
                ),
              ));
        });
  }
}
