import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../routes/app_pages.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_images.dart';
import 'add_new_address_controller.dart';

class AddNewAddressView extends StatelessWidget {
  const AddNewAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNewAddressController>(
        init: AddNewAddressController(),
        builder: (controller) {
          print( "markerLocation: ${controller.markerLocation.latitude}, Lng: ${controller.markerLocation.longitude}");
          return Scaffold(
            body: Stack(
              alignment: Alignment.topCenter,
              children: [
                GoogleMap(
                  onMapCreated: (myController) {
                    _onMapCreated(myController);
                  },
                  initialCameraPosition: CameraPosition(
                    target: controller.markerLocation,
                    zoom: 10,
                  ),
                  markers: <Marker>{
                    Marker(
                      markerId: const MarkerId("1"),
                      position: controller.markerLocation,
                      infoWindow: InfoWindow(
                        title: "Marker",
                        snippet:
                        "Lat: ${controller.markerLocation.latitude}, Lng: ${controller.markerLocation.longitude}",
                      ),
                      onTap: () {
                        _onMapTap(controller.markerLocation);
                      },
                    ),
                  },
                  circles: <Circle>{
                    Circle(
                      circleId: const CircleId("radius"),
                      center: controller.markerLocation,
                      radius: 500,
                      fillColor: Colors.red.withOpacity(0.2),
                      strokeColor: Colors.red,
                      strokeWidth: 2,
                    ),
                  },
                  onTap: _onMapTap, // Disable map tap when dataCount is 60
                  zoomControlsEnabled: false,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                          GestureDetector(
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
                          Text(AppConstants.setLocation,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Poppins",
                                  color: whiteColor,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1, color: borderColor),
                          borderRadius: BorderRadius.circular(100)),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              // controller: controller.yourName,
                              style: const TextStyle(
                                  fontSize: 18, letterSpacing: 1.6),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: 20,
                                  color: darkGreenColor,
                                ),
                                border: InputBorder.none,
                                hintText: "${controller.mapLatitude.value}, ${controller.mapLongitude.value}",
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: textSubColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => _showBottomSheet(context, controller),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(50),
                            ),
                            color: primaryColor),
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(
                          AppConstants.continue_text,
                          style: TextStyle(
                              fontSize: 16,
                              color: darkGreenColor,
                              fontFamily: "MPLUS",
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  void _onMapCreated(GoogleMapController controller) {
    AddNewAddressController addNewAddressController = Get.find();
    addNewAddressController.mapController = controller;
    addNewAddressController.update();
  }

  void _onMapTap(LatLng location) {
    AddNewAddressController addNewAddressController = Get.find();
    addNewAddressController.markerLocation = location;

    addNewAddressController.mapLatitude.value = location.latitude;
    addNewAddressController.mapLongitude.value = location.longitude;
    addNewAddressController.update();
    print(
        "Marker tapped at: ${addNewAddressController.mapLatitude.value}, ${addNewAddressController.mapLongitude.value}");
  }

  void _showBottomSheet(BuildContext context, controller) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                        color: whiteColor, shape: BoxShape.circle),
                    child: Icon(
                      Icons.close,
                      color: darkGreenColor,
                    ))),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  )),
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppConstants.addAddress,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Poppins",
                          color: darkGreenColor,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppConstants.addAddressSubTitle,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Poppins",
                          color: textSubColor,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppConstants.yourLocation,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Poppins",
                          color: textSubColor,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Jhotwara, Jaipur",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Poppins",
                          color: darkGreenColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                height: 40,
                                width: 40,
                                AppImages.addCatogary,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Office",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Poppins",
                                  color: darkGreenColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Locality",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Poppins",
                          color: textSubColor,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: borderColor, width: 1),
                        borderRadius: BorderRadius.circular(40)),
                    child: TextField(
                      // controller: controller.yourName,
                      style: const TextStyle(fontSize: 18, letterSpacing: 1.6),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          size: 20,
                          color: darkGreenColor,
                        ),
                        border: InputBorder.none,
                        hintText: "Search address ",
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: textSubColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Address Line",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Poppins",
                          color: textSubColor,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: borderColor, width: 1),
                        borderRadius: BorderRadius.circular(40)),
                    child: TextField(
                      // controller: controller.yourName,
                      style: const TextStyle(fontSize: 18, letterSpacing: 1.6),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          size: 20,
                          color: darkGreenColor,
                        ),
                        border: InputBorder.none,
                        hintText: "Sanjay Nagar B, Kalwar Road",
                        hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: textSubColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.addNewAddressView);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          border: Border.all(width: 2, color: primaryColor),
                          borderRadius: BorderRadius.circular(100)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 20,
                            color: darkGreenColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            AppConstants.addNewAddress,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Poppins",
                                color: darkGreenColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // Widget _buildContinue(BuildContext context, controller) {
  //   return Expanded(
  //     child: GestureDetector(
  //
  //       child: Container(
  //         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  //         decoration: BoxDecoration(
  //             borderRadius: const BorderRadius.all(
  //               Radius.circular(50),
  //             ),
  //             color: primaryColor),
  //         alignment: Alignment.center,
  //         height: 50,
  //         child: Text(
  //           AppConstants.pickupRequest,
  //           style: TextStyle(
  //               fontSize: 16,
  //               color: darkGreenColor,
  //               fontFamily: "MPLUS",
  //               fontWeight: FontWeight.w500),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
