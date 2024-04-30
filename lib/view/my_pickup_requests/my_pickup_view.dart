import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:kabadi_app/view/my_pickup_requests/my_pickup_controller.dart';

import '../../models/pickup_request_models.dart';
import '../../routes/app_pages.dart';
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
          if (controller. pickupRequestsList != null) {
            return Scaffold(
                body: Stack(
                  children: [
                    SingleChildScrollView(
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
                            child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                height: 40,
                              child: Row(
                                children: [
                                  Container(
                                    margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                    child: SvgPicture.asset(
                                      AppImages.backArrow,
                                      color: whiteColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text("myPickupRequests".tr,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "Poppins",
                                          color: whiteColor,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),),
                          const SizedBox(height: 25),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text("scrapPickupReq".tr,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Poppins",
                                    color: darkGreenColor,
                                    fontWeight: FontWeight.w400)),
                          ),
                          Container(
                            padding:  EdgeInsets.symmetric(horizontal: controller.pickupRequestsList!.upcoming!.isEmpty ?20:20),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                controller.pickupRequestsList!.upcoming!.isEmpty ?SizedBox():const SizedBox(height: 20),
                                controller.pickupRequestsList!.upcoming!.isEmpty ? SizedBox():Text("upcoming".tr,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Poppins",
                                      color: darkGreenColor,
                                      fontWeight: FontWeight.w600)),
                                controller.pickupRequestsList!.upcoming!.isEmpty ?SizedBox():const SizedBox(height: 20),
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: controller.pickupRequestsList!.upcoming?.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  PickupRequestUpcoming?  upcomingList = controller.pickupRequestsList!.upcoming?[index];

                                  return InkWell(onTap: (){
                                    controller.isCheck.value = true;
                                    // controller.isComandata(upcomingList.pickupStatus!,[] as PickupRequestPrevious,controller.pickupRequestsList!.upcoming![index],true );

                                    if(upcomingList.pickupStatus == "Upcoming"){
                                      Get.toNamed(Routes.trackPickupView,
                                          arguments: [
                                            {
                                              'data': controller.pickupRequestsList!.upcoming?[index],
                                              'type': "SellScrapItem", // or false, depending on your requirement
                                            }
                                          ],);
                                      // Get.toNamed(Routes.trackPickupView,arguments: controller.pickupRequestsList!.upcoming?[index]);
                                    }else if (upcomingList.pickupStatus == "Completed"){
                                      Get.toNamed(Routes.requestCancelledView, arguments: controller.pickupRequestsList!.upcoming?[index] );
                                    }else {
                                      Get.toNamed(Routes.requestCancelledView, arguments: controller.pickupRequestsList!.upcoming?[index]);
                                    }

                                  },
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 15),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: borderColor, width: 1),
                                          borderRadius:
                                          BorderRadius.circular(15)),
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
                                                Text(
                                                    upcomingList
                                                    !.pickupStatus
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: "Poppins",
                                                        color: darkGreenColor,
                                                        fontWeight:
                                                        FontWeight.w500)),
                                                const Spacer(),
                                                Text("pickupID".tr,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: "Poppins",
                                                        color: textSubColor,
                                                        fontWeight:
                                                        FontWeight.w400)),
                                                Text(
                                                    upcomingList
                                                        .pickupRequestId
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: "Poppins",
                                                        color: darkGreenColor,
                                                        fontWeight:
                                                        FontWeight.w600)),
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
                                                    Text("pickup".tr,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily: "Poppins",
                                                            color: textSubColor,
                                                            fontWeight:
                                                            FontWeight.w400)),
                                                    const Spacer(),
                                                    Text(
                                                        upcomingList
                                                            .pickupDate
                                                            .toString(),
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
                                                    Text("items".tr,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily: "Poppins",
                                                            color: textSubColor,
                                                            fontWeight:
                                                            FontWeight.w400)),
                                                    Spacer(),
                                                    Text(
                                                        upcomingList
                                                            .pickupItemsName
                                                            !.length > 30 ? '${upcomingList
                                                            .pickupItemsName!.substring(0, 30)}...' : upcomingList
                                                            .pickupItemsName.toString(),
                                                        style: TextStyle(
                                                            overflow: TextOverflow.ellipsis,
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
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 25),
                                controller.pickupRequestsList!.previous!.isEmpty?const SizedBox():Text("previousPickups".tr,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Poppins",
                                      color: darkGreenColor,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(height: 20),
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: controller.pickupRequestsList!.previous?.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  PickupRequestPrevious?  previousList = controller.pickupRequestsList!.previous?[index];

                                  return InkWell(
                                    onTap: (){
                                      if(previousList.pickupStatus == "Upcoming"){
                                        Get.toNamed(Routes.trackPickupView,arguments: [
                                          {
                                            'data': controller.pickupRequestsList!.previous?[index],
                                            'type': "SellScrapItem", // or false, depending on your requirement
                                          }
                                        ],);
                                        // Get.toNamed(Routes.trackPickupView,arguments: controller.pickupRequestsList!.previous?[index]);
                                      }else if (previousList.pickupStatus == "Completed"){
                                        Get.toNamed(Routes.requestCancelledView, arguments: controller.pickupRequestsList!.previous?[index] );
                                      }else {
                                        Get.toNamed(Routes.requestCancelledView, arguments: controller.pickupRequestsList!.previous?[index]);
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 15),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: borderColor, width: 1),
                                          borderRadius:
                                          BorderRadius.circular(15)),
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
                                                Text(
                                                    previousList
                                                    !.pickupStatus
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: "Poppins",
                                                        color: darkGreenColor,
                                                        fontWeight:
                                                        FontWeight.w500)),
                                                const Spacer(),
                                                Text("pickupID".tr,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: "Poppins",
                                                        color: textSubColor,
                                                        fontWeight:
                                                        FontWeight.w400)),
                                                Text(
                                                    previousList
                                                        .pickupRequestId
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: "Poppins",
                                                        color: darkGreenColor,
                                                        fontWeight:
                                                        FontWeight.w600)),
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
                                                    Text("pickup".tr,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily: "Poppins",
                                                            color: textSubColor,
                                                            fontWeight:
                                                            FontWeight.w400)),
                                                    const Spacer(),
                                                    Text(
                                                        previousList
                                                            .pickupDate
                                                            .toString(),
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
                                                    Text("items".tr,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily: "Poppins",
                                                            color: textSubColor,
                                                            fontWeight:
                                                            FontWeight.w400)),
                                                    Spacer(),
                                                    Text(
                                                        previousList
                                                            .pickupItemsName
                                                        !.length > 30 ? previousList
                                                            .pickupItemsName!.substring(0, 30)+'...' : previousList
                                                            .pickupItemsName.toString(),
                                                        style: TextStyle(
                                                          overflow: TextOverflow.ellipsis,
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
                                    ),
                                  );
                                },
                              ),
                            ],),
                          ),

                          // const SizedBox(height: 20),
                          // Container(
                          //   margin: const EdgeInsets.symmetric(horizontal: 20),
                          //   child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Text("${AppConstants.previousPickups.tr} :",
                          //           style: TextStyle(
                          //               fontSize: 16,
                          //               fontFamily: "Poppins",
                          //               color: darkGreenColor,
                          //               fontWeight: FontWeight.w600)),
                          //       const SizedBox(height: 10),
                          //       ListView.builder(
                          //         padding: EdgeInsets.zero,
                          //         itemCount: 2,
                          //         shrinkWrap: true,
                          //         physics: const NeverScrollableScrollPhysics(),
                          //         itemBuilder: (context, index) {
                          //           return Container(
                          //             margin: const EdgeInsets.only(top: 10),
                          //             decoration: BoxDecoration(
                          //                 border: Border.all(
                          //                     color: borderColor, width: 1),
                          //                 borderRadius: BorderRadius.circular(15)),
                          //             child: Column(
                          //               children: [
                          //                 Container(
                          //                   margin: const EdgeInsets.symmetric(
                          //                       horizontal: 10, vertical: 10),
                          //                   child: Row(
                          //                     children: [
                          //                       Icon(
                          //                         Icons.watch_later_outlined,
                          //                         color: orangeColor,
                          //                       ),
                          //                       const SizedBox(
                          //                         width: 10,
                          //                       ),
                          //                       Text(AppConstants.upcoming.tr,
                          //                           style: TextStyle(
                          //                               fontSize: 14,
                          //                               fontFamily: "Poppins",
                          //                               color: darkGreenColor,
                          //                               fontWeight: FontWeight.w500)),
                          //                       const Spacer(),
                          //                       Text(AppConstants.pickupID.tr,
                          //                           style: TextStyle(
                          //                               fontSize: 14,
                          //                               fontFamily: "Poppins",
                          //                               color: textSubColor,
                          //                               fontWeight: FontWeight.w400)),
                          //                       Text("#4540DE",
                          //                           style: TextStyle(
                          //                               fontSize: 14,
                          //                               fontFamily: "Poppins",
                          //                               color: darkGreenColor,
                          //                               fontWeight: FontWeight.w600)),
                          //                     ],
                          //                   ),
                          //                 ),
                          //                 Divider(
                          //                   height: 1,
                          //                   color: borderColor,
                          //                 ),
                          //                 Container(
                          //                   margin: const EdgeInsets.symmetric(
                          //                       horizontal: 10, vertical: 15),
                          //                   child: Column(
                          //                     children: [
                          //                       Row(
                          //                         children: [
                          //                           Text(AppConstants.pickupID.tr,
                          //                               style: TextStyle(
                          //                                   fontSize: 14,
                          //                                   fontFamily: "Poppins",
                          //                                   color: textSubColor,
                          //                                   fontWeight:
                          //                                   FontWeight.w400)),
                          //                           const Spacer(),
                          //                           Text("Sunday, 4 February, 2024",
                          //                               style: TextStyle(
                          //                                   fontSize: 14,
                          //                                   fontFamily: "Poppins",
                          //                                   color: darkGreenColor,
                          //                                   fontWeight:
                          //                                   FontWeight.w500)),
                          //                         ],
                          //                       ),
                          //                       const SizedBox(height: 15),
                          //                       Row(
                          //                         children: [
                          //                           Text(AppConstants.pickupID.tr,
                          //                               style: TextStyle(
                          //                                   fontSize: 14,
                          //                                   fontFamily: "Poppins",
                          //                                   color: textSubColor,
                          //                                   fontWeight:
                          //                                   FontWeight.w400)),
                          //                           const Spacer(),
                          //                           Text(
                          //                               "Bottles, Newspapers, Induc...",
                          //                               style: TextStyle(
                          //                                   fontSize: 14,
                          //                                   fontFamily: "Poppins",
                          //                                   color: darkGreenColor,
                          //                                   fontWeight:
                          //                                   FontWeight.w500)),
                          //                         ],
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           );
                          //         },
                          //       ),
                          //     ],
                          //   ),
                          // ),
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
                ));
          } else {
            return  Container(height: Get.height,width: Get.width,color: whiteColor, child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
            ));
          }

        });
  }
}
