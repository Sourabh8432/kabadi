import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kabadi_app/models/login_models.dart';
import 'package:kabadi_app/network/urls.dart';
import '../../routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController number = TextEditingController();
  RxString selectedCountry = "".obs;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() async {
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

  Future<void> loginApi(String mobileNumber) async {
    try {
      showLoading();
      final url = Uri.parse(Url.loginUrl);
      final response = await http.post(url,
          body: {
        "mobile": mobileNumber
      });
      hideLoading();
      LoginModels loginModels = LoginModels.fromJson(jsonDecode(response.body));
      if (loginModels.status == 1) {

        Get.toNamed(Routes.otpView, arguments: loginModels.data!.mobile ?? "null");
        print("message : ${loginModels.message}");
      } else {
        print("message : ${loginModels.message}");
      }
    } catch (e) {
      print("error : $e");
    }
  }
}
