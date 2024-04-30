import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kabadi_app/network/urls.dart';
import 'package:http/http.dart' as http;

import '../../models/my_address_model.dart';
import '../../models/profile_models.dart';
import '../../utils/app_prefrences.dart';
class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxString profileImage = "".obs;
  RxString location = "".obs;
  RxString locationType = "".obs;
  RxString addressId = "".obs;
  ProfileData? profileList;
  List<MyAddressData> myAddressData = [];


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
    profileApi();

  }


  void getData () async {
    location.value = await AppPrefrence.getString("location");
    locationType.value = await AppPrefrence.getString("location_type");
    addressId.value = await AppPrefrence.getString("address_id");
    print("addres : ${addressId.value}");
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
        Fluttertoast.showToast(msg: "${profileModel.message}");
        print("message : ${profileModel.message}");
      } else {
        print("message : ${profileModel.message}");
      }
    } catch (e) {
      print("error : $e");
    }
  }

  Future<void> myAddressApi() async {
    try {
      showLoading();
      final url = Uri.parse(Url.myAddressUrl);
      final response = await http.get(
        url,
        headers: {
          'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
          'Accept': 'application/json'
        },
      );
      hideLoading();

      MyAddress myAddress = MyAddress.fromJson(jsonDecode(response.body));
      print("myAddressUrl : ${jsonEncode(myAddress)}");
      if (myAddress.status == 1) {
        myAddressData = myAddress.data!;
        update();
        Fluttertoast.showToast(msg: "${myAddress.message}");
        print("message : ${myAddress.message}");
      } else {
        Fluttertoast.showToast(msg: "${myAddress.message}");
        print("message : ${myAddress.message}");
      }
    } catch (e) {
      print("error : $e");
    }
  }


}