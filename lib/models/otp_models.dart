class OTPModels {
  int? status;
  String? message;
  OTPData? data;

  OTPModels({this.status, this.message, this.data});

  OTPModels.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new OTPData.fromJson(json['data']) : null;
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

class OTPData {
  String? token;
  OTPUser? user;
  int? isNewUser;

  OTPData({this.token, this.user, this.isNewUser});

  OTPData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new OTPUser.fromJson(json['user']) : null;
    isNewUser = json['is_new_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['is_new_user'] = this.isNewUser;
    return data;
  }
}

class OTPUser {
  String? name;
  String? email;
  String? mobile;
  String? location;
  String? userId;

  OTPUser({this.name, this.email, this.mobile, this.location,this.userId});

  OTPUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    location = json['location'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['location'] = this.location;
    data['user_id'] = this.userId;
    return data;
  }
}



