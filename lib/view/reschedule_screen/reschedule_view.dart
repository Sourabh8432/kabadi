import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kabadi_app/utils/app_colors.dart';
import 'package:kabadi_app/utils/app_constants.dart';
import 'package:kabadi_app/utils/app_images.dart';
import 'reschedule_controller.dart';

class RescheduleView extends StatelessWidget {
  const RescheduleView({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RescheduleController>(
      init: RescheduleController(),
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
                      AppConstants.reschedule,
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
                  onTap: () => _showDatePickerPopup(context),
                  child: Row(
                    children: [
                      Text(
                          "30 January, 2024",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Poppins",
                              color: darkGreenColor,
                              fontWeight: FontWeight.w400)), Spacer(),
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
        );
      },
    );
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
                AppConstants.update,
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

  void _showDatePickerPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Pickup Date', style: TextStyle(
              color: Color(0xff003032),
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins"),),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: const Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Wednesday'),
                        SizedBox(
                          height: 10,
                        ),
                        Text('31 January, 2024'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
