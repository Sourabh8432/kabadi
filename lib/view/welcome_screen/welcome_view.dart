import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kabadi_app/utils/app_constants.dart';
import '../../routes/app_pages.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
              child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildWidget(),
                        const SizedBox(height: 41),
                        Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(AppConstants.welcome_text,
                              style: TextStyle(
                                  fontSize: 28,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold),
                            ),
                                  SvgPicture
                                      .asset(
                                    AppImages
                                        .welcomeThumbs,
                                    height: 33,
                                    width: 33,
                                  ),
              
                                ])),
                        const SizedBox(height: 7),
                        Container(
                            margin: const EdgeInsets.only(left: 16, right: 46),
                            child: Text(AppConstants.welcome_subtext,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: textSubColor,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.normal)),),
                        const SizedBox(height: 37),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => onTapLogIn(),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      const BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                     color: darkGreenColor),
                                  alignment: Alignment.center,
                                  height: 50,
                                  child: Text(
                                    AppConstants.logIn,
                                    style: TextStyle(
                                      fontSize: 16,
                                        color: primaryColor,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => onTapSignUp(),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      const BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                      color: primaryColor),
                                  alignment: Alignment.center,
                                  height: 50,
                                  child: Text(
                                    AppConstants.signUp,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: darkGreenColor,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5)
                      ])),
            )));
  }

  /// Section Widget
  Widget _buildWidget() {
    return SizedBox(
        width: double.maxFinite,
        child: Stack(alignment: Alignment.center, children: [
          Image.asset(
            alignment: Alignment.center,
            AppImages
                .welcomeImage,
          ),
          Opacity(opacity: 0.8,
            child: Image.asset(
              alignment: Alignment.center,
              AppImages
                  .welcomeImageBlur,
            ),
          ),

        ]));
  }

  /// Navigates to the whatsYourPhoneNumberScreen when the action is triggered.
  onTapLogIn() {
    Get.toNamed(Routes.loginView);
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapSignUp() {
    Get.toNamed(Routes.signupView);
  }
}
