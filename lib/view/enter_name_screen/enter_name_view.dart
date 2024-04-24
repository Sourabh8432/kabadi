import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kabadi_app/utils/app_prefrences.dart';
import 'package:pinput/pinput.dart';
import '../../routes/app_pages.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_images.dart';

import '../choose_language/choose_language_controller.dart';
import 'enter_name_controller.dart';

class EnterNameView extends StatelessWidget {
  const EnterNameView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EnterNameController>(
        init: EnterNameController(),
        builder: (controller) {
          // final ChooseLanguageController chooseLanguageController = Get.find();
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: _buildAppBar(),
              body: Stack(
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 1),
                            child: Text(
                                // chooseLanguageController.translate('welcome_text'),
                              "yourName".tr,
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
                            "name".tr,
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
                          child:  Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: controller.yourName,
                                  style: const TextStyle(fontSize: 18,letterSpacing: 1.6),
                                  decoration: const InputDecoration(
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
        title: Text("enterName".tr, style: TextStyle(
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
                "getStarted".tr,
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
    EnterNameController saveNameController = Get.find();
    if(saveNameController.yourName.text.toString().isEmpty){
      Fluttertoast.showToast(msg: "Please Enter Your Name");
    }else{
      AppPrefrence.putString("save_name", saveNameController.yourName.text.toString());
      saveNameController.enterNameProfile(saveNameController.yourName.text.toString());

    }


  }
}
