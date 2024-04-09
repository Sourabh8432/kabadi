import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kabadi_app/network/urls.dart';

import '../../models/edit_profile_models.dart';

class EditProfileController extends GetxController {
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

  Future<void> editProfile(String name, String location) async {
    try {
      showLoading();
      final url = Uri.parse(Url.editProfileUrl);
      final response = await http.post(url,
          headers: {'Authorization':'Authorization'},
          body: {
            "name": name,
            "location": location,
          });
      hideLoading();
      EditProfile editProfile = EditProfile.fromJson(jsonDecode(response.body));
      if (editProfile.status == 1) {


        print("message : ${editProfile.message}");
      } else {
        print("message : ${editProfile.message}");
      }
    } catch (e) {
      print("error : $e");
    }
  }

}