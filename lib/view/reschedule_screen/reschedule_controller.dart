import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kabadi_app/network/urls.dart';
import 'package:http/http.dart' as http;
import '../../models/date_list_models.dart';
import '../../models/pickup_reschedule.dart';
import '../../utils/app_prefrences.dart';
import '../track_pickup_request/track_pickup_controller.dart';

class RescheduleController extends GetxController {
  RxBool isLoading = false.obs;
  DateListData? selectedDate;
  RxString selectedDateTextWidget = "".obs;
  RxString selectedDateWidget = "".obs;
  String rescheduleId = Get.arguments;
  TrackPickupController trackPickup = Get.find();


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

  static Future<DateList?> getDateListApi() async {
    try {
      final url = Uri.parse(Url.pickupDate); // Replace with your API endpoint
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${await AppPrefrence.getString('token')}',
          'Accept': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        return DateList.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load date list');
      }
    } catch (e) {
      print('API Error: $e');
      throw e;
    }
  }

  Future<void> pickupRescheduleApi(String pickUpId) async {
    print("pickUpId : $pickUpId");
    DateTime parsedDate = DateFormat("d MMMM, yyyy").parse(selectedDateTextWidget.value);
    String formattedDate = DateFormat("yyyy-MM-dd").format(parsedDate);
    print("formattedDate : $formattedDate");


    try {
      showLoading();
      final url = Uri.parse(Url.pickupReschedule);
      final response = await http.post(url, headers: {
        'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
        'Accept': 'application/json'
      },
          body: {
        'pickup_request_id': pickUpId,
        'pickup_date': formattedDate
      });
      hideLoading();
      PickupReschedule pickupReschedule =
      PickupReschedule.fromJson(jsonDecode(response.body));
      if (pickupReschedule.status == 1) {

        Get.back();
        trackPickup.update();
        print("message : ${pickupReschedule.message}");
      } else {
        print("message : ${pickupReschedule.message}");
      }
    } catch (e) {
      print("error : $e");
    }
  }
}