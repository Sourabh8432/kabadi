

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

import 'package:permission_handler/permission_handler.dart';


class AddNewAddressController extends GetxController {
  RxInt myIndex = (-1).obs;
  RxBool isLoading = false.obs;
  RxDouble mapLatitude = 0.0.obs;
  RxDouble mapLongitude = 0.0.obs;
  late LatLng markerLocation;
  GoogleMapController? mapController;
  Set<Marker> markers = {};

  TextEditingController searchController = TextEditingController();

  @override

  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkLocationPermission();
    getCurrentLocation().then((value) {
      markerLocation =  LatLng(mapLatitude.value, mapLongitude.value);
    });

  }

  void showLoading() {
    isLoading(true);
    update();
  }

  void hideLoading() {
    isLoading(false);
    update();
  }


  Future<void> getCurrentLocation() async {
    try {
      // Get the current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Get the latitude and longitude
      mapLatitude.value = position.latitude;
      mapLongitude.value = position.longitude;

      update();
      // Get the address from coordinates

    } catch (e) {

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





}