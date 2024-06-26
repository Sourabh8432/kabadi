import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:kabadi_app/network/urls.dart';
import 'package:kabadi_app/routes/app_pages.dart';
import 'package:kabadi_app/view/sell_scrap_item/sell_scrap_item_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import '../../models/add_address_models.dart';
import '../../models/edit_address_models.dart';
import '../../utils/app_images.dart';
import '../../utils/app_prefrences.dart';
class AddNewAddressController extends GetxController {
  RxInt myIndex = (-1).obs;
  RxBool isLoading = false.obs;
  RxDouble mapLatitude = 0.0.obs;
  RxDouble mapLongitude = 0.0.obs;
  LatLng? markerLocation;
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  RxString address = "".obs;
  TextEditingController localityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController searchAddress = TextEditingController();
  RxString locationType = "".obs;
  RxString locality = "".obs;
  RxString addressLine = "".obs;
  RxString pincode = "".obs;
  RxString addressId = "".obs;
  dynamic myArguments = Get.arguments;
  RxInt selectedIndex = 0.obs;



  List<Map<String, dynamic>> addressList = [
    {
      "image": AppImages.addCatogary,
      "name": "Home",
      "isCheck": false,
    },
    {
      "image": AppImages.addCatogary,
      "name": "Office",
      "isCheck": false,
    },
    {
      "image": AppImages.addCatogary,
      "name": "Hostel/PG",
      "isCheck": false,
    },
    {
      "image": AppImages.addCatogary,
      "name": "Shop",
      "isCheck": false,
    },
    {
      "image": AppImages.addCatogary,
      "name": "Institute",
      "isCheck": false,
    },
  ];


  @override
  void onInit() {
    super.onInit();
    checkLocationPermission();
    getAddressID();
    getCurrentLocation().then((value) {
      updateMarkerLocation(mapLatitude.value, mapLongitude.value);
    });


  }

  CameraPosition getInitialCameraPosition(LatLng markerLocation) {
    return CameraPosition(
      target: LatLng(markerLocation.latitude, markerLocation.longitude),
      zoom: 16,
    );
  }


  void getAddressID () async {
    addressId.value = await AppPrefrence.getString("address_id");
  }



  void showLoading() {
    isLoading(true);
    update();
  }

  void hideLoading() {
    isLoading(false);
    update();
  }



  void getSearchAddress(String query) async {
    try {
      showLoading();
      List<Location> locations = await locationFromAddress(query);

      if (locations != null && locations.isNotEmpty) {
        Location location = locations.first;
        LatLng searchedLocation = LatLng(location.latitude, location.longitude);

        // Update the marker's position on the map
        markerLocation = searchedLocation;
        mapLatitude.value = location.latitude;
        mapLongitude.value = location.longitude;

        // Move the camera to the searched location
        mapController?.animateCamera(CameraUpdate.newLatLng(searchedLocation));
        hideLoading();
        update();
      } else {
        // Handle case where no results are found
      }
    } catch (e) {
      // Handle any errors that occur during the geocoding process
      print('Error searching address: $e');
    }
  }


  void getMyAddress() async {
    showLoading();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    LatLng searchedLocation = LatLng(position.latitude, position.longitude);
    markerLocation = searchedLocation;
    hideLoading();
    mapController?.animateCamera(CameraUpdate.newLatLng(searchedLocation));
     update();
  }



  void updateMarkerLocation(double latitude, double longitude) {
    markerLocation = LatLng(latitude, longitude);
    update();
    getAddressFromLatLng(latitude, longitude).then((address) {
      print('Address: $address');
    });
  }


  void enterAddress () async{
    LatLng selectedLocation = markerLocation!;
    String address = await getAddressFromLatLng(
      selectedLocation.latitude,
      selectedLocation.longitude,
    );
    localityController.text = address.split(',').elementAt(0).trim();

    addressController.text = address == "00"?"":address.substring(address.indexOf(',') + 2).trim();

    update();

  }


  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];

      // Constructing the address format
      locality.value = place.locality!;
      addressLine.value = "${place.name}, ${place.administrativeArea}";
       pincode.value = "${place.postalCode}";
       address.value = "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      return address.value;
    } catch (e) {
      return "Address not found";
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      mapLatitude.value = position.latitude;
      mapLongitude.value = position.longitude;
      update();
    } catch (e) {
      // Handle error
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

  Future<void> addAddress(String locationType, String locality, String addressLine, String pincode, String longitude, String latitude ) async {

    try {
      showLoading();
      final url = Uri.parse(Url.addAddress);
      final response = await http.post(url, headers: {
        'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
        'Accept': 'application/json'
      }, body: {
        "location_type": locationType,
        "locality": locality,
        "address_line": addressLine,
        "pincode": pincode,
        "longitude": longitude,
        "latitude": latitude,
      });
      hideLoading();
      AddAddressModels addAddressModels = AddAddressModels.fromJson(jsonDecode(response.body));

      if (addAddressModels.status == 1) {
        Fluttertoast.showToast(msg: "${addAddressModels.message}");
          Get.back();
          Get.back();
          Get.back();

        print("message : ${addAddressModels.message}");
      } else {
        Fluttertoast.showToast(msg: addAddressModels.message!);
        print("message : ${addAddressModels.message}");
      }
    } catch (e) {
      print("error : $e");
    }
  }

  Future<void> editAddress(String locationType, String locality, String addressLine, String pincode, String longitude, String latitude, String addressId ) async {

    try {
      showLoading();
      final url = Uri.parse(Url.addAddress);
      final response = await http.post(url, headers: {
        'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
        'Accept': 'application/json'
      }, body: {
        "location_type": locationType,
        "locality": locality,
        "address_line": addressLine,
        "pincode": pincode,
        "longitude": longitude,
        "latitude": latitude,
        "address_id": addressId,
      });
      hideLoading();
      AddAddressModels addAddressModels = AddAddressModels.fromJson(jsonDecode(response.body));
      print("editaddress : ${jsonDecode(response.body)}");
      if (addAddressModels.status == 1) {
        print("screen : ${myArguments[1]["screen"]}");
        if(myArguments[1]["screen"] == "Profile"){
          Get.offAndToNamed(Routes.profileView);
          AppPrefrence.putString("address", "${addAddressModels.data?.addressLine.toString()}, ${addAddressModels.data?.locality.toString()}, ${addAddressModels.data?.pincode.toString()}");
        }else if(myArguments[1]["screen"] == "SellScrap"){
          Get.back();
          Get.back();
          Get.back();
        }else if (myArguments[1]["screen"] == "SellScrapItem"){
          SellScrapItemController sellScrapItemController = Get.find();
          Get.offAndToNamed(Routes.sellScrapItemView);
          sellScrapItemController.updateMyAddress.value = true;
          AppPrefrence.putString("address", "${addAddressModels.data?.addressLine.toString()}, ${addAddressModels.data?.locality.toString()}, ${addAddressModels.data?.pincode.toString()}");
          AppPrefrence.putString("address_Id", addressId);
          sellScrapItemController.getUserId();

          print("addAddressModels ${"${addAddressModels.data?.addressLine.toString()}, ${addAddressModels.data?.locality.toString()}, ${addAddressModels.data?.pincode.toString()}"}");
          print("addAddressModels $addressId");
        }
        update();
        Fluttertoast.showToast(msg: "${addAddressModels.message}");
        print("message : ${addAddressModels.message}");
      } else {
        Fluttertoast.showToast(msg: addAddressModels.message!);
        print("message : ${addAddressModels.message}");
      }
    } catch (e) {
      print("error : $e");
    }
  }
}
