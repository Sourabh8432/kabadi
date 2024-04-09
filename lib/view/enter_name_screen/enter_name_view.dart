import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../../routes/app_pages.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_images.dart';

import 'enter_name_controller.dart';

class EnterNameView extends StatelessWidget {
  const EnterNameView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EnterNameController>(
        init: EnterNameController(),
        builder: (controller) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: _buildAppBar(),
              body: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 1),
                        child: Text(
                          AppConstants.yourName,
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: darkGreenColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        )),
                    const SizedBox(height: 29),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10),
                      child: Text(
                        AppConstants.name,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            color: primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(

                          border: Border.all(
                              width: 1, color: borderColor),
                          borderRadius:
                          BorderRadius.circular(100)),
                      child: const Row(
                        children: [
                          Expanded(
                            child: TextField(
                              // controller: controller.yourName,
                              style: TextStyle(fontSize: 18,letterSpacing: 1.6),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: _buildContinue(context, controller));
        });
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
        leadingWidth: 30,
        leading: InkWell(
          onTap: (){
            Get.back();
          },
          child: Container(
            margin: const EdgeInsets.only(left: 20),
            child: SvgPicture.asset(
              AppImages.backArrow,
            ),
          ),
        ),
        title: Text(AppConstants.enterName, style: TextStyle(
            fontSize: 18,
            fontFamily: "Poppins",
            color: darkGreenColor,
            fontWeight: FontWeight.w600)));
  }

  /// Section Widget
  Widget _buildContinue(BuildContext context, controller) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => onTapContinue(),
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
                AppConstants.getStarted,
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

  /// Navigates to the whatsYourNameScreen when the action is triggered.
  onTapContinue() {
    Get.toNamed(Routes.sellScrapView);
  }
}
