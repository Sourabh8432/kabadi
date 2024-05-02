import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kabadi_app/utils/app_colors.dart';
import 'package:kabadi_app/utils/app_constants.dart';
import 'package:kabadi_app/utils/app_images.dart';
import 'request_cancelled_controller.dart';

class RequestCancelledView extends StatelessWidget {
  const RequestCancelledView({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestCancelledController>(
      init: RequestCancelledController(),
      builder: (controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  height: 100,
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
                        controller.myPreviousData.pickupStatus !="Completed" ?"cancelled".tr : "completed".tr,
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
                Container(
                  height: 300,width: Get.width,
                  margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  child: Image.asset( controller.myPreviousData.pickupStatus !="Completed" ?AppImages.cancelImage:AppImages.completedImage,fit: BoxFit.fill,),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.myPreviousData.pickupStatus !="Completed" ?"Request Cancel":"Request Completed",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Poppins",
                          color: darkGreenColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        controller.myPreviousData.pickupStatus !="Completed" ?"This Scrap Pickup request has been cancelled.": "This Scrap Pickup request has been Completed.",
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Request ID :",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Poppins",
                          color: darkGreenColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "#${controller.myPreviousData.pickupRequestId.toString()}",
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
                // controller.myPreviousData.pickupStatus =="Completed" ?Padding(
                //   padding:
                //   const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         "Pickup Request Date :",
                //         style: TextStyle(
                //           fontSize: 16,
                //           fontFamily: "Poppins",
                //           color: darkGreenColor,
                //           fontWeight: FontWeight.w400,
                //         ),
                //       ),
                //       const SizedBox(height: 5),
                //       Column(crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             controller.myPreviousData.pickupDate.toString(),
                //             style: TextStyle(
                //               fontSize: 14,
                //               fontFamily: "Poppins",
                //               color: darkGreenColor,
                //               fontWeight: FontWeight.w400,
                //             ),
                //           ),
                //           const SizedBox(height: 5),
                //           Text(
                //             controller.myPreviousData.pickupTime.toString(),
                //             style: TextStyle(
                //               fontSize: 14,
                //               fontFamily: "Poppins",
                //               color: textSubColor,
                //               fontWeight: FontWeight.w400,
                //             ),
                //           ),
                //         ],
                //       ),
                //       const SizedBox(height: 10),
                //     ],
                //   ),
                // ):SizedBox(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pickup :",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Poppins",
                          color: darkGreenColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.myPreviousData.pickupDate.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Poppins",
                              color: darkGreenColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            controller.myPreviousData.pickupTime.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Poppins",
                              color: textSubColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                controller.myPreviousData.pickupStatus !="Completed" ?Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cancellation Reason :",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Poppins",
                          color: darkGreenColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        controller.myPreviousData.pickupCancellationReason.toString(),
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
                ):SizedBox(),
                controller.myPreviousData.pickupStatus =="Completed" ?Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Address :",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Poppins",
                          color: darkGreenColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.myPreviousData.pickupAddress.locationType.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Poppins",
                              color: darkGreenColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            controller.myPreviousData.pickupAddress.addressLine.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Poppins",
                              color: textSubColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ):SizedBox(),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Scrap Items :",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Poppins",
                          color: darkGreenColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(height: 75,
                        child: ListView.builder(scrollDirection: Axis.horizontal,
                          itemCount: controller.myPreviousData.pickupItems?.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: borderColor, width: 1)),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                                Text(controller.myPreviousData.pickupItems![index].categoryName.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Poppins",
                                        color: darkGreenColor,
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("${controller.myPreviousData.pickupItems![index].priceUnit.toString()} / ${controller.myPreviousData.pickupItems![index].weightUnit.toString()}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Poppins",
                                        color: textSubColor,
                                        fontWeight: FontWeight.w400)),
                              ],),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                controller.myPreviousData.pickupStatus =="Completed" ?Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment :",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Poppins",
                          color: darkGreenColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cash ${controller.myPreviousData.payment.toString()} ",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Poppins",
                              color: darkGreenColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ):SizedBox(),
                controller.myPreviousData.pickupStatus =="Completed" ?Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Remarks :",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Poppins",
                          color: darkGreenColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cash ${controller.myPreviousData.remark.toString()} ",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Poppins",
                              color: darkGreenColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ):SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }

