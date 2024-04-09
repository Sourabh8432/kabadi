import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:kabadi_app/view/my_pickup_requests/my_pickup_controller.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_images.dart';

class MyPickupView extends StatelessWidget {
  const MyPickupView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyPickupController>(
        init: MyPickupController(),
        builder: (controller) {
          return Scaffold(
              body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  height: 111,
                  padding: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppImages.pickupAppbar),
                          fit: BoxFit.fill)),
                  child: Row(
                    children: [
                      GestureDetector(onTap: (){
                        Get.back();
                      },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: SvgPicture.asset(
                            AppImages.backArrow,
                            color: whiteColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(AppConstants.myPickupRequests,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Poppins",
                              color: whiteColor,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(AppConstants.scrapPickupReq,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Poppins",
                          color: darkGreenColor,
                          fontWeight: FontWeight.w400)),
                ),
                const SizedBox(height: 25),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${AppConstants.upcoming} :",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Poppins",
                              color: darkGreenColor,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 20),
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 1,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: borderColor, width: 1),
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.watch_later_outlined,
                                        color: orangeColor,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(AppConstants.upcoming,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Poppins",
                                              color: darkGreenColor,
                                              fontWeight: FontWeight.w500)),
                                      const Spacer(),
                                      Text(AppConstants.pickupID,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Poppins",
                                              color: textSubColor,
                                              fontWeight: FontWeight.w400)),
                                      Text("#4540DE",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Poppins",
                                              color: darkGreenColor,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                  color: borderColor,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(AppConstants.pickupID,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: "Poppins",
                                                  color: textSubColor,
                                                  fontWeight:
                                                      FontWeight.w400)),
                                          const Spacer(),
                                          Text("Sunday, 4 February, 2024",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: "Poppins",
                                                  color: darkGreenColor,
                                                  fontWeight:
                                                      FontWeight.w500)),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        children: [
                                          Text(AppConstants.pickupID,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: "Poppins",
                                                  color: textSubColor,
                                                  fontWeight:
                                                      FontWeight.w400)),
                                          const Spacer(),
                                          Text(
                                              "Bottles, Newspapers, Induc...",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: "Poppins",
                                                  color: darkGreenColor,
                                                  fontWeight:
                                                      FontWeight.w500)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${AppConstants.previousPickups} :",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Poppins",
                              color: darkGreenColor,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(height: 10),
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: borderColor, width: 1),
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.watch_later_outlined,
                                        color: orangeColor,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(AppConstants.upcoming,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Poppins",
                                              color: darkGreenColor,
                                              fontWeight: FontWeight.w500)),
                                      const Spacer(),
                                      Text(AppConstants.pickupID,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Poppins",
                                              color: textSubColor,
                                              fontWeight: FontWeight.w400)),
                                      Text("#4540DE",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Poppins",
                                              color: darkGreenColor,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                  color: borderColor,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(AppConstants.pickupID,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: "Poppins",
                                                  color: textSubColor,
                                                  fontWeight:
                                                  FontWeight.w400)),
                                          const Spacer(),
                                          Text("Sunday, 4 February, 2024",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: "Poppins",
                                                  color: darkGreenColor,
                                                  fontWeight:
                                                  FontWeight.w500)),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        children: [
                                          Text(AppConstants.pickupID,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: "Poppins",
                                                  color: textSubColor,
                                                  fontWeight:
                                                  FontWeight.w400)),
                                          const Spacer(),
                                          Text(
                                              "Bottles, Newspapers, Induc...",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: "Poppins",
                                                  color: darkGreenColor,
                                                  fontWeight:
                                                  FontWeight.w500)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
        });
  }
}
