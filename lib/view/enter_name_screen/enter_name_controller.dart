import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:otp_autofill/otp_autofill.dart';
import '../../routes/app_pages.dart';
import '../../utils/app_prefrences.dart';

class EnterNameController extends GetxController {
  RxBool isLoading = false.obs;
  // TextEditingController yourName = TextEditingController();


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

}