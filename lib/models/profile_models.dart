class ProfileModel {
  int? status;
  String? message;
  ProfileData? data;

  ProfileModel({this.status, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ProfileData {
  String? name;
  String? email;
  String? mobile;
  String? location;
  String? userId;
  String? image;

  ProfileData({this.name, this.email, this.mobile, this.location, this.userId,this.image});

  ProfileData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    location = json['location'];
    userId = json['user_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['location'] = this.location;
    data['user_id'] = this.userId;
    data['image'] = this.image;
    return data;
  }
}
