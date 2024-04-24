import 'dart:convert';

import 'package:get/get.dart';
import 'package:kabadi_app/network/urls.dart';
import 'package:http/http.dart' as http;

import '../../models/profile_models.dart';
import '../../utils/app_prefrences.dart';
class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxString profileImage = "".obs;
  ProfileData? profileList;



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getProfileImage();
    profileApi();

  }

  getProfileImage()async{
    profileImage.value = await AppPrefrence.getString("profile_image");
    update();
  }

  void showLoading() {
    isLoading(true);
    update();
  }

  void hideLoading() {
    isLoading(false);
    update();
  }

  Future<void> profileApi() async {
    try {
      showLoading();
      final url = Uri.parse(Url.profileUrl);
      final response = await http.get(url,
        headers: {'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
          'Accept' : 'application/json'},
          );
      hideLoading();
      ProfileModel profileModel = ProfileModel.fromJson(jsonDecode(response.body));
      print("profileApi ${jsonEncode(profileModel)} ");
      
      if (profileModel.status == 1) {
        profileList = profileModel.data;
        AppPrefrence.putString("profile_image", profileModel.data?.image ?? "");
        update();
        print("message : ${profileModel.message}");
      } else {
        print("message : ${profileModel.message}");
      }
    } catch (e) {
      print("error : $e");
    }
  }




}