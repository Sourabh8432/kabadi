import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kabadi_app/routes/app_pages.dart';
import 'package:kabadi_app/view/profile_screen/profile_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_images.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return Scaffold(
              body: SingleChildScrollView(
                child: Stack(
                            children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          alignment: Alignment.bottomLeft,
                          height: 180,
                          margin: const EdgeInsets.only(bottom: 60),
                          padding: const EdgeInsets.only(
                              bottom: 15, right: 30, left: 30),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(AppImages.profileBg),
                                  fit: BoxFit.fill)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                        height: 40,
                                      // padding:
                                      //     const EdgeInsets.symmetric(vertical: 5),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            AppImages.backArrow,
                                            color: whiteColor,
                                          ),
                                          const SizedBox(width: 15),
                                          Text("profile".tr,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: "Poppins",
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.editProfileView,
                                          arguments: [
                                            {
                                              'name': controller.profileList?.name
                                                  .toString()
                                            },
                                            {
                                              'user_id': controller
                                                  .profileList?.userId
                                                  .toString()
                                            },
                                            {
                                              'image': controller
                                                  .profileList?.image
                                                  .toString()
                                            },
                                          ]);
                                    },
                                    child: Container(
                                      height: 40,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(40),
                                          border: Border.all(
                                              color: primaryColor, width: 1)),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.edit,
                                            color: whiteColor,
                                            size: 18,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text("editProfile".tr,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: "Poppins",
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.w400)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // const SizedBox(height: 60),
                            ],
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 3, color: whiteColor)),
                          child: ClipOval(
                            child: Image.network(
                              controller.profileList?.image ?? "",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  AppImages.profile,
                                  fit: BoxFit.fill,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(controller.profileList?.name ?? " ",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Poppins",
                            color: darkGreenColor,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Divider(
                        thickness: 1,
                        color: borderColor,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: borderColor)),
                                child: SvgPicture.asset(
                                  height: 30,
                                  width: 30,
                                  AppImages.phoneNumber,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mobile Number",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Poppins",
                                        color: textSubColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    controller.profileList?.mobile ?? " ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Poppins",
                                        color: darkGreenColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: borderColor)),
                                child: SvgPicture.asset(
                                  height: 30,
                                  width: 30,
                                  AppImages.email,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Poppins",
                                        color: textSubColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    controller.profileList?.email ?? " ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Poppins",
                                        color: darkGreenColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Divider(
                        thickness: 1,
                        color: borderColor,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Text("pickupAddress".tr,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Poppins",
                                  color: textSubColor,
                                  fontWeight: FontWeight.w600)),
                          const SizedBox(width: 20),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                Routes.addNewAddressView,
                                arguments:[ {
                                  'type': "edit",
                                },
                                  {
                                    'screen': "Profile",
                                  }
                                ],
                              );
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  border:
                                      Border.all(color: primaryColor, width: 1)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: darkGreenColor,
                                    size: 18,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text("edit".tr,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: "Poppins",
                                          color: darkGreenColor,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          color: lightBg,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            height: 40,
                            width: 40,
                            AppImages.officeSvg,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.locationType.value.isEmpty
                                    ? "Home"
                                    : controller.locationType.value,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Poppins",
                                    color: darkGreenColor,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                controller.location.value,
                                // controller.profileList?.location ?? " ",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: "Poppins",
                                    color: darkGreenColor,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
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
              ));
        });
  }



}
