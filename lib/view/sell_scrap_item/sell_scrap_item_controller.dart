import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kabadi_app/network/urls.dart';
import 'package:http/http.dart' as http;
import '../../models/date_list_models.dart';
import '../../models/get_complete_list.dart';
import '../../models/get_image_upload.dart';
import '../../models/get_price_list.dart';
import '../../routes/app_pages.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../../utils/app_prefrences.dart';
import '../../models/edit_profile_image.dart';
import 'package:http_parser/http_parser.dart';

import '../sell_scrap/sellscrap_controller.dart';

class SellScrapItemController extends GetxController {
  RxInt currentStep = 0.obs;

  RxBool completed = false.obs;
  RxBool isEdit = false.obs;
  RxBool isEditDate = false.obs;
  final List<File> images = [];
  RxBool isLoading = false.obs;
  RxBool updateMyAddress = false.obs;
  RxString parameter = "".obs;

  List<GetPriceData> getAllPriceList = [];
  List<DateListData> getDateList = [];
  Map<int, Set<int>> selectedSubCategoryIdsMap = {};
  List<GetPriceSubCategories> submitedId = [];
  List<String> getUploadImageUrl = [];
  var getCompleteListData;
  DateListData? selectedDate;
  RxString userId = "".obs;
  RxString addressId = "".obs;
  List myselection = [];
  List idList = [];
  dynamic myArguments = Get.arguments;
  RxString selectedDateTextWidget = "".obs;
  RxString selectedDateWidget = "".obs;
  RxString updatedAddress = "".obs;
  TextEditingController instructions = TextEditingController();




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
    getUserId();
    currentStep.value = 0;


    if (myArguments != null && myArguments.isNotEmpty) {
      getSellListApi(myArguments[0]['category_id']);
    } else {
      print('myArguments is null or empty');
    }


  }


  void clearData() {
    currentStep.value = 0;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void getUserId() async {
    userId.value = await AppPrefrence.getString('userId');
    addressId.value = await AppPrefrence.getString("address_id");
    updatedAddress.value = await AppPrefrence.getString("address");
    print("updatedAddress $updatedAddress");
    update();
  }

  void toggleCategorySelection(int categoryId, int subCategoryId, String nameId, String price, String weight,
      List<GetPriceSubCategories> submitedId) {
    bool dataExists = submitedId.any((data) => data.id == categoryId && data.categoryId == subCategoryId);
    if (dataExists) {
      submitedId.removeWhere((data) => data.id == categoryId && data.categoryId == subCategoryId);
    } else {
      GetPriceSubCategories newData = GetPriceSubCategories(
        id: categoryId, categoryId: subCategoryId, name : nameId, priceUnit: price ,weightUnit: weight
      );
      submitedId.add(newData);
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

    showLoading();
    final dio = Dio();
    dio.options.headers['Authorization'] =
    "Bearer ${await AppPrefrence.getString('token')}";
    dio.options.headers['Accept'] = 'application/json';

    // Convert category_id to string if necessary
    final categoryId = myArguments[0]['category_id'];

    final response = await dio.post(
      Url.getPriceListUrl,
      data: {"category_id": categoryId},
    );

    hideLoading();
    print("getPriceList : ${jsonEncode({"category_id": categoryIds})}");
// Make sure to pass the decoded JSON map to fromJson method
    GetPriceList getPriceList = GetPriceList.fromJson(response.data);
    print("getPriceList : ${jsonEncode(getPriceList)}");

    if (getPriceList.status == 1) {
      getAllPriceList = getPriceList.data!;
      print("message : ${getPriceList.message}");
    } else {
      print("message : ${getPriceList.message}");
    }

  }

  // Future<void> getSellListApi(List categoryIds) async {
  //   try {
  //     showLoading();
  //     final url = Uri.parse(Url.getPriceListUrl);
  //     final response = await http.post(
  //       url,
  //       headers: {
  //         'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
  //         'Accept': 'application/json'
  //       },
  //       // body: {"category_id": myArguments[0]['category_id']},
  //       body: jsonEncode({"category_id":categoryIds}),
  //     );
  //     hideLoading();
  //     print("getPriceList : ${jsonEncode({"category_id": categoryIds})}");
  //     GetPriceList getPriceList =
  //     GetPriceList.fromJson(jsonDecode(response.body));
  //     print("getPriceList : ${jsonEncode(getPriceList)}");
  //     if (getPriceList.status == 1) {
  //       getAllPriceList.clear();
  //      update();
  //       getAllPriceList = getPriceList.data!;
  //       print("message : ${getPriceList.message}");
  //     } else {
  //       print("message : ${getPriceList.message}");
  //     }
  //   } catch (e) {
  //     print("error : $e");
  //   }
  // }

  Future<void> getPickupListApi(List categoryIds) async {
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
      GetPriceList getPriceList =
      GetPriceList.fromJson(jsonDecode(response.body));
      print("getPriceList : ${jsonEncode(getPriceList)}");
      if (getPriceList.status == 1) {
        getAllPriceList = getPriceList.data!;
        Fluttertoast.showToast(msg: "${getPriceList.message}");
        print("message : ${getPriceList.message}");
      } else {
        Fluttertoast.showToast(msg: "${getPriceList.message}");
        print("message : ${getPriceList.message}");
      }
    } catch (e) {
      print("error : $e");
    }
  }

  // Future<void> uploadImageApi() async {
  //   showLoading();
  //   try {
  //     var postUri = Uri.parse(Url.imageUploadUrl);
  //     var request = http.MultipartRequest("POST", postUri);
  //
  //     request.headers['authToken'] = "Bearer ${await AppPrefrence.getString('token')}";
  //     // request.headers['Accept'] = 'application/json';
  //
  //     for (int i = 0; i < images.length; i++) {
  //       var image = images[i];
  //
  //       List<int> imageBytes = await image.readAsBytes();
  //
  //       var multipartFile = http.MultipartFile.fromBytes(
  //         'image[]',
  //         imageBytes,
  //         filename: 'image$i.jpg',
  //         // contentType: MediaType('image', 'jpg'), // Adjust content type as per your image type
  //       );
  //       request.files.add(multipartFile);
  //     }
  //
  //     hideLoading();
  //     var response = await request.send();
  //     print('response status code: ${response.statusCode}');
  //     print('response reason phrase: ${response.reasonPhrase}');
  //
  //     if (response.statusCode == 200) {
  //       print('Images uploaded successfully');
  //
  //       var responseData = await response.stream.bytesToString();
  //       var decodedResponse = jsonDecode(responseData);
  //       GetImageModels getImageModels = GetImageModels.fromJson(decodedResponse);
  //
  //      getUploadImageUrl = getImageModels.data!;
  //       print(decodedResponse);
  //     } else {
  //
  //       print('Failed to upload images. Error: ${response.reasonPhrase}');
  //     }
  //   } catch (e) {
  //     print('Error uploading images: $e');
  //   }
  // }

  Future<void> uploadImageApi(List<File> myImages) async {

    print("images $images $myImages ${images.runtimeType}");
    try {
      // Show loading indicator
      showLoading();

      // Retrieve authentication token
      String? token = await AppPrefrence.getString('token');
      if (token == null) {
        print('Error: Authentication token not found.');
        return;
      }


      var postUri = Uri.parse(Url.imageUploadUrl);
      var request = http.MultipartRequest("POST", postUri);

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      for (int i = 0; i < myImages.length; i++) {
        var image = myImages[i];

        List<int> imageBytes = await image.readAsBytes();

        var multipartFile = http.MultipartFile.fromBytes(
          'image[]', // Field name for the file in the request
          imageBytes,
          filename: 'image$i.jpg',
          // contentType: MediaType('image', 'jpg'), // Adjust content type as per your image type
        );
        request.files.add(multipartFile);
      }

      // Send API request
      http.StreamedResponse response = await request.send();

      // Handle response
      if (response.statusCode == 200) {
        // Request successful
        var responseData = await response.stream.bytesToString();
        var decodedResponse = jsonDecode(responseData);
        GetImageModels getImageModels = GetImageModels.fromJson(decodedResponse);

        getUploadImageUrl = getImageModels.data!;
        print('Images uploaded successfully');
        print(decodedResponse);
      } else {
        // Request failed
        print('Failed to upload images. Error: ${response.reasonPhrase}');
      }

      // Hide loading indicator
      hideLoading();
    } catch (e) {
      // Exception occurred
      print('Error uploading images: $e');
      // Hide loading indicator in case of error
      hideLoading();
    }
  }

  static Future<DateList?> getDateListApi() async {
    try {
      final url = Uri.parse(Url.pickupDate); // Replace with your API endpoint
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${await AppPrefrence.getString('token')}',
          'Accept': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        return DateList.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load date list');
      }
    } catch (e) {
      print('API Error: $e');
      throw e;
    }
  }

//   Future<void> getCompleteAPI(List<File> editImages) async {
//
//
//
//     var postUri = Uri.parse(Url.pickupRequest);
//     var request = http.MultipartRequest("POST", postUri);
//     request.headers['Content-Type'] = 'multipart/form-data';
//     request.headers['Authorization'] = "Bearer ${await AppPrefrence.getString('token')}";
//     request.fields['Accept'] = 'application/json';
//     request.fields['user_id'] = userId.value;
//     request.fields['price_list'] = idList.toString();
//     request.fields['address_id'] = myArguments[1]['address'];
//     request.fields['pickup_date'] = selectedDateTextWidget.value;
//     request.fields['pickup_instructions'] = "test";
//
//     // Assuming editImages is a list of File objects
//     List<File> editImages = [];
//
// // Create an empty file
//     File emptyFile = File('path_to_empty_file.txt');
//
//     for (File editImage in editImages) {
//       String fileName = editImage.path.split('/').last; // Extract filename
//
//       // Add the empty file as a MultipartFile
//       request.files.add(
//         await http.MultipartFile.fromPath(
//           'image[]', // Assuming 'image[]' is the parameter name for the array on the server-side
//           emptyFile.path,
//           filename: fileName,
//           contentType: MediaType('*', '*'),
//         ),
//       );
//     }
//
//
//     // for (File editImage in editImages) {
//     //   String fileName = editImage.path.split('/').last; // Extract filename
//     //
//     //   request.files.add(
//     //     await http.MultipartFile.fromPath('image', editImage.path,
//     //         filename: fileName, contentType: MediaType('*', '*')),
//     //   );
//     // }
//
//     showLoading();
//     try {
//       var response = await request.send();
//       hideLoading();
//
//       if (response.statusCode == 200) {
//         var responseBody = await response.stream.bytesToString();
//         var jsonResponse = json.decode(responseBody);
//         GetCompleteList getCompleteList = GetCompleteList.fromJson(jsonResponse);
//         print("List of data : ${jsonEncode(getCompleteList.data)}");
//
//         update();
//         print("Image Uploaded Successfully");
//       } else {
//         print("Failed to upload. Status code: ${response.statusCode}");
//       }
//     } catch (error) {
//       print("Error during upload: $error");
//     }
//   }


  Future<void> getCompleteAPI(context) async {
    // Your existing code...
    DateTime parsedDate = DateFormat("d MMMM, yyyy").parse(selectedDateTextWidget.value);
    String formattedDate = DateFormat("yyyy-MM-dd").format(parsedDate);
    showLoading();

    final url = Uri.parse(Url.pickupRequest);
    final response = await http.post(
      url,
      headers: {
        'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
      },
      body: {
        "user_id": userId.value,
        "price_list": idList.join(','), // Assuming idList is a list of strings/numbers
        "address_id": updateMyAddress==true?addressId.value:"1",
        "pickup_date": formattedDate.toString(),
        "pickup_instructions": instructions.text.toString(),
      },
    );
        print({
          "user_id": userId.value,
          "price_list": idList.join(','), // Assuming idList is a list of strings/numbers
          "address_id": "1",
          "pickup_date": formattedDate.toString(),
          "pickup_instructions": instructions.text.toString(),
        },);

    print("response : ${jsonDecode(response.body)}");
    GetCompleteList getCompleteList = GetCompleteList.fromJson(jsonDecode(response.body));
    hideLoading();

    // GetCompleteList getCompleteList = GetCompleteList.fromJson(responseBody);
    print("getCategoryModels : ${getCompleteList.status}");

    if (getCompleteList.status == 1) {
      getCompleteListData = getCompleteList.data!;
      Fluttertoast.showToast(msg: "${getCompleteList.message}");
      successfullyPopupDialog(context,getCompleteListData);
      print("getCompleteListData : $getCompleteListData");
      update();

    } else {
      Fluttertoast.showToast(msg: "${getCompleteList.message}");
      print("message : ${getCompleteList.message}");
    }
  }


  // Future<void> getCompleteAPI(BuildContext context) async {
  //   print("Test Code : $idList");
  //   DateTime parsedDate = DateFormat("d MMMM, yyyy").parse(selectedDateTextWidget.value);
  //   String formattedDate = DateFormat("yyyy-MM-dd").format(parsedDate);
  //   // try {
  //     final url = Uri.parse(Url.pickupRequest);
  //     final response = await http.post(
  //         url,
  //         headers: {
  //           'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
  //         },
  //         body: {
  //           "user_id": userId.value,
  //           "price_list": idList,
  //           "address_id": "1",
  //           "pickup_date": formattedDate.toString(),
  //           "pickup_instructions": instructions.text.toString(),
  //         }
  //     );
  //     print({
  //       "response : ${jsonDecode(response.body)}"
  //         "user_id": await AppPrefrence.getString('userId'),
  //   "price_list": idList.map((id) => id.toString()).toList(),
  //   "address_id": 1,
  //   "pickup_date": formattedDate.toString(),
  //   "pickup_instructions": instructions.text.toString(),
  //   });
  //     hideLoading();
  //     GetCompleteList getCompleteList = GetCompleteList.fromJson(jsonDecode(response.body));
  //     print("getCategoryModels : ${getCompleteList.status}");
  //     if (getCompleteList.status == 1) {
  //       getCompleteListData = getCompleteList.data!;
  //
  //       successfullyPopupDialog(context);
  //       print("getCompleteListData : $getCompleteListData");
  //       update();
  //     } else {
  //       print("message : ${getCompleteList.message}");
  //     }
  //   // } catch (e) {
  //   //   print("error : $e");
  //   // }
  // }


  void successfullyPopupDialog( context, GetCompleteData getCompleteListData) {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (myContext) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            alignment: Alignment.center,
            backgroundColor: Colors.white,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppImages.successfully,
                  height: 180,
                ),
                const Text(
                  'Pickup Request Sent !',
                  style: TextStyle(
                      color: Color(0xff003032),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins"),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Your Scrap Pickup partner will be coming to your doorstep soon.',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Color(0xff7B7C87),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins"),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          clearData();
                          SellScrapController listData = Get.find();
                          listData.selectedIds.clear();
                          Get.toNamed(Routes.sellScrapView);
                          idList.clear();
                          myselection.clear();
                          submitedId.clear();
                          update();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                                width: 1, color: const Color(0xffE8E9E8)),
                          ),
                          child: const Text(
                            'Go to home',
                            style: TextStyle(
                                color: Color(0xff003032),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins"),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            Routes.trackPickupView,
                            arguments: [
                              {
                                'data': getCompleteListData,
                                'type': "SellScrapItem", // or false, depending on your requirement
                              }
                            ],
                          );
                          currentStep.value = 0;
                          idList.clear();
                          myselection.clear();
                          submitedId.clear();
                          update();
                          // Get.toNamed(Routes.trackPickupView, arguments: getCompleteListData,);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: const Text(
                            'Pickup details',
                            style: TextStyle(
                                color: Color(0xff003032),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
