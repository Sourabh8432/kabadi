import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kabadi_app/utils/app_colors.dart';
import 'package:kabadi_app/utils/app_constants.dart';
import 'package:kabadi_app/utils/app_images.dart';
import 'package:pinput/pinput.dart';
import '../../models/get_complete_list.dart';
import '../../routes/app_pages.dart';
import '../my_pickup_requests/my_pickup_controller.dart';
import '../sell_scrap/sellscrap_controller.dart';
import 'track_pickup_controller.dart';

class TrackPickupView extends StatelessWidget {
  TrackPickupView({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrackPickupController>(
      init: TrackPickupController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            if (controller.myData[0]["type"] != "SellScrapItem") {
              controller.myPickup.pickupRequestsApi();
              print("Test Code : ${controller.myData[0]["type"]}");
            }

            return true;
          },
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  height: 111,
                  padding: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.pickupAppbar),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (controller.myData[0]["type"] == "SellScrapItem") {
                            Get.toNamed(Routes.sellScrapView);
                            SellScrapController listData = Get.find();
                            listData.selectedIds.clear();
                          } else {

                            controller.myPickup.pickupRequestsApi();
                            Get.back();
                          }
                        },
                        child: SizedBox(
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
                              const SizedBox(width: 15),
                              Text(
                                "trackPickupRequest".tr,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Poppins",
                                  color: whiteColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      (controller.myData[0]["data"].pickupStatus == "Confirmed" ||controller.myData[0]["data"].pickupStatus ==
                          "Pickup" ) ? SizedBox(): Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: PopupMenuButton<String>(
                          icon: const Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                          ),
                          onSelected: (value) {
                            if (value == "reschedule") {
                              Get.toNamed(Routes.rescheduleView, arguments: [
                                {
                                  "type": "edited",
                                  "data": controller
                                      .myData[0]["data"].pickupRequestId,
                                }
                              ]);
                            } else {
                              controller.pickupCancelListApi().then((value) {
                                _showCancelPopup(context, controller);
                              });
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              const PopupMenuItem<String>(
                                value: 'reschedule',
                                child: Text('Reschedule'),
                              ),
                              const PopupMenuItem<String>(
                                value: 'cancel',
                                child: Text('Cancel'),
                              ),
                            ];
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "trackyourPickup".tr,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Poppins",
                          color: darkGreenColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "trackyourPickupSubText".tr,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Poppins",
                          color: textSubColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check,
                                color: darkGreenColor,
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color:
                                (controller.myData[0]["data"].pickupStatus == "Confirmed" ||controller.myData[0]["data"].pickupStatus ==
                                    "Pickup" )
                                        ? primaryColor
                                        : borderColor,
                                thickness: 4,
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color:
                                    (controller.myData[0]["data"].pickupStatus == "Confirmed" ||controller.myData[0]["data"].pickupStatus ==
                                        "Pickup" )
                                        ? primaryColor
                                        : borderColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check,
                                color: darkGreenColor,
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color:
                                    controller.myData[0]["data"].pickupStatus ==
                                            "Pickup"
                                        ? primaryColor
                                        : borderColor,
                                thickness: 4,
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color:
                                    controller.myData[0]["data"].pickupStatus ==
                                            "Pickup"
                                        ? primaryColor
                                        : borderColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check,
                                color: darkGreenColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(
                            width: 80,
                            child: Text(
                              "requestReceived".tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Poppins",
                                color: darkGreenColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 80,
                            child: Text(
                              "requestAssigned".tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Poppins",
                                color: controller.currentStep > 0
                                    ? darkGreenColor
                                    : textSubColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 80,
                            child: Text(
                              "outForPickup".tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Poppins",
                                color: controller.currentStep > 1
                                    ? darkGreenColor
                                    : textSubColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Expected Pickup :",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Poppins",
                              color: darkGreenColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          (controller.myData[0]["data"].pickupStatus == "Confirmed" ||controller.myData[0]["data"].pickupStatus ==
                              "Pickup" ) ? SizedBox():InkWell(
                            onTap: () {
                              Get.toNamed(Routes.rescheduleView, arguments: [
                                {
                                  "type": "edited",
                                  "data": controller
                                      .myData[0]["data"].pickupRequestId,
                                }
                              ]);
                            },
                            child: Container(
                              height: 30,
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                border:
                                    Border.all(color: primaryColor, width: 1),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: darkGreenColor,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Reschedule",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Poppins",
                                      color: darkGreenColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.isEdited.value == true
                                ? controller.editedData.value
                                : controller.myData[0]["data"].pickupDate
                                    .toString(),
                            // controller.myData.pickupDate ?? "",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Poppins",
                              color: darkGreenColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            controller.myData[0]["data"].pickupTime.toString(),
                            // controller.myData.pickupTime ?? "",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Poppins",
                              color: textSubColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Scrap Items :",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Poppins",
                          color: darkGreenColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                          itemCount:
                              controller.myData[0]["data"].pickupItems.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var items =
                                controller.myData[0]["data"].pickupItems[index];
                            // controller.myData.pickupItems?[index];
                            return Container(
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: borderColor, width: 1),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Text(
                                items.priceListName ?? "",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Poppins",
                                  color: darkGreenColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Address :",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Poppins",
                          color: darkGreenColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller
                                .myData[0]["data"].pickupAddress.locationType
                                .toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Poppins",
                              color: darkGreenColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${controller.myData[0]["data"].pickupAddress.locality.toString()}, ${controller.myData[0]["data"].pickupAddress.addressLine.toString()}",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Poppins",
                              color: textSubColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Pickup Instructions :",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Poppins",
                          color: darkGreenColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        controller.myData[0]["data"].pickupInstructions
                            .toString(),
                        // controller.myData.pickupInstructions ?? "",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Poppins",
                          color: textSubColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCancelPopup(
      BuildContext context, TrackPickupController controller) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (buildContext) {
        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: AlertDialog(
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            backgroundColor: whiteColor,
            alignment: Alignment.center,
            title: Text(
              'Cancel Pickup Request',
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Poppins",
                color: darkGreenColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Center(
                    child: Text(
                      'Tell us the reason you want to cancel the Scrap Pickup Request.',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: textSubColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.maxFinite,
                  height: Get.height / 3,
                  child: ListView.builder(
                    itemCount: controller.getReasonList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (subContext, index) {
                      return _buildRadioButton(
                          controller.getReasonList[index].reason.toString(),
                          controller.getReasonList[index].cancelReasonId
                              .toString(),
                          controller);
                    },
                  ),
                ),
                // Column(
                //   children: [
                //     _buildRadioButton('I will not be available at the Address', controller),
                //     _buildRadioButton('Already sold to another Vendor', controller),
                //     _buildRadioButton('Duplicate Request by Mistake', controller),
                //     _buildRadioButton('Pickup not on Time', controller),
                //     _buildRadioButton('Rate Issue', controller),
                //   ],
                // ),
              ],
            ),
            actions: [
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text('Don\'t Cancel'),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.back();
                  controller.pickupCancelRequestApi(
                      context, controller.selectedValue.value);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(width: 1, color: borderColor),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Text('Cancel'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // void _showCancelPopup(BuildContext context, TrackPickupController controller) {
  //   showDialog(
  //     context: context,
  //     builder: (buildContext) {
  //       return AlertDialog(
  //         insetPadding: EdgeInsets.zero,
  //         //contentPadding: EdgeInsets.zero,
  //         clipBehavior: Clip.antiAliasWithSaveLayer,
  //         backgroundColor: whiteColor,
  //         alignment: Alignment.center,
  //         title: Text(
  //           'Cancel Pickup Request',
  //           style: TextStyle(
  //             fontSize: 20,
  //             fontFamily: "Poppins",
  //             color: darkGreenColor,
  //             fontWeight: FontWeight.w600,
  //           ),
  //         ),
  //         content: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text(
  //               'Tell us the reason you want to cancel the Scrap Pickup Request.',
  //               style: TextStyle(
  //                 fontSize: 14,
  //                 fontFamily: "Poppins",
  //                 color: textSubColor,
  //                 fontWeight: FontWeight.w400,
  //               ),
  //             ),
  //             const SizedBox(height: 20),
  //             SizedBox(
  //               width: double.maxFinite,
  //               height: Get.height/3,
  //               child: ListView.builder(
  //                 itemCount: controller.getReasonList.length,
  //                 physics: const NeverScrollableScrollPhysics(),
  //                 shrinkWrap: true,itemBuilder: (context, index) {
  //                 return _buildRadioButton(controller.getReasonList[index].reason.toString(), controller);
  //               },),
  //             ),
  //             // Column(
  //             //   children: [
  //             //     _buildRadioButton('I will not be available at the Address', controller),
  //             //     _buildRadioButton('Already sold to another Vendor', controller),
  //             //     _buildRadioButton('Duplicate Request by Mistake', controller),
  //             //     _buildRadioButton('Pickup not on Time', controller),
  //             //     _buildRadioButton('Rate Issue', controller),
  //             //   ],
  //             // ),
  //           ],
  //         ),
  //         actions: [
  //
  //           const SizedBox(height: 15,),
  //           InkWell(
  //             onTap: () {
  //               Get.back();
  //             },
  //             child: Container(
  //               padding: const EdgeInsets.all(10),
  //               child: const Text('Don\'t Cancel'),
  //             ),
  //           ),
  //           InkWell(
  //             onTap: () {
  //               // controller.pickupCancelRequestApi(controller.getReasonList[i].cancelReasonId.toString()).then((value) {
  //               //   Get.toNamed(Routes.requestCancelledView);
  //               // }
  //
  //
  //             },
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(40),
  //                 border: Border.all(width: 1, color: borderColor),
  //               ),
  //               padding: const EdgeInsets.all(10),
  //               child: const Text('Cancel'),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Widget _buildRadioButton(
      String label, String cancelId, TrackPickupController controller) {
    return Obx(() {
      final mySelectedValue = controller.selectedValue.value;

      return Row(
        children: [
          Radio<String>(
            value: cancelId,
            groupValue: mySelectedValue,
            onChanged: (value) {
              print(" Id : $value");
              controller.setSelectedValue(value ?? '');
            },
          ),
          Text(label),
        ],
      );
    });
  }
}
