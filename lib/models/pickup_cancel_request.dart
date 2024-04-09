class PickupCancelRequest {
  int? status;
  String? message;
  PickupCancelData? data;

  PickupCancelRequest({this.status, this.message, this.data});

  PickupCancelRequest.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new PickupCancelData.fromJson(json['data']) : null;
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

class PickupCancelData {
  String? pickupStatus;
  String? pickupStatusText;
  String? pickupRequestId;
  String? pickupDate;
  String? pickupTime;
  String? pickupCancellationReason;
  List<PickupCanceItems>? pickupItems;
  PickupCancelAddress? pickupAddress;
  String? pickupInstructions;

  PickupCancelData(
      {this.pickupStatus,
        this.pickupStatusText,
        this.pickupRequestId,
        this.pickupDate,
        this.pickupTime,
        this.pickupCancellationReason,
        this.pickupItems,
        this.pickupAddress,
        this.pickupInstructions});

  PickupCancelData.fromJson(Map<String, dynamic> json) {
    pickupStatus = json['pickup_status'];
    pickupStatusText = json['pickup_status_text'];
    pickupRequestId = json['pickup_request_id'];
    pickupDate = json['pickup_date'];
    pickupTime = json['pickup_time'];
    pickupCancellationReason = json['pickup_cancellation_reason'];
    if (json['pickup_items'] != null) {
      pickupItems = <PickupCanceItems>[];
      json['pickup_items'].forEach((v) {
        pickupItems!.add(new PickupCanceItems.fromJson(v));
      });
    }
    pickupAddress = json['pickup_address'] != null
        ? new PickupCancelAddress.fromJson(json['pickup_address'])
        : null;
    pickupInstructions = json['pickup_instructions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pickup_status'] = this.pickupStatus;
    data['pickup_status_text'] = this.pickupStatusText;
    data['pickup_request_id'] = this.pickupRequestId;
    data['pickup_date'] = this.pickupDate;
    data['pickup_time'] = this.pickupTime;
    data['pickup_cancellation_reason'] = this.pickupCancellationReason;
    if (this.pickupItems != null) {
      data['pickup_items'] = this.pickupItems!.map((v) => v.toJson()).toList();
    }
    if (this.pickupAddress != null) {
      data['pickup_address'] = this.pickupAddress!.toJson();
    }
    data['pickup_instructions'] = this.pickupInstructions;
    return data;
  }
}

class PickupCanceItems {
  String? priceListName;
  String? priceUnit;
  String? weightUnit;
  int? priceListId;
  int? categoryId;
  String? categoryName;

  PickupCanceItems(
      {this.priceListName,
        this.priceUnit,
        this.weightUnit,
        this.priceListId,
        this.categoryId,
        this.categoryName});

  PickupCanceItems.fromJson(Map<String, dynamic> json) {
    priceListName = json['price_list_name'];
    priceUnit = json['price_unit'];
    weightUnit = json['weight_unit'];
    priceListId = json['price_list_id'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price_list_name'] = this.priceListName;
    data['price_unit'] = this.priceUnit;
    data['weight_unit'] = this.weightUnit;
    data['price_list_id'] = this.priceListId;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    return data;
  }
}

class PickupCancelAddress {
  String? locationType;
  String? locality;
  String? addressLine;
  String? longitude;
  String? latitude;
  String? pincode;

  PickupCancelAddress(
      {this.locationType,
        this.locality,
        this.addressLine,
        this.longitude,
        this.latitude,
        this.pincode});

  PickupCancelAddress.fromJson(Map<String, dynamic> json) {
    locationType = json['location_type'];
    locality = json['locality'];
    addressLine = json['address_line'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location_type'] = this.locationType;
    data['locality'] = this.locality;
    data['address_line'] = this.addressLine;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['pincode'] = this.pincode;
    return data;
  }
}
