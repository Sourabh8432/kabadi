import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kabadi_app/network/urls.dart';
import 'package:kabadi_app/utils/app_prefrences.dart';
// import 'package:otp_autofill/otp_autofill.dart';

import '../../models/login_models.dart';
import '../../models/otp_models.dart';
import '../../routes/app_pages.dart';

class OtpController extends GetxController {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  RxInt secondsRemaining = 60.obs;
  RxBool enableResend = false.obs;
  late Timer timer;
  RxBool isLoading = false.obs;
  // late OTPInteractor _otpInteractor;
  String phoneNumber = Get.arguments;

  @override
  void onInit() async{
    // TODO: implement onInit
    // otpListener();
    super.onInit();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining.value != 0) {
        secondsRemaining--;
        update();
      } else {
        enableResend.value = true;
        update();
      }
    });

  }


  // void otpListener() {
  //   _otpInteractor = OTPInteractor();
  //   _otpInteractor.getAppSignature().then((value) => print('signature - $value'));
  //   OTPTextEditController(
  //     codeLength: 6,
  //     onCodeReceive: (code) {
  //       for (int i = 0; i < 6; i++)
  //       {
  //         pinController.text = code;
  //         update();
  //
  //       }
  //       print("code : $code");
  //
  //     },
  //     otpInteractor: _otpInteractor,
  //   ).startListenUserConsent(
  //         (code) {
  //       final exp = RegExp(r'(\d{6})');
  //       return exp.stringMatch(code ?? '') ?? '';
  //     },
  //   );
  // }


  void showLoading() {
    isLoading(true);
    update();
  }

  void hideLoading() {
    isLoading(false);
    update();
  }


  void resendCode() {
     secondsRemaining = 60.obs;
     resendOtp(phoneNumber);
     enableResend = false.obs;
    update();
  }



  @override
  dispose(){
    timer.cancel();
    super.dispose();
  }


  Future<void> otpApi(String otpCode) async {
    try {
      showLoading();
      final url = Uri.parse(Url.otpUrl);
      final response = await http.post(url,
          body: {
            "mobile": phoneNumber,
            "otp_code": otpCode,
          });
      hideLoading();
      OTPModels otpModels = OTPModels.fromJson(jsonDecode(response.body));
      if (otpModels.status == 1) {
        print(jsonDecode(jsonEncode(otpModels)));
        AppPrefrence.putBoolean("isLogin",true);
        AppPrefrence.putString("token", otpModels.data!.token ?? "null");
        AppPrefrence.putString("name", otpModels.data!.user!.name ?? "null");
        AppPrefrence.putString("email", otpModels.data!.user!.email ?? "null");
        AppPrefrence.putString("mobile", otpModels.data!.user!.mobile ?? "null");
        AppPrefrence.putString("userId", otpModels.data!.user!.userId ?? "null");
        AppPrefrence.putString("location", otpModels.data!.user!.location ?? "null");
        AppPrefrence.putInt("is_new_user", otpModels.data!.isNewUser);
        otpModels.data!.isNewUser!=0?Get.offAllNamed(Routes.enterNameView, arguments: otpModels.data!.user!.userId ?? "" ): Get.offAllNamed(Routes.sellScrapView);
        print("message : ${otpModels.message}");
        Fluttertoast.showToast(msg: "${otpModels.message}");
      } else {
        Fluttertoast.showToast(msg: "${otpModels.message}");
        print("message : ${otpModels.message}");
      }
    } catch (e) {
      print("error : $e");
    }
  }

  Future<void> resendOtp(String mobileNumber) async {
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
        Fluttertoast.showToast(msg: "${loginModels.message}");
        print("message : ${loginModels.message}");
      } else {
        Fluttertoast.showToast(msg: "${loginModels.message}");
        print("message : ${loginModels.message}");
      }
    } catch (e) {
      print("error : $e");
    }
  }

}