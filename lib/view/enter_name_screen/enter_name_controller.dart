import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kabadi_app/network/urls.dart';
import 'package:otp_autofill/otp_autofill.dart';
import '../../models/edit_profile_models.dart';
import '../../routes/app_pages.dart';
import '../../utils/app_prefrences.dart';

class EnterNameController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController yourName = TextEditingController();
  String userID = Get.arguments;

  @override
  void onInit() async{
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


  Future<void> enterNameProfile(String editName) async {

    try {
      showLoading();
      final url = Uri.parse(Url.editProfileUrl);
      final response = await http.post(url, headers: {
        'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
        'Accept': 'application/json'
      }, body: {
        "name": editName,
        "user_id": userID,
        "location": "",
        "email": "",

      });
      hideLoading();
      EditProfile editProfile = EditProfile.fromJson(jsonDecode(response.body));
      print("editProfile : ${jsonDecode(response.body)}");
      if (editProfile.status == 1) {
        Get.toNamed(Routes.sellScrapView);
        Fluttertoast.showToast(msg: editProfile.message!);
        print("message : ${editProfile.message}");
      } else {
        Fluttertoast.showToast(msg: editProfile.message!);
        print("message : ${editProfile.message}");
      }
    } catch (e) {
      print("error : $e");
    }
  }

}