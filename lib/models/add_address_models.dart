class AddAddressModels {
  int? status;
  String? message;
  AddAddressData? data;

  AddAddressModels({this.status, this.message, this.data});

  AddAddressModels.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new AddAddressData.fromJson(json['data']) : null;
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

class AddAddressData {
  int? addressId;
  String? locationType;
  String? locality;
  String? addressLine;
  String? longitude;
  String? latitude;
  String? pincode;

  AddAddressData(
      {this.addressId,
        this.locationType,
        this.locality,
        this.addressLine,
        this.longitude,
        this.latitude,
        this.pincode});

  AddAddressData.fromJson(Map<String, dynamic> json) {
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
