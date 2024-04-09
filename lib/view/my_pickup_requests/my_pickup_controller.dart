import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:get/get.dart';
import 'package:kabadi_app/network/urls.dart';

import '../../models/get_pickup_list.dart';
import '../../models/pickup_request_models.dart';
import '../../utils/app_prefrences.dart';

class MyPickupController extends GetxController {
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

  // Future<void> getPickUpApi() async {
  //   try {
  //     showLoading();
  //     final url = Uri.parse(Url.getPickupListUrl);
  //     final response = await http.get(url,
  //       headers: {'Authorization': "authToken", 'Accept' : 'application/json'},
  //     );
  //     hideLoading();
  //     GetPickupList getPickupList = GetPickupList.fromJson(jsonDecode(response.body));
  //     if (getPickupList.status == 1) {
  //
  //
  //       print("message : ${getPickupList.message}");
  //     } else {
  //       print("message : ${getPickupList.message}");
  //     }
  //   } catch (e) {
  //     print("error : $e");
  //   }
  // }


  Future<void> pickupRequestModelsApi() async {
    try {
      showLoading();
      final url = Uri.parse(Url.pickupRequest);
      final response = await http.get(url,
        headers: {'Authorization': "Bearer ${await AppPrefrence.getString('token')}", 'Accept' : 'application/json'},
      );
      hideLoading();
      PickupRequestModels pickupRequestModels = PickupRequestModels.fromJson(jsonDecode(response.body));
      if (pickupRequestModels.status == 1) {
        print("message : ${pickupRequestModels.message}");
      } else {
        print("message : ${pickupRequestModels.message}");
      }
    } catch (e) {
      print("error : $e");
    }
  }


}