// Column(
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: [
//     Row(
//       children: [
//         Text(
//           "Expected Pickup :",
//           style: TextStyle(
//             fontSize: 12,
//             fontFamily: "Poppins",
//             color: textSubColor,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         const Spacer(),
//         Container(
//           height: 40,
//           alignment: Alignment.center,
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(40),
//             border: Border.all(color: primaryColor, width: 1),
//           ),
//           child: Row(
//             children: [
//               Icon(
//                 Icons.edit,
//                 color: darkGreenColor,
//                 size: 18,
//               ),
//               const SizedBox(width: 10),
//               Text(
//                 "Reschedule",
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontFamily: "Poppins",
//                   color: darkGreenColor,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Sunday, 4 February, 2024",
//           style: TextStyle(
//             fontSize: 14,
//             fontFamily: "Poppins",
//             color: darkGreenColor,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         const SizedBox(height: 5),
//         Text(
//           "10 AM - 6 PM",
//           style: TextStyle(
//             fontSize: 12,
//             fontFamily: "Poppins",
//             color: textSubColor,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         const SizedBox(height: 10),
//       ],
//     ),
//     Text(
//       "Scrap Items :",
//       style: TextStyle(
//         fontSize: 12,
//         fontFamily: "Poppins",
//         color: textSubColor,
//         fontWeight: FontWeight.w600,
//       ),
//     ),
//     const SizedBox(
//       height: 15,
//     ),
//     SizedBox(
//       height: 40,
//       child: ListView.builder(
//         itemCount: 5,
//         shrinkWrap: true,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) {
//           return Container(
//             alignment: Alignment.center,
//             padding: EdgeInsets.symmetric(horizontal: 15),
//             margin: const EdgeInsets.only(right: 10),
//             decoration: BoxDecoration(
//               border: Border.all(color: borderColor, width: 1),
//               borderRadius: BorderRadius.circular(40),
//             ),
//             child: Text(
//               "Soft Plastic",
//               style: TextStyle(
//                 fontSize: 14,
//                 fontFamily: "Poppins",
//                 color: darkGreenColor,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           );
//         },
//       ),
//     ),
//     const SizedBox(
//       height: 15,
//     ),
//     Text(
//       "Address :",
//       style: TextStyle(
//         fontSize: 12,
//         fontFamily: "Poppins",
//         color: textSubColor,
//         fontWeight: FontWeight.w600,
//       ),
//     ),
//     const SizedBox(
//       height: 15,
//     ),
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Office",
//           style: TextStyle(
//             fontSize: 14,
//             fontFamily: "Poppins",
//             color: darkGreenColor,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         const SizedBox(height: 5),
//         Text(
//           "370- Sanjay nagar B, Kalwar Road, Jaipur",
//           style: TextStyle(
//             fontSize: 12,
//             fontFamily: "Poppins",
//             color: textSubColor,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//       ],
//     ),
//     const SizedBox(
//       height: 15,
//     ),
//     Text(
//       "Pickup Instructions :",
//       style: TextStyle(
//         fontSize: 12,
//         fontFamily: "Poppins",
//         color: textSubColor,
//         fontWeight: FontWeight.w600,
//       ),
//     ),
//     const SizedBox(
//       height: 10,
//     ),
//     Text(
//       "Please call me before coming to pickup the scrap. And bring a big truck with you. I have so much of scrap.",
//       style: TextStyle(
//         fontSize: 12,
//         fontFamily: "Poppins",
//         color: textSubColor,
//         fontWeight: FontWeight.w400,
//       ),
//     ),
//   ],
// ),
}
