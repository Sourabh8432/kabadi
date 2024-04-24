// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:get/get.dart';
// import 'package:kabadi_app/network/urls.dart';
// import 'package:http/http.dart' as http;
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import '../../models/add_address_models.dart';
// import '../../models/get_category_models.dart';
// import '../../models/get_location_models.dart';
// import '../../models/get_price_list.dart';
// import '../../models/my_address_model.dart';
// import '../../models/pickup_reschedule.dart';
// import '../../models/profile_models.dart';
// import '../../utils/app_prefrences.dart';
//
// class SellScrapController extends GetxController {
//   RxInt tabController = 0.obs;
//   RxBool isCheck = true.obs;
//   var scaffoldKey = GlobalKey<ScaffoldState>();
//   RxInt myIndex = (-1).obs;
//   RxBool isLoading = false.obs;
//   List<GetCategoryData> getCategoryList = [];
//   var getLocationList;
//   List<MyAddressData> myAddressData = [];
//   List<GetPriceData> getAllPriceList = [];
//   RxString getToken = "".obs;
//   RxString userId = "".obs;
//   ProfileData? profileList;
//   Map<int, bool> categorySelectionMap = {};
//   RxString location = "".obs;
//   RxString address = "".obs;
//   RxList<GetCategoryData> getisCheckList = <GetCategoryData>[].obs;
//   // RxList<int> selectedIndices = <int>[].obs;
//   RxList<int> selectedIds = <int>[].obs;
//
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     print("location ${location.value}");
//     checkLocationPermission();
//     getLocationAndAddress();
//     getMyToken();
//
//   }
//
//
//   // void toggleSelection(int index) {
//   //   if (selectedIndices.contains(index)) {
//   //     selectedIndices.remove(index);
//   //   } else {
//   //     selectedIndices.add(index);
//   //   }
//   //   update();
//   // }
//
//   void toggleSelection(int index) {
//     int? itemId = getCategoryList[index].categoryId; // Assuming your category has an ID
//     if (selectedIds.contains(itemId)) {
//       selectedIds.remove(itemId);
//     } else {
//       selectedIds.add(itemId!);
//     }
//     update();
//   }
//   bool isSelected(int itemId) {
//     return selectedIds.contains(itemId);
//   }
//   Future<bool> checkLocationPermission() async {
//     PermissionStatus permission = await Permission.location.status;
//
//     if (permission == PermissionStatus.granted) {
//       return true;
//     } else {
//       PermissionStatus permissionStatus = await Permission.location.request();
//       return permissionStatus == PermissionStatus.granted;
//     }
//   }
//
//   void getMyToken() async {
//     getToken.value = await AppPrefrence.getString('token');
//     // userId.value = await AppPrefrence.getString('userId');
//     print("Token ${getToken.value}");
//     // print("Token ${userId.value}");
//     update();
//   }
//   // void getMobileNumber() async {
//   //   mobileNumber.value = await AppPrefrence.getString('mobile');
//   //   print("Token ${getToken.value}");
//   //   update();
//   // }
//
//   void showLoading() {
//     isLoading(true);
//     update();
//   }
//
//   void hideLoading() {
//     isLoading(false);
//     update();
//   }
//
//   Future<String> getCurrentLocation() async {
//     showLoading();
//     bool hasPermission = await checkLocationPermission();
//
//     if (!hasPermission) {
//       // hideLoading();
//       return "Location permission denied";
//
//     }
//
//     try {
//
//       // Get the current position
//       Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//
//       // Get the address from coordinates
//       List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
//
//       Placemark place = placemarks[0];
//
//       // Construct the address string
//        address.value =
//           "${place.name}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country},${place.postalCode}";
//       print("address : $address");
//       update();
//       return address.value;
//     } catch (e) {
//       return "Failed to get location: $e";
//     }
//   }
//
//   void getLocationAndAddress() async {
//     location.value = await getCurrentLocation();
//     getLocationApi(location.value);
//     update();
//     print(location); // or use it in your UI
//   }
//
//   Future<void> getLocationApi(String currentLocation) async {
//     print("CodeRun");
//     try {
//       final url = Uri.parse(Url.getLocation);
//       final response = await http.post(
//         url,
//         headers: {
//           'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
//           'Accept': 'application/json'
//         },
//         body: {"user_id":await AppPrefrence.getString('userId'),"address": currentLocation}
//       );
//       hideLoading();
//       GetLocatonModels getLocatonModels = GetLocatonModels.fromJson(jsonDecode(response.body));
//       print("getCategoryModels : ${getLocatonModels.status}");
//       if (getLocatonModels.status == 1) {
//         getLocationList = getLocatonModels.data!.name;
//         getCategoryApi();
//         getPriceListApi();
//         profileApi();
//         myAddressApi();
//         update();
//         // Fluttertoast.showToast(msg: getCategoryModels.message!);
//       } else {
//         print("message : ${getLocatonModels.message}");
//       }
//     } catch (e) {
//       print("error : $e");
//     }
//   }
//
//   Future<void> getCategoryApi() async {
//     try {
//       showLoading();
//       final url = Uri.parse(Url.getCategoryUrl);
//       final response = await http.get(
//         url,
//         headers: {
//           'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
//           'Accept': 'application/json'
//         },
//       );
//       hideLoading();
//       GetCategoryModels getCategoryModels =
//           GetCategoryModels.fromJson(jsonDecode(response.body));
//       print("getCategoryModels : ${getCategoryModels.status}");
//       if (getCategoryModels.status == 1) {
//         getCategoryList = getCategoryModels.data!;
//         // Fluttertoast.showToast(msg: getCategoryModels.message!);
//       } else {
//         print("message : ${getCategoryModels.message}");
//       }
//     } catch (e) {
//       print("error : $e");
//     }
//   }
//
//   Future<void> myAddressApi() async {
//     try {
//       showLoading();
//       final url = Uri.parse(Url.myAddressUrl);
//       final response = await http.get(
//         url,
//         headers: {
//           'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
//           'Accept': 'application/json'
//         },
//       );
//       hideLoading();
//       MyAddress myAddress = MyAddress.fromJson(jsonDecode(response.body));
//       if (myAddress.status == 1) {
//         myAddressData = myAddress.data!;
//
//         print("message : ${myAddress.message}");
//       } else {
//         print("message : ${myAddress.message}");
//       }
//     } catch (e) {
//       print("error : $e");
//     }
//   }
//
//   Future<void> getPriceListApi() async {
//     try {
//       showLoading();
//       final url = Uri.parse(Url.getPriceListUrl);
//       final response = await http.get(
//         url,
//         headers: {
//           'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
//           'Accept': 'application/json'
//         },
//       );
//       hideLoading();
//       GetPriceList getPriceList =
//           GetPriceList.fromJson(jsonDecode(response.body));
//       print("getPriceList : ${jsonEncode(getPriceList)}");
//       if (getPriceList.status == 1) {
//         getAllPriceList = getPriceList.data!;
//
//         print("message : ${getPriceList.message}");
//       } else {
//         print("message : ${getPriceList.message}");
//       }
//     } catch (e) {
//       print("error : $e");
//     }
//   }
//
//   Future<void> addAddressApi() async {
//     try {
//       showLoading();
//       final url = Uri.parse(Url.addAddressUrl);
//       final response = await http.get(
//         url,
//         headers: {
//           'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
//           'Accept': 'application/json'
//         },
//       );
//       hideLoading();
//       AddAddressModels addAddressModels =
//           AddAddressModels.fromJson(jsonDecode(response.body));
//       if (addAddressModels.status == 1) {
//         print("message : ${addAddressModels.message}");
//       } else {
//         print("message : ${addAddressModels.message}");
//       }
//     } catch (e) {
//       print("error : $e");
//     }
//   }
//
//   Future<void> profileApi() async {
//     try {
//       showLoading();
//       final url = Uri.parse(Url.profileUrl);
//       final response = await http.get(
//         url,
//         headers: {
//           'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
//           'Accept': 'application/json'
//         },
//       );
//       hideLoading();
//       ProfileModel profileModel =
//           ProfileModel.fromJson(jsonDecode(response.body));
//       print("TestCode");
//       print("profileApi : ${jsonDecode(response.body)}");
//
//       if (profileModel.status == 1) {
//         profileList = profileModel.data!;
//
//         print("message : ${profileModel.message}");
//       } else {
//         print("message : ${profileModel.message}");
//       }
//     } catch (e) {
//       print("error : $e");
//     }
//   }
// }
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
import '../../models/profile_models.dart';
import '../../utils/app_prefrences.dart';

