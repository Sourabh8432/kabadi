class GetLocatonModels {
  int? status;
  String? message;
  GetLocatonData? data;

  GetLocatonModels({this.status, this.message, this.data});

  GetLocatonModels.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new GetLocatonData.fromJson(json['data']) : null;
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

class GetLocatonData {
  String? name;
  String? mobile;

  GetLocatonData({this.name, this.mobile});

  GetLocatonData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    return data;
  }
}
