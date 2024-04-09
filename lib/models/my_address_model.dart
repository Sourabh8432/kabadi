class MyAddress {
  int? status;
  String? message;
  List<MyAddressData>? data;

  MyAddress({this.status, this.message, this.data});

  MyAddress.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MyAddressData>[];
      json['data'].forEach((v) {
        data!.add(new MyAddressData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyAddressData {
  int? addressId;
  String? locationType;
  String? locality;
  String? addressLine;
  String? longitude;
  String? latitude;
  String? pincode;

  MyAddressData(
      {this.addressId,
        this.locationType,
        this.locality,
        this.addressLine,
        this.longitude,
        this.latitude,
        this.pincode});

  MyAddressData.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    locationType = json['location_type'];
    locality = json['locality'];
    addressLine = json['address_line'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.addressId;
    data['location_type'] = this.locationType;
    data['locality'] = this.locality;
    data['address_line'] = this.addressLine;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['pincode'] = this.pincode;
    return data;
  }
}
