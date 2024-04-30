import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kabadi_app/utils/app_colors.dart';
import 'package:kabadi_app/utils/app_constants.dart';
import 'package:kabadi_app/utils/app_images.dart';
import 'package:kabadi_app/utils/app_prefrences.dart';
import 'package:kabadi_app/view/track_pickup_request/track_pickup_controller.dart';
import '../../models/date_list_models.dart';
import '../sell_scrap_item/sell_scrap_item_controller.dart';
import 'reschedule_controller.dart';

class RescheduleView extends StatelessWidget {
  const RescheduleView({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RescheduleController>(
      init: RescheduleController(),
      builder: (controller) {
        return Stack(
          children: [
            Scaffold(
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
                        InkWell(onTap: (){
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
                        Text(
                          "reschedule".tr,
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
                  const SizedBox(height: 20,),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border:
                        Border.all(color: lightGreenColor)),
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
                    padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: SizedBox(child:  Text(
                      "Pickup time between 10am-6pm. Our Pickup executive will contact you before arriving.",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Poppins",
                        color: textSubColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),),
                  ),

                ],
              ),
              bottomNavigationBar: _buildUpdate(context,controller),
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
        );
      },
    );
  }

  Widget _buildUpdate(BuildContext context , RescheduleController controller) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              if(controller.rescheduleId[0]["type"] == "edited" ){
                AppPrefrence.putString("change_date", controller.selectedDateTextWidget.value);
                controller.pickupRescheduleApi(controller.rescheduleId[0]["data"], );
                TrackPickupController trackPickup = Get.find();
                trackPickup.isEdited.value = true;
                trackPickup.getData();
                print("test : ${controller.rescheduleId[0]["type"]}");

              }else {
                print("test 1");
                controller.pickupRescheduleApi(controller.rescheduleId[0]["data"], );
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
                "update".tr,
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
