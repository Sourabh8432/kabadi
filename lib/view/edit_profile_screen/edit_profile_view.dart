import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kabadi_app/view/profile_screen/profile_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_images.dart';
import 'edit_profile_controller.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
        init: EditProfileController(),
        builder: (controller) {
          return Scaffold(
              body: Column(crossAxisAlignment:
                CrossAxisAlignment.start,children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  height: 111,
                  padding: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppImages.pickupAppbar),
                          fit: BoxFit.fill)),
                  child: GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: SvgPicture.asset(
                            AppImages.backArrow,
                            color: whiteColor,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(AppConstants.editProfile,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Poppins",
                                color: whiteColor,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(crossAxisAlignment:
                  CrossAxisAlignment.start,children: [
                    const SizedBox(height: 20,),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          height: 100,width: 100,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(width: 3,color: whiteColor)),
                          child: Image.asset(AppImages.profile,fit: BoxFit.fill,),
                        ),
                        Container(
                          height: 30,width: 30,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(color: darkGreenColor,shape: BoxShape.circle,border: Border.all(width: 3,color: whiteColor)),
                          child: Icon(Icons.edit,size: 15,color: whiteColor,),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40,),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                      Text("Full Name", style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Poppins",
                        color: textSubColor,
                        fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10,),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: borderColor),
                            borderRadius:
                            BorderRadius.circular(100)),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                // controller: controller.yourName,
                                style: const TextStyle(fontSize: 18,letterSpacing: 1.6),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),],),
                    const SizedBox(height: 10,),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                      Text("Phone", style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Poppins",
                          color: textSubColor,
                          fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10,),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: borderColor),
                            borderRadius:
                            BorderRadius.circular(100)),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                // controller: controller.yourName,
                                style: const TextStyle(fontSize: 18,letterSpacing: 1.6),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),],),
                    const SizedBox(height: 10,),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                      Text("Email", style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Poppins",
                          color: textSubColor,
                          fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10,),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: borderColor),
                            borderRadius:
                            BorderRadius.circular(100)),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                // controller: controller.yourName,
                                style: const TextStyle(fontSize: 18,letterSpacing: 1.6),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),],),
                  ],),
                )


              ],),
          bottomNavigationBar: _buildUpdate(context,controller),
          );
        });
  }

  Widget _buildUpdate(BuildContext context , controller) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
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
                AppConstants.updateProfile,
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
  onTapArrowLeft() {
    Get.back();
  }
}
