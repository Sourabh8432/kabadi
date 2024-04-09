import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:kabadi_app/network/urls.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../../models/add_address_models.dart';
import '../../models/get_category_models.dart';
import '../../models/get_location_models.dart';
import '../../models/get_price_list.dart';
import '../../models/my_address_model.dart';
import '../../models/pickup_reschedule.dart';
import '../../models/profile_models.dart';
import '../../utils/app_prefrences.dart';

class SellScrapController extends GetxController {
  RxInt tabController = 0.obs;
  RxBool isCheck = true.obs;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  RxInt myIndex = (-1).obs;
  RxBool isLoading = false.obs;
  List<GetCategoryData> getCategoryList = [];
  var getLocationList;
  List<MyAddressData> myAddressData = [];
  List<GetPriceData> getAllPriceList = [];
  RxString getToken = "".obs;
  ProfileData? profileList;
  Map<int, bool> categorySelectionMap = {};
  RxString location = "".obs;
  RxList<GetCategoryData> getisCheckList = <GetCategoryData>[].obs;
  // RxList<int> selectedIndices = <int>[].obs;
  RxList<int> selectedIds = <int>[].obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkLocationPermission();
    getMyToken();
    getLocationAndAddress();

    profileApi();
    myAddressApi();

  }


  // void toggleSelection(int index) {
  //   if (selectedIndices.contains(index)) {
  //     selectedIndices.remove(index);
  //   } else {
  //     selectedIndices.add(index);
  //   }
  //   update();
  // }

  void toggleSelection(int index) {
    int? itemId = getCategoryList[index].categoryId; // Assuming your category has an ID
    if (selectedIds.contains(itemId)) {
      selectedIds.remove(itemId);
    } else {
      selectedIds.add(itemId!);
    }
    update();
  }
  bool isSelected(int itemId) {
    return selectedIds.contains(itemId);
  }
  Future<bool> checkLocationPermission() async {
    PermissionStatus permission = await Permission.location.status;

    if (permission == PermissionStatus.granted) {
      return true;
    } else {
      PermissionStatus permissionStatus = await Permission.location.request();
      return permissionStatus == PermissionStatus.granted;
    }
  }

  void getMyToken() async {
    getToken.value = await AppPrefrence.getString('token');
    print("Token ${getToken.value}");
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

  Future<String> getCurrentLocation() async {
    bool hasPermission = await checkLocationPermission();

    if (!hasPermission) {
      return "Location permission denied";
    }

    try {
      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Get the address from coordinates
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      // Construct the address string
      String address =
          "${place.name}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country},${place.postalCode}";
      print("address : $address");
      getLocationApi(address);
      update();
      return address;
    } catch (e) {
      return "Failed to get location: $e";
    }
  }

  void getLocationAndAddress() async {
    location.value = await getCurrentLocation();
    print(location); // or use it in your UI
  }

  Future<void> getLocationApi(String currentLocation) async {
    print("CodeRun");
    try {
      showLoading();
      final url = Uri.parse(Url.getLocation);
      final response = await http.post(
        url,
        headers: {
          'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
          'Accept': 'application/json'
        },
        body: {"user_id":await AppPrefrence.getString('userId'),"address": currentLocation}
      );
      hideLoading();
      GetLocatonModels getLocatonModels = GetLocatonModels.fromJson(jsonDecode(response.body));
      print("getCategoryModels : ${getLocatonModels.status}");
      if (getLocatonModels.status == 1) {
        getLocationList = getLocatonModels.data!.name;
        getCategoryApi();
        getPriceListApi();
        update();
        // Fluttertoast.showToast(msg: getCategoryModels.message!);
      } else {
        print("message : ${getLocatonModels.message}");
      }
    } catch (e) {
      print("error : $e");
    }
  }

  Future<void> getCategoryApi() async {
    try {
      showLoading();
      final url = Uri.parse(Url.getCategoryUrl);
      final response = await http.get(
        url,
        headers: {
          'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
          'Accept': 'application/json'
        },
      );
      hideLoading();
      GetCategoryModels getCategoryModels =
          GetCategoryModels.fromJson(jsonDecode(response.body));
      print("getCategoryModels : ${getCategoryModels.status}");
      if (getCategoryModels.status == 1) {
        getCategoryList = getCategoryModels.data!;
        // Fluttertoast.showToast(msg: getCategoryModels.message!);
      } else {
        print("message : ${getCategoryModels.message}");
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
      if (myAddress.status == 1) {
        myAddressData = myAddress.data!;

        print("message : ${myAddress.message}");
      } else {
        print("message : ${myAddress.message}");
      }
    } catch (e) {
      print("error : $e");
    }
  }

  Future<void> getPriceListApi() async {
    try {
      showLoading();
      final url = Uri.parse(Url.getPriceListUrl);
      final response = await http.get(
        url,
        headers: {
          'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
          'Accept': 'application/json'
        },
      );
      hideLoading();
      GetPriceList getPriceList =
          GetPriceList.fromJson(jsonDecode(response.body));
      print("getPriceList : ${jsonEncode(getPriceList)}");
      if (getPriceList.status == 1) {
        getAllPriceList = getPriceList.data!;

        print("message : ${getPriceList.message}");
      } else {
        print("message : ${getPriceList.message}");
      }
    } catch (e) {
      print("error : $e");
    }
  }

  Future<void> addAddressApi() async {
    try {
      showLoading();
      final url = Uri.parse(Url.addAddressUrl);
      final response = await http.get(
        url,
        headers: {
          'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
          'Accept': 'application/json'
        },
      );
      hideLoading();
      AddAddressModels addAddressModels =
          AddAddressModels.fromJson(jsonDecode(response.body));
      if (addAddressModels.status == 1) {
        print("message : ${addAddressModels.message}");
      } else {
        print("message : ${addAddressModels.message}");
      }
    } catch (e) {
      print("error : $e");
    }
  }

  Future<void> profileApi() async {
    try {
      showLoading();
      final url = Uri.parse(Url.profileUrl);
      final response = await http.get(
        url,
        headers: {
          'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
          'Accept': 'application/json'
        },
      );
      hideLoading();
      ProfileModel profileModel =
          ProfileModel.fromJson(jsonDecode(response.body));
      print("profileApi : ${profileModel.status}");
      if (profileModel.status == 1) {
        profileList = profileModel.data!;

        print("message : ${profileModel.message}");
      } else {
        print("message : ${profileModel.message}");
      }
    } catch (e) {
      print("error : $e");
    }
  }
}
