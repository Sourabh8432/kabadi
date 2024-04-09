import 'dart:convert';

import 'package:get/get.dart';
import 'package:kabadi_app/network/urls.dart';
import 'package:http/http.dart' as http;

import '../../models/pickup_cancel_request.dart';
import '../../models/pickup_reschedule.dart';
import '../../utils/app_prefrences.dart';

class TrackPickupController extends GetxController {

  RxInt currentStep = 0.obs;
  RxBool completed = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void showLoading() {
    isLoading(true);
    update();
  }

  void hideLoading() {
    isLoading(false);
    update();
  }


  Future<void> pickupCancelRequestApi() async {
    try {
      showLoading();
      final url = Uri.parse(Url.pickupCancelRequest);
      final response = await http.get(url,
        headers: {'Authorization': "Bearer ${await AppPrefrence.getString('token')}", 'Accept' : 'application/json'},
      );
      hideLoading();
      PickupCancelRequest pickupCancelRequest = PickupCancelRequest.fromJson(jsonDecode(response.body));
      if (pickupCancelRequest.status == 1) {
        print("message : ${pickupCancelRequest.message}");
      } else {
        print("message : ${pickupCancelRequest.message}");
      }
    } catch (e) {
      print("error : $e");
    }
  }


  Future<void> pickupRescheduleApi() async {
    try {
      showLoading();
      final url = Uri.parse(Url.pickupReschedule);
      final response = await http.get(url,
        headers: {'Authorization': "Bearer ${await AppPrefrence.getString('token')}", 'Accept' : 'application/json'},
      );
      hideLoading();
      PickupReschedule pickupReschedule = PickupReschedule.fromJson(jsonDecode(response.body));
      if (pickupReschedule.status == 1) {


        print("message : ${pickupReschedule.message}");
      } else {
        print("message : ${pickupReschedule.message}");
      }
    } catch (e) {
      print("error : $e");
    }
  }






}