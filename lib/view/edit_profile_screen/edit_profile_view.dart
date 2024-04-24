import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
              body: Stack(
                children: [
                  Column(crossAxisAlignment:
                    CrossAxisAlignment.start,children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      height: 111,
                      padding: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AppImages.pickupAppbar),
                              fit: BoxFit.fill)),
                      child: InkWell(
                        onTap: () => onTapArrowLeft(),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                              child: SvgPicture.asset(
                                AppImages.backArrow,
                                color: whiteColor,
                              ),
                            ),
                            Text("editProfile".tr,
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
                            // Container(
                            //   height: 100,width: 100,
                            //   margin: const EdgeInsets.symmetric(vertical: 10),
                            //   decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(width: 3,color: whiteColor)),
                            //   child: Image.asset(AppImages.profile,fit: BoxFit.fill,),
                            // ),
                            CircleAvatar(
                              backgroundColor: whiteColor,
                              radius: 55,
                              child: ClipOval(
                                child: controller.profileImage.isEmpty
                                    ? Image.network(controller.myArguments[2]['image'],fit: BoxFit.cover,width: 100,errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(AppImages.profile,fit: BoxFit.fill,width: 100,);
                                    },)
                                    : Image.network(controller.profileImage,
                                  fit: BoxFit.fill,
                                  width: 100,
                                ),
                              ),),

                            InkWell(
                              onTap: (){
                                controller.getSelfieImage(context, ImageSource.camera).then((value) {
                                  controller.editProfileImage(controller.selfiePath.value);
                                });

                              },
                              child: Container(
                                height: 30,width: 30,
                                margin: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(color: darkGreenColor,shape: BoxShape.circle,border: Border.all(width: 3,color: whiteColor)),
                                child: Icon(Icons.edit,size: 15,color: whiteColor,),
                              ),
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
                                    controller: controller.name,
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
                                    controller: controller.editLocationname,
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
                                    controller: controller.editEmail,
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
          bottomNavigationBar: _buildUpdate(context,controller),
          );
        });
  }

  Widget _buildUpdate(BuildContext context , EditProfileController controller) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              if(controller.name.text.toString().isEmpty){
                Fluttertoast.showToast(msg: "Please Enter Your Name");
              }else {
                controller.editProfile(controller.name.text.toString(), controller.editLocationname.text.isEmpty ? "":controller.editLocationname.text.toString(), controller.editEmail.text.isEmpty ? "":controller.editEmail.text.toString());
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
                "updateProfile".tr,
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
