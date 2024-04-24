import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ChooseLanguageController extends GetxController {
  RxString currentLocale = "en".obs;
  RxInt isCheck = 0.obs;


  @override
  void onInit() {
    super.onInit();
    // Load initial language strings
    // loadLocalizedStrings(currentLocale.value);
  }

  // Future<void> loadLocalizedStrings(String languageCode) async {
  //   String jsonString = await rootBundle.loadString('assets/language/$languageCode.json');
  //   _localizedStrings = jsonDecode(jsonString);
  //   update();
  // }
  //
  // String translate(String key) {
  //   return _localizedStrings[key] ?? '';
  // }
  //
  // void changeLanguage(String languageCode) {
  //   currentLocale.value = languageCode;
  //   loadLocalizedStrings(languageCode);
  // }

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

}
