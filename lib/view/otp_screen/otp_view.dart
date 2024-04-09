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

import 'otp_controller.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OtpController>(
        init: OtpController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: whiteColor,
              resizeToAvoidBottomInset: false,
              appBar: _buildAppBar(),
              body: Stack(
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 1),
                            child: Text(
                              AppConstants.otpVerification,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: darkGreenColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            )),
                        const SizedBox(height: 20),
                        Text(
                          AppConstants.otpSubText,
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: textSubColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "+91-9636998763",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: darkGreenColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                              child: Text(
                                controller.secondsRemaining.toString(),
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: primaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Pinput(
                          length: 6,
                          androidSmsAutofillMethod:
                              AndroidSmsAutofillMethod.smsRetrieverApi,
                          focusNode: controller.focusNode,
                          controller: controller.pinController,
                          defaultPinTheme: PinTheme(
                            width: 56,
                            height: 60,
                            textStyle: TextStyle(
                              fontSize: 22,
                              color: textColor,
                            ),
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                               border: Border.all(color: borderColor,width: 1),
                                color: whiteColor,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30))),
                          ),
                          hapticFeedbackType: HapticFeedbackType.lightImpact,
                          onCompleted: (pin) {
                            debugPrint('onCompleted: $pin');
                          },
                          onChanged: (value) {
                            debugPrint('onChanged: $value');
                          },
                        ),
                        const SizedBox(height: 39),
                        Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                   Text(
                                    AppConstants.didntReceiveOTP,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: textSubColor,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(width: 10),
                                   Row(
                                    children: [
                                      const Text(
                                        "?",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(width: 10),
                                      InkWell(onTap: () {
                                        controller.enableResend.value
                                            ? controller.resendCode()
                                            : null;
                                        controller.update();
                                      },
                                        child:  Text(
                                          AppConstants.resend,
                                          style: TextStyle(
                                            color: controller.enableResend.value?primaryColor:textSubColor, fontWeight: FontWeight.w500,
                                              fontSize: 14, fontFamily: "Poppins"),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5)
                                ])),
                      ],
                    ),
                  ),
                  if (controller.isLoading.value)
                    Container(
                      width: Get.width,
                      height: Get.height,
                      color: whiteColor.withOpacity(0.4),
                      child: Center(
                        child: CircularProgressIndicator(
                            color: primaryColor, backgroundColor: whiteColor),
                      ),
                    )
                ],
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
        title: Text(AppConstants.otpVerification, style: TextStyle(
            fontSize: 16,
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
            onTap: () {
              if (controller.pinController.text.toString().isEmpty) {
                Fluttertoast.showToast(msg: "Please Enter Otp First");
              } else if(controller.pinController.text.toString().length <6) {
                Fluttertoast.showToast(msg: "Please Enter 6 Digit Otp First");
              }else {
                controller.otpApi(controller.pinController.text.toString());
              }
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
                AppConstants.continue_text,
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
  onTapContinue() {}
}
