import 'dart:convert';
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:kabadi_app/network/urls.dart';

import '../../models/get_pickup_list.dart';
import '../../models/pickup_request_models.dart';
import '../../routes/app_pages.dart';
import '../../utils/app_prefrences.dart';

class MyPickupController extends GetxController {
  RxBool isLoading = false.obs;

  PickupRequestData? pickupRequestsList;




  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pickupRequestsApi();

    print("pickupRequestsList : $pickupRequestsList");
  }



  void showLoading() {
    isLoading(true);
    update();
  }

  void hideLoading() {
    isLoading(false);
    update();
  }




  Future<void> pickupRequestsApi() async {

    // try {
      showLoading();
      final url = Uri.parse(Url.getPickupListUrl);
      final response = await http.get(
        url,
        headers: {
          // 'Authorization': "Bearer 2|hpcofkhacU6Hdah5YKZAhC9rqeblJH23Ub8blyVU66db5add",
          'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
      );
      print("pickupRequestModels : ${jsonDecode(response.body)}");
      hideLoading();
      PickupRequestModels pickupRequestModels = PickupRequestModels.fromJson(jsonDecode(response.body));
      print("pickupRequestModels : ${jsonEncode(pickupRequestModels)}");

      if (pickupRequestModels.status == 1) {
        pickupRequestsList = pickupRequestModels.data!;
        Fluttertoast.showToast(msg: "${pickupRequestModels.message}");
        log("message : ${jsonEncode(pickupRequestModels.data)}");
      } else {
        Fluttertoast.showToast(msg: "${pickupRequestModels.message}");
        print("message : ${pickupRequestModels.message}");
      }
    // } catch (e) {
    //   print("error : $e");
    // }
  }


}
