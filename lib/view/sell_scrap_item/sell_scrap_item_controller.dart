import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kabadi_app/network/urls.dart';
import 'package:http/http.dart' as http;

import '../../models/get_price_list.dart';
import '../../utils/app_prefrences.dart';


class SellScrapItemController extends GetxController {

  RxInt currentStep = 0.obs;

  RxBool completed = false.obs;
  final List<File> images = [];
  List categoryIds = Get.arguments;
  RxBool isLoading = false.obs;
  RxString parameter = "".obs;
  List<GetPriceData> getAllPriceList = [];
  Map<int, Set<int>> selectedSubCategoryIdsMap = {};

  void showLoading() {
    isLoading(true);
    update();
  }

  void hideLoading() {
    isLoading(false);
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("Test Code : ${categoryIds.runtimeType}");
    getSellListApi(categoryIds);
  }

  void toggleCategorySelection(int categoryId, int subCategoryId) {
    if (!selectedSubCategoryIdsMap.containsKey(categoryId)) {
      selectedSubCategoryIdsMap[categoryId] = {};
    }

    if (selectedSubCategoryIdsMap[categoryId]!.contains(subCategoryId)) {
      selectedSubCategoryIdsMap[categoryId]!.remove(subCategoryId);
    } else {
      selectedSubCategoryIdsMap[categoryId]!.add(subCategoryId);
    }

    update();
  }



  Future<void> uploadImage() async {
    final List<XFile> selectedImages = await ImagePicker().pickMultiImage();
    if (selectedImages != null && selectedImages.isNotEmpty) {
        images.addAll(selectedImages.map((image) => File(image.path)).toList());
        print("imagesList : $images");
      update();
    }
  }

  void removeImage(int index) {
      images.removeAt(index);
      update();

  }

  Future<void> getSellListApi(List categoryIds) async {
    try {
      showLoading();
      final url = Uri.parse(Url.getPriceListUrl);
      final response = await http.post(
        url,
        headers: {
          'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
          'Accept': 'application/json'
        },
        body: jsonEncode({"category_id": categoryIds}),
      );
      hideLoading();
      print("getPriceList : ${jsonEncode({"category_id": categoryIds})}");
      GetPriceList getPriceList = GetPriceList.fromJson(jsonDecode(response.body));
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

  Future<void> getDateListApi(List categoryIds) async {
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
      print("getPriceList : ${jsonEncode({"category_id": categoryIds})}");
      GetPriceList getPriceList = GetPriceList.fromJson(jsonDecode(response.body));
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


  Future<void> uploadImageApi() async {

      var request = http.MultipartRequest('POST', Uri.parse(Url.imageUploadUrl));
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'multipart/form-data';
      request.headers['authToken'] = "Bearer ${await AppPrefrence.getString('token')}";
      // Add images as multipart/form-data
      for (int i = 0; i < images.length; i++) {
        var image = images[i];
        var stream = http.ByteStream(image.openRead());
        var length = await image.length();

        var multipartFile = http.MultipartFile('images', stream, length,
            filename: 'image$i.jpg'); // 'images' should be the field name expected by the server

        request.files.add(multipartFile);
      }

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Images uploaded successfully');
      } else {
        print('Failed to upload images. Error: ${response.reasonPhrase}');
      }
    }

}