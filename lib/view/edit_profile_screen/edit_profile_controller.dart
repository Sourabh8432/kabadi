import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:kabadi_app/network/urls.dart';
import '../../models/edit_profile_image.dart';
import '../../models/edit_profile_models.dart';
import '../../utils/app_prefrences.dart';
import 'package:http_parser/http_parser.dart';

import '../profile_screen/profile_controller.dart';

class EditProfileController extends GetxController {
  RxString selfiePath = ''.obs;
  RxBool isLoading = false.obs;
  final ImagePicker _imagePicker = ImagePicker();
  dynamic myArguments = Get.arguments;
  var profileData;
  String profileImage = "";
  RxString userId = "".obs;
  RxString number = "".obs;
  RxString getName = "".obs;
  RxString email = "".obs;
  TextEditingController name = TextEditingController();
  TextEditingController editLocationname = TextEditingController();
  TextEditingController editEmail = TextEditingController();
  ProfileController profilePage = Get.find();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getNumber();
    print("object : ${myArguments[2]['image']}");
  }

  void getNumber() async{
    number.value = await AppPrefrence.getString('mobile');
    getName.value = await AppPrefrence.getString('name');
    email.value = await AppPrefrence.getString('email');
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

  Future<void> getSelfieImage(BuildContext context, ImageSource source) async {
    FocusScope.of(context).unfocus();
    final pickedFile = await _imagePicker.pickImage(
        source: source,
        imageQuality: 70,
        preferredCameraDevice: CameraDevice.front);

    if (pickedFile != null) {
      selfiePath.value = pickedFile.path;
      update();
    }
    update();
  }

  Future<void> editProfile(String editName, String editLocation, String editEmailId) async {
    print("message : $editName $editLocation $editEmailId ${editEmailId.runtimeType}");
    try {
      showLoading();
      final url = Uri.parse(Url.editProfileUrl);
      final response = await http.post(url, headers: {
        'Authorization': "Bearer ${await AppPrefrence.getString('token')}",
        'Accept': 'application/json'
      }, body: {
        "name": editName,
        "user_id": myArguments[1]['user_id'],
        "location": editLocation,
        "email": editEmailId,

      });
      hideLoading();
      EditProfile editProfile = EditProfile.fromJson(jsonDecode(response.body));
      print("editProfile : ${jsonDecode(response.body)}");
      if (editProfile.status == 1) {
        profileData = editProfile.data!;
        Fluttertoast.showToast(msg: editProfile.message!);
        print("message : ${editProfile.message}");
        Get.back();
        profilePage.profileApi();
        update();
      } else {
        Fluttertoast.showToast(msg: editProfile.message!);
        print("message : ${editProfile.message}");
      }
    } catch (e) {
      print("error : $e");
    }
  }

  Future<void> editProfileImage(String editImage) async {
    var postUri = Uri.parse(Url.editProfileImageUrl);
    var request = http.MultipartRequest("POST", postUri);
    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers['Authorization'] =
        "Bearer ${await AppPrefrence.getString('token')}";
    request.fields['Accept'] = 'application/json';
    request.fields['user_id'] = myArguments[1]['user_id'];

    request.files.add(
      await http.MultipartFile.fromPath('image', editImage,
          contentType: MediaType('*', '*')),
    );
    showLoading();
    try {
      var response = await request.send();
      hideLoading();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);
        EditImageUpload editImageUpload =
            EditImageUpload.fromJson(jsonResponse);
        profileImage = editImageUpload.data!;
        AppPrefrence.putString("profile_image", editImageUpload.data ?? "");
        print("profileImage : ${jsonEncode(editImageUpload)}");
        profilePage.profileApi();
        update();
        print("Image Uploaded Successfully");
      } else {
        print("Failed to upload. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error during upload: $error");
    }
  }
}
