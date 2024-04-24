import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kabadi_app/utils/app_colors.dart';
import 'package:kabadi_app/utils/app_constants.dart';
import 'package:kabadi_app/utils/app_images.dart';
import '../../models/date_list_models.dart';
import '../../models/get_price_list.dart';
import '../../routes/app_pages.dart';
import 'sell_scrap_item_controller.dart';

class SellScrapItemView extends StatelessWidget {
  SellScrapItemView({Key? key});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<SellScrapItemController>(
      init: SellScrapItemController(),
      builder: (controller) {

        return WillPopScope(
          onWillPop: () async {
            if (controller.currentStep.value == 2) {
              controller.isEdit.value = false;
              controller.currentStep.value = 1;
            } else if (controller.currentStep.value == 1) {
              controller.isEdit.value = false;
              controller.currentStep.value = 0;
            } else {
              Get.back();
            }
            controller.update();
            return false;

          },
          child: Scaffold(
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
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                margin:
                                const EdgeInsets.symmetric(horizontal: 20),
                                child: SvgPicture.asset(
                                  AppImages.backArrow,
                                  color: whiteColor,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              "sellScrap".tr,
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
                      const SizedBox(
                        height: 20,
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
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.check,
                                      color: darkGreenColor,
                                    ),
                                  ),
                                  Expanded(
                                      child: Divider(
                                        color: controller.currentStep > 0
                                            ? primaryColor
                                            : borderColor,
                                        thickness: 4,
                                      )),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: controller.currentStep > 0
                                            ? primaryColor
                                            : borderColor,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.check,
                                      color: darkGreenColor,
                                    ),
                                  ),
                                  Expanded(
                                      child: Divider(
                                        color: controller.currentStep > 1
                                            ? primaryColor
                                            : borderColor,
                                        thickness: 4,
                                      )),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: controller.currentStep > 1
                                            ? primaryColor
                                            : borderColor,
                                        shape: BoxShape.circle),
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
                                    "Scrap Items",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Poppins",
                                        color: darkGreenColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 80,
                                  child: Text(
                                    "Schedule Pickup",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Poppins",
                                        color: controller.currentStep > 0
                                            ? darkGreenColor
                                            : textSubColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: 80,
                                  child: Text(
                                    "Confirm",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Poppins",
                                        color: controller.currentStep > 1
                                            ? darkGreenColor
                                            : textSubColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      controller.currentStep == 0
                          ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Select Scrap you want to Sell",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Poppins",
                                    color: darkGreenColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Select scrap items & upload scrap pictures.",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Poppins",
                                    color: textSubColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),

                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics:
                                  const NeverScrollableScrollPhysics(),
                                  itemCount:
                                  controller.getAllPriceList.length,
                                  itemBuilder: (context, index) {
                                    int? categoryId = controller
                                        .getAllPriceList[index].id;
                                    print(
                                        "getAllPriceList : ${controller.getAllPriceList.length}");
                                    return Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          controller
                                              .getAllPriceList[index].name
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Poppins",
                                            color: darkGreenColor,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          height: 80,
                                          child: ListView.builder(
                                            scrollDirection:
                                            Axis.horizontal,
                                            itemCount: controller
                                                .getAllPriceList[index]
                                                .subCategories
                                                ?.length,
                                            itemBuilder:
                                                (context, myIndex) {
                                              GetPriceSubCategories
                                              getList = controller
                                                  .getAllPriceList[
                                              index]
                                                  .subCategories![
                                              myIndex];

                                              bool isSelected = controller
                                                  .selectedSubCategoryIdsMap[
                                              categoryId]
                                                  ?.contains(getList
                                                  .categoryId) ??
                                                  false;

                                              return InkWell(
                                                onTap: () {
                                                  controller.toggleCategorySelection(getList.id ?? 0, getList.categoryId ?? 0, getList.name ?? "", getList.priceUnit ?? "", getList.weightUnit ?? "",controller.submitedId);
                                                  controller.idList = controller.submitedId.map((item) => item.id).toList();
                                                  print("Test : ${controller.idList.runtimeType}");
                                                  controller.myselection = controller.submitedId;
                                                  print("TestTest : ${jsonEncode(controller.myselection)}");
                                                },
                                                child: Container(
                                                  margin:
                                                  const EdgeInsets.only(
                                                      right: 10),
                                                  padding:
                                                  const EdgeInsets.all(
                                                      10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(10),
                                                      border: Border.all(
                                                          color: controller.myselection.any((element) =>
                                                          element.id ==
                                                              getList
                                                                  .id) &&
                                                              controller.myselection.any((element) =>
                                                              element
                                                                  .categoryId ==
                                                                  getList
                                                                      .categoryId)
                                                              ? primaryColor
                                                              : borderColor,
                                                          width: 1)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text(
                                                          getList.name
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontFamily:
                                                              "Poppins",
                                                              color:
                                                              darkGreenColor,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500)),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                          "${getList.priceUnit}/-${getList.weightUnit}",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontFamily:
                                                              "Poppins",
                                                              color:
                                                              textSubColor,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400)),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                const SizedBox(height: 20),
                                Text("Upload Pictures",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Poppins",
                                        color: darkGreenColor,
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(height: 20),
                                Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        controller.uploadImage().then((value) {controller.uploadImageApi(controller.images);
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        child: SvgPicture.asset(
                                            height: 70,
                                            width: 70,
                                            AppImages.emptyImage),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: controller.images
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          final index = entry.key;
                                          final image = entry.value;
                                          return Stack(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    vertical: 10,
                                                    horizontal: 4),
                                                child: InkWell(
                                                  onTap: () {
                                                    controller
                                                        .uploadImage();
                                                  },
                                                  child: Image.file(
                                                    image,
                                                    width: 70,
                                                    height: 70,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                child: GestureDetector(
                                                  onTap: () => controller
                                                      .removeImage(index),
                                                  child: CircleAvatar(
                                                    radius: 13,
                                                    backgroundColor:
                                                    darkGreenColor,
                                                    child: const Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                      size: 15,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                                // Row(
                                //   children: [
                                //     Stack(
                                //       alignment: Alignment.topRight,
                                //       children: [
                                //         InkWell(
                                //           onTap: () {
                                //             controller.uploadImage(
                                //                 context, ImageSource.gallery);
                                //           },
                                //           child: Padding(
                                //             padding: const EdgeInsets.symmetric(vertical: 10,
                                //                 horizontal: 10),
                                //             child:
                                //                 controller.selectedImagePath.isEmpty
                                //                     ? SvgPicture.asset(
                                //                         height: 70,
                                //                         width: 70,
                                //                         AppImages.emptyImage)
                                //                     : Image.file(
                                //                         fit: BoxFit.fill,
                                //                         height: 70,
                                //                         width: 70,
                                //                         File(controller.selectedImagePath.value),
                                //                       ),
                                //           ),
                                //         ),
                                //         controller.selectedImagePath.isNotEmpty?InkWell(onTap: (){
                                //           controller.removeImage();
                                //         },child: Container(padding:const EdgeInsets.all(5),decoration:  BoxDecoration(color: darkGreenColor,shape: BoxShape.circle),child: const Icon(Icons.close,color: Colors.white,size: 15,))):SizedBox(),
                                //       ],
                                //     ),
                                //     Padding(
                                //       padding: const EdgeInsets.symmetric(
                                //           horizontal: 10),
                                //       child: SvgPicture.asset(
                                //           height: 70,
                                //           width: 70,
                                //           AppImages.emptyImage),
                                //     ),
                                //     Padding(
                                //       padding: const EdgeInsets.symmetric(
                                //           horizontal: 10),
                                //       child: SvgPicture.asset(
                                //           height: 70,
                                //           width: 70,
                                //           AppImages.emptyImage),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ],
                      )
                          : controller.currentStep == 1
                          ? Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Select Pickup date",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Poppins",
                                      color: darkGreenColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Select date for your scrap pickup.",
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
                            Container(
                              height: 60,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(40),
                                  border: Border.all(
                                      color: lightGreenColor)),
                              child: InkWell(
                                onTap: () async {
                                  DateList? dateList = await SellScrapItemController.getDateListApi();
                                  if (dateList != null && dateList.data != null && dateList.data!.isNotEmpty) {
                                    controller.selectedDate = await _showDatePickerPopup(context, dateList);
                                    if (controller.selectedDate != null) {
                                      controller.selectedDateTextWidget.value = controller.selectedDate!.dateText!;
                                      controller.selectedDateWidget.value = controller.selectedDate!.date!;
                                      controller.update();
                                    }

                                  }
                                },
                                child: Row(
                                  children: [
                                    Text(
                                        controller.selectedDate != null
                                            ? controller.selectedDateTextWidget.value
                                            : 'Select a date',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Poppins",
                                            color: darkGreenColor,
                                            fontWeight:
                                            FontWeight.w400)),
                                    Spacer(),
                                    const Icon(Icons.arrow_drop_down)
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: SizedBox(
                                child: Text(
                                  "Pickup time between 10am-6pm. Our Pickup executive will contact you before arriving.",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Poppins",
                                    color: textSubColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                          : Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Confirm Pickup",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Poppins",
                                      color: darkGreenColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Confirm your scrap pickup details.",
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 15),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Scrap Items :",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Poppins",
                                            color: darkGreenColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            controller.currentStep.value = 0;
                                            controller.isEdit.value = true;
                                            controller.update();
                                          },
                                          child: Container(
                                            height: 30,
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(40),
                                              border: Border.all(color: primaryColor, width: 1),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.edit,
                                                  color: darkGreenColor,
                                                  size: 18,
                                                ),
                                                const SizedBox(
                                                    width: 10),
                                                Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily:
                                                    "Poppins",
                                                    color:
                                                    darkGreenColor,
                                                    fontWeight:
                                                    FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ListView.builder(shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemCount: controller.myselection.length,itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                      const EdgeInsets.only(top: 15),
                                      child: Row(
                                        children: [
                                          Text(
                                            controller.submitedId[index].name.toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Poppins",
                                              color: textSubColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            "₹${controller.submitedId[index].priceUnit.toString()}/${controller.submitedId[index].weightUnit.toString()}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Poppins",
                                              color: textSubColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },)
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Uploaded Pictures :",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Poppins",
                                            color: darkGreenColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        SizedBox(
                                          height: 120,
                                          child: ListView.builder(
                                            scrollDirection:
                                            Axis.horizontal,
                                            itemCount: controller.getUploadImageUrl.length,
                                            itemBuilder:
                                                (context, index) {
                                              return Container(
                                                margin: const EdgeInsets
                                                    .only(right: 10),
                                                child:Image.network( controller.getUploadImageUrl[index].toString(),
                                                  fit: BoxFit.cover,
                                                  height: 110,
                                                  width: 110,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return Container(alignment: Alignment.center,height: 100, width: 100,decoration: BoxDecoration(color: Colors.black12,borderRadius: BorderRadius.circular(15)),child: Text("No Image",style: TextStyle(fontSize: 10),),);
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 15),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Address :",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Poppins",
                                            color: darkGreenColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            height: 30,
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets
                                                .symmetric(
                                                horizontal: 15),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  40),
                                              border: Border.all(
                                                  color: primaryColor,
                                                  width: 1),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.edit,
                                                  color: darkGreenColor,
                                                  size: 18,
                                                ),
                                                const SizedBox(
                                                    width: 10),
                                                Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily:
                                                    "Poppins",
                                                    color:
                                                    darkGreenColor,
                                                    fontWeight:
                                                    FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 15),
                                    child: Text(
                                      controller.myArguments[1]['address'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Poppins",
                                        color: textSubColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 15),
                                    child: Row(
                                      children: [
                                        Text(
                                          "PickUp :",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "Poppins",
                                            color: darkGreenColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            controller.currentStep.value =1;
                                            controller.isEditDate.value = true;
                                            controller.update();
                                          },
                                          child: Container(
                                            height: 30,
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets
                                                .symmetric(
                                                horizontal: 15),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  40),
                                              border: Border.all(
                                                  color: primaryColor,
                                                  width: 1),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.edit,
                                                  color: darkGreenColor,
                                                  size: 18,
                                                ),
                                                const SizedBox(
                                                    width: 10),
                                                Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily:
                                                    "Poppins",
                                                    color:
                                                    darkGreenColor,
                                                    fontWeight:
                                                    FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                        "${DateFormat('EEEE').format(DateTime.parse(controller.selectedDateWidget.value) )}, ${controller.selectedDateTextWidget.value}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Poppins",
                                            color: darkGreenColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        // Text(
                                        //   "10 AM - 6 PM",
                                        //   style: TextStyle(
                                        //     fontSize: 12,
                                        //     fontFamily: "Poppins",
                                        //     color: textSubColor,
                                        //     fontWeight: FontWeight.w400,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Any Instructions",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Poppins",
                                      color: darkGreenColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: borderColor),
                                        borderRadius:
                                        BorderRadius.circular(100)),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: controller.instructions,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                letterSpacing: 1.6),
                                            decoration: InputDecoration(
                                              hintText: "Write here...",
                                              hintStyle: TextStyle(
                                                fontSize: 14,
                                                fontFamily: "Poppins",
                                                color: textSubColor,
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
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
            bottomNavigationBar: _buildContinue(context),
          ),
        );
      },
    );
  }

  Widget _buildContinue(BuildContext context) {
    SellScrapItemController controller = Get.find();
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              print("isEdit : ${controller.isEdit.value}");

              if(controller.isEdit.value == true || controller.isEditDate.value== true){
                controller.currentStep.value = 2;
              }else {
                if (controller.currentStep.value == 0) {
                  controller.currentStep.value = 1;
                  SellScrapItemController.getDateListApi();
                } else if (controller.currentStep.value == 1) {
                  if(controller.selectedDate== null){
                    Fluttertoast.showToast(msg: "Please Choose Any Date");
                  }else {
                    controller.currentStep.value = 2;
                  }
                } else {
                  controller.getCompleteAPI(context);
                }

              }


              controller.update();
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

  static Future<DateListData?> _showDatePickerPopup(
      BuildContext context, DateList dateList) async {
    return await showDialog<DateListData>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Select Pickup Date',
            style: TextStyle(
              color: Color(0xff003032),
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins",
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: dateList.data!.map((dateData) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pop(dateData); // Return selected dateData
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('EEEE')
                                .format(DateTime.parse(dateData.date!)),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(dateData.dateText!),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }


}
