import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kabadi_app/view/splash_screen/splash_controller.dart';
import '../../routes/app_pages.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_images.dart';
import 'choose_language_controller.dart';

class ChooseLanguageView extends StatelessWidget {
  const ChooseLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChooseLanguageController>(
        init: ChooseLanguageController(),
        builder: (controller) {
          return SafeArea(
              child: Scaffold(
                  body: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10,),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  AppConstants.chooseLanguage,
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: darkGreenColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                )),
                            const SizedBox(height: 15),
                            Text(
                              AppConstants.chooseLanguageSubText,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: textSubColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Column(
                                    children: [
                                      GestureDetector(onTap:() {
                                        controller.isCheck.value = 0;
                                        controller.update();
                                      },
                                        child: Container(
                                          height: 120,

                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: controller.isCheck.value == 0?primaryColor:whiteColor,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 1, color: borderColor)),
                                          child: SvgPicture.asset(
                                            AppImages.englishEn,
                                            height: 33,
                                            width: 44,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5,),
                                      Text(
                                        AppConstants.english,
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: controller.isCheck.value== true?darkGreenColor:textSubColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  )),
                                  const SizedBox(width: 10),
                                  Expanded(
                                      child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap:() {
                                          controller.isCheck.value = 1;
                                          controller.update();
                                        },
                                        child: Container(
                                          height: 120,

                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: controller.isCheck.value == 1?primaryColor:whiteColor,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 1, color: borderColor)),
                                          child: SvgPicture.asset(
                                            AppImages.hindiHi,
                                            height: 33,
                                            width: 44,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5,),
                                      Text(
                                        AppConstants.hindi,
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: controller.isCheck.value== false?darkGreenColor:textSubColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  )),
                                ],
                              ),
                            ),
                          ])),
              bottomNavigationBar: _buildContinue(context,controller),));
        });
  }



  /// Section Widget
  Widget _buildContinue(BuildContext context, controller) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Get.toNamed(Routes.welcomeView);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                  color: primaryColor),
              alignment: Alignment.center,
              height: 50,
              child: Text(
                AppConstants.selectProceed,
                style: TextStyle(
                    fontSize: 16,
                    color: darkGreenColor,
                    fontFamily: "MPLUS",
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Navigates to the previous screen.
  onTapArrowLeft() {
    Get.back();
  }
}
