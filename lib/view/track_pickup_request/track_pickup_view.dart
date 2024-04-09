import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kabadi_app/utils/app_colors.dart';
import 'package:kabadi_app/utils/app_constants.dart';
import 'package:kabadi_app/utils/app_images.dart';
import '../../routes/app_pages.dart';
import 'track_pickup_controller.dart';

class TrackPickupView extends StatelessWidget {
  TrackPickupView({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TrackPickupController>(
      init: TrackPickupController(),
      builder: (controller) {
        return Scaffold(
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
                      AppConstants.trackPickupRequest,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Poppins",
                        color: whiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: PopupMenuButton<String>(
                        icon: const Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                        ),
                        onSelected: (value) {
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
                      AppConstants.trackyourPickup,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Poppins",
                        color: darkGreenColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      AppConstants.trackyourPickupSubText,
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
                child: Column(crossAxisAlignment: CrossAxisAlignment.center,
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
                                color: primaryColor, shape: BoxShape.circle),
                            child: Icon(
                              Icons.check,
                              color: darkGreenColor,
                            ),
                          ),
                          Expanded(child: Divider(color: primaryColor,thickness: 4,)),
                          Container(
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: primaryColor, shape: BoxShape.circle),
                            child: Icon(
                              Icons.check,
                              color: darkGreenColor,
                            ),
                          ),
                          Expanded(child: Divider(color: primaryColor,thickness: 4,)),
                          Container(
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: primaryColor, shape: BoxShape.circle),
                            child: Icon(
                              Icons.check,
                              color: darkGreenColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(children: [
                      SizedBox(width: 80,
                        child: Text(
                        AppConstants.requestReceived,
                          textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Poppins",
                            color: primaryColor,
                            fontWeight: FontWeight.w500),
                                            ),
                      ),
                      const Spacer(),
                      SizedBox(width: 80,
                        child: Text(
                          AppConstants.requestAssigned,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Poppins",
                              color: primaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(width: 80,
                        child: Text(
                          AppConstants.outForPickup,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Poppins",
                              color: primaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],),
                  ],
                ),
              ),
               const SizedBox(height: 20,),
               Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        InkWell(onTap: (){
                          Get.toNamed(Routes.rescheduleView);
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
                    const SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sunday, 4 February, 2024",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Poppins",
                            color: darkGreenColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "10 AM - 6 PM",
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
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        itemCount: 5,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: borderColor, width: 1),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Text(
                              "Soft Plastic",
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
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Address :",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: darkGreenColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Office",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Poppins",
                            color: darkGreenColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "370- Sanjay nagar B, Kalwar Road, Jaipur",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: "Poppins",
                            color: textSubColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Pickup Instructions :",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: darkGreenColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Please call me before coming to pickup the scrap. And bring a big truck with you. I have so much of scrap.",
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
        );
      },
    );
  }

  void _showCancelPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: whiteColor,
          alignment: Alignment.center,
          title: Text('Cancel Pickup Request',
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Poppins",
                color: darkGreenColor,
                fontWeight: FontWeight.w600,
              )),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Tell us the reason you want to cancel the Scrap Pickup Request.',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Poppins",
                  color: textSubColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  _buildRadioButton('I will not be available at the Address'),
                  _buildRadioButton('I will not be available at the Address'),
                  _buildRadioButton('Already sold to another Vendor'),
                  _buildRadioButton('Duplicate Request by Mistake'),
                  _buildRadioButton('Pickup not on Time'),
                  _buildRadioButton('Rate Issue'),
                ],
              ),
            ],
          ),
          actions: [
            InkWell(onTap: (){
              Get.back();
            },
              child: Container(
                padding: const EdgeInsets.all(10),
                child: const Text('Don\'t Cancel'),
              ),
            ),
            InkWell(onTap: (){
              Get.toNamed(Routes.requestCancelledView);
            },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(width: 1, color: borderColor)),
                padding: const EdgeInsets.all(10),
                child: const Text('Cancel'),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRadioButton(String label) {
    String? selectedValue;

    return Row(
      children: [
        Radio<String?>(
          value: label,
          groupValue: selectedValue,
          onChanged: (String? value) {
            // Handle radio button selection
            selectedValue = value;
          },
        ),
        Text(label),
      ],
    );
  }


}
