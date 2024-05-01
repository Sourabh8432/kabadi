import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kabadi_app/network/urls.dart';
import 'package:http/http.dart' as http;

import '../../models/cancel_list_models.dart';
import '../../models/get_complete_list.dart';
import '../../models/pickup_cancel_request.dart';
import '../../models/pickup_reschedule.dart';
import '../../routes/app_pages.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_prefrences.dart';

class TrackPickupController extends GetxController {
  RxInt currentStep = 0.obs;
  RxBool completed = false.obs;
  RxBool isLoading = false.obs;
  RxBool isEdited = false.obs;
  var myData = Get.arguments;
  RxString selectedValue = "".obs;
  RxString selectedId = "".obs;
  RxString pickupID = "".obs;
  RxString editedData = "".obs;
  List<CancelListData> getReasonList = [];


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
    log("myData : ${myData[0]["type"]}");
  }

  void showLoading() {
    isLoading(true);
    update();
  }

  void hideLoading() {
    isLoading(false);
    update();
  }

  void getData () async{
    editedData.value = await AppPrefrence.getString("change_date");
    print("editedData.value :${editedData.value}");
    print("myData :${myData}");
    update();
  }

  void setSelectedValue(String value) {
    selectedValue.value = value;
  }

  Future<void> pickupCancelListApi() async {
    try {
      showLoading();
      final url = Uri.parse(Url.cancelReasonUrl);
      final response = await http.get(
        url,
        headers: {
          'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
          'Accept': 'application/json'
        },
      );
      hideLoading();
      CancelList cancelList =
      CancelList.fromJson(jsonDecode(response.body));
      print("data : ${jsonEncode(cancelList.data)}");
      if (cancelList.status == 1) {
        getReasonList = cancelList.data!;
        Fluttertoast.showToast(msg: "${cancelList.message}");
        print("message : ${cancelList.message}");
      } else {
        Fluttertoast.showToast(msg: "${cancelList.message}");
        print("message : ${cancelList.message}");
      }
    } catch (e) {
      print("error : $e");
    }
  }

  Future<void> pickupCancelRequestApi(BuildContext context, String cancelId) async {
    print("cancelId : ${jsonEncode(cancelId)}");
    try {
      showLoading();
      final url = Uri.parse(Url.pickupCancelRequest);
      final response = await http.post(
          url,
          headers: {
            'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
            'Accept': 'application/json'
          },
          body: {
            'pickup_request_id': myData[0]["data"].pickupRequestId,
            'cancel_id': cancelId
          }
      );
      hideLoading();
      PickupCancelRequest pickupCancelRequest =
      PickupCancelRequest.fromJson(jsonDecode(response.body));
      print("pickupCancelRequest : ${jsonEncode(pickupCancelRequest)}");
      if (pickupCancelRequest.status == 1) {
        pickupID.value = pickupCancelRequest.data!.pickupRequestId!;
        _showPickupRequestCancel(context, pickupID.value);
        Fluttertoast.showToast(msg: "${pickupCancelRequest.message}");
        print("message : ${pickupCancelRequest.message}");
      } else {
        Fluttertoast.showToast(msg: "${pickupCancelRequest.message}");
        print("message : ${pickupCancelRequest.message}");
      }
    } catch (e) {
      print("error : $e");
    }
  }
  void _showPickupRequestCancel(BuildContext context,String selectValue,) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (buildContext) {
        return Padding(
          padding: const EdgeInsets.only(left: 16,right: 16),
          child: AlertDialog(
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            backgroundColor: whiteColor,
            alignment: Alignment.center,
            title: Text(
              'Pickup Request Cancelled',
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
                  padding: const EdgeInsets.only(left: 16,right: 16),
                  child: Center(
                    child: Text(
                      'Your Scrap pickup Request with Request ID:#$selectValue has been Cancelled.',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        color: textSubColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),

              ],
            ),
            actions: [

              const SizedBox(height: 15,),

              InkWell(
                onTap: () {
                  // clearData();
                  Get.toNamed(Routes.myPickupView);

                },

                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(width: 1, color: borderColor),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  child: const Text('Go to Home'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