class SellScrapController extends GetxController {
  RxInt tabController = 0.obs;
  RxInt isCheck = 0.obs;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  RxInt myIndex = (-1).obs;
  RxBool isLoading = false.obs;
  List<GetCategoryData> getCategoryList = [];
  var getName;
  List<MyAddressData> myAddressData = [];
  List<GetPriceData> getAllPriceList = [];
  RxString getToken = "".obs;
  RxString userId = "".obs;
  RxString saveName = "".obs;
  RxString profileImage = "".obs;
  ProfileData? profileList;
  Map<int, bool> categorySelectionMap = {};
  RxString location = "".obs;
  RxString address = "".obs;
  RxString showMessage = "".obs;
  RxList<GetCategoryData> getisCheckList = <GetCategoryData>[].obs;
  RxList<int> selectedIds = <int>[].obs;
  bool isPermissionRequested = false;
  RxBool isAddressChecker = false.obs;
  RxString currentLocale = "".obs;
  TextEditingController priceList = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // getSaveName();
    checkLocationPermissionAndInit();

    getMyToken();
  }

  getSaveName()async{
    saveName.value = await AppPrefrence.getString("save_name");
    profileImage.value = await AppPrefrence.getString("profile_image");
    print("saveName.value  ${saveName.value}");
    update();
  }


  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  Future<void> checkLocationPermissionAndInit() async {
    if (!isPermissionRequested) {
      isPermissionRequested = true;
      bool hasPermission = await checkLocationPermission();
      if (hasPermission) {
        getLocationAndAddress();
      }
      isPermissionRequested = false;
    }
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

  Future<String> getCurrentLocation() async {
    showLoading();
    bool hasPermission = await checkLocationPermission();

    if (!hasPermission) {
      return "Location permission denied";
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      address.value =
          "${place.name}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country},${place.postalCode}";
      return address.value;
    } catch (e) {
      return "Failed to get location: $e";
    }
  }

  void getLocationAndAddress() async {
    location.value = await getCurrentLocation();
    getLocationApi(location.value);
    update();
    print(location);
  }


  Future<void> getLocationApi(String currentLocation) async {
    try {
      final url = Uri.parse(Url.getLocation);
      final response = await http.post(url, headers: {
        'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
        'Accept': 'application/json'
      }, body: {
        "user_id": await AppPrefrence.getString('userId'),
        "address": currentLocation
      });
      hideLoading();
      GetLocatonModels getLocatonModels =
          GetLocatonModels.fromJson(jsonDecode(response.body));
      print("getCategoryModels : ${getLocatonModels.status}");
      if (getLocatonModels.status == 1) {
        getName = getLocatonModels.data!.name;
        print("getName : $getName");
        getCategoryApi();
        getPriceListApi();
        profileApi();
        getSaveName();
        myAddressApi();

        update();
      } else {
        isAddressChecker.value = true;
        update();
        showMessage.value = getLocatonModels.message!;
        print("test message : ${getLocatonModels.message}");
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
        update();
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
        update();
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
      if (getPriceList.status == 1) {
        getAllPriceList = getPriceList.data!;
        update();
        print("message : ${getPriceList.message}");
      } else {
        print("message : ${getPriceList.message}");
      }
    } catch (e) {
      print("error : $e");
    }
  }

  void filterPriceList(String query) {
    print("query : $query");
    if (query.isEmpty) {
      // If the query is empty, show all items
      getAllPriceList = getAllPriceList;
    } else {
      print("getAllPriceList1 : ${jsonEncode(getAllPriceList)}");
      // Filter items whose names start with the query (case-insensitive)
      getAllPriceList = getAllPriceList
          .where((item) => item.name.toString().toLowerCase().startsWith(query.toLowerCase()))
          .toList();
      print("getAllPriceList : $getAllPriceList");
    }
    update();
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
        update();
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
      print("profileModel : ${jsonEncode(profileModel)}");
      if (profileModel.status == 1) {
        profileList = profileModel.data!;
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

  void showLoading() {
    isLoading(true);
    update();
  }

  void hideLoading() {
    isLoading(false);
    update();
  }

  void toggleSelection(int index) {
    int? itemId = getCategoryList[index].categoryId;
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
}
