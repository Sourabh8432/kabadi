import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_images.dart';
import 'signup_controller.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignupController>(
        init: SignupController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: whiteColor,
              appBar: _buildAppBar(),
              body: Stack(
                children: [
                  SingleChildScrollView(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Form(
                          key: controller.formKey,
                          child: Container(
                              width: double.maxFinite,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(right: 30),
                                        child: Text(
                                            "signUpTitle".tr,
                                          style: TextStyle(
                                              color: darkGreenColor,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600),
                                        ),),
                                    const SizedBox(height: 27),
                                     Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        "phone".tr,
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                            color: primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Container(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffF9FFF0),
                                          border: Border.all(
                                              width: 1, color: primaryColor),
                                          borderRadius:
                                          BorderRadius.circular(100)),
                                      child: Row(
                                        children: [
                                          CountryCodePicker(flagWidth: 30,
                                              padding: EdgeInsets.zero,
                                              textStyle: TextStyle(
                                                  fontSize: 14, color: textColor),
                                              onChanged: (CountryCode code) {
                                                controller.selectedCountry.value = code.toString();
                                              },
                                              favorite: const ['+91', 'IN'],
                                              initialSelection: 'IN',
                                              onInit: (code) {
                                                controller.selectedCountry.value = code.toString();
                                              }
                                          ),
                                          SizedBox(width:10,height: 50,child: VerticalDivider(color: primaryColor,thickness: 1,),),
                                          const SizedBox(width: 10,),
                                          Expanded(
                                            child: TextFormField(
                                              controller: controller.number,
                                              keyboardType: TextInputType.number,
                                              style: const TextStyle(fontSize: 14,letterSpacing: 1.6),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5)
                                  ])))),
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
                bottomNavigationBar: _buildContinue(context, controller)
            ),
          );
        });
  }
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
        leadingWidth: 40,
        leading: InkWell(
          onTap: onTapArrowLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 20,right: 10),
            child: SvgPicture.asset(
              AppImages.backArrow,
            ),
          ),
        ),
        title: Text("signUp".tr, style: TextStyle(
    fontSize: 16,
    fontFamily: "Poppins",
    color: darkGreenColor,
    fontWeight: FontWeight.w600)));
  }

  /// Section Widget
  Widget _buildContinue(BuildContext context , controller) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (controller.number.text.toString().isEmpty) {

                Fluttertoast.showToast(msg: "Please Enter Mobile Number");
              } else if(controller.number.text.toString().length < 9 && controller.number.text.toString().length > 10)  {
                Fluttertoast.showToast(msg: "Please Enter Valid Mobile Number");
              }else {
                // Get.toNamed(Routes.otpView, arguments:  controller.number.text.toString()?? "null");
                onTapContinue();
              }

            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              decoration: BoxDecoration(
                  borderRadius:
                  const BorderRadius.all(
                    Radius.circular(50),
                  ),
                  color: primaryColor),
              alignment: Alignment.center,
              height: 50,
              child: Text(
                "continue_text".tr,
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

  onTapContinue() {
    SignupController signupController = Get.find();
    signupController.signUpApi(signupController.number.text.toString());

    // TODO: implement Actions
  }
}
