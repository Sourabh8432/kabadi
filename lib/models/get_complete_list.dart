class GetCompleteList {
  int? status;
  String? message;
  GetCompleteData? data;

  GetCompleteList({this.status, this.message, this.data});

  GetCompleteList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new GetCompleteData.fromJson(json['data']) : null;
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

class GetCompleteData {
  String? pickupStatus;
  String? pickupStatusText;
  String? pickupRequestId;
  String? pickupDate;
  String? pickupTime;
  List<String>? images;
  String? pickupCancellationReason;
  List<GetCompletePickupItems>? pickupItems;
  GetCompletePickupAddress? pickupAddress;
  String? pickupInstructions;

  GetCompleteData({
    this.pickupStatus,
    this.pickupStatusText,
    this.pickupRequestId,
    this.pickupDate,
    this.pickupTime,
    this.images,
    this.pickupCancellationReason,
    this.pickupItems,
    this.pickupAddress,
    this.pickupInstructions,
  });

  GetCompleteData.fromJson(Map<String, dynamic> json) {
    pickupStatus = json['pickup_status'];
    pickupStatusText = json['pickup_status_text'];
    pickupRequestId = json['pickup_request_id'];
    pickupDate = json['pickup_date'];
    pickupTime = json['pickup_time'];
    pickupCancellationReason = json['pickup_cancellation_reason'];
    pickupInstructions = json['pickup_instructions'];

    // Handle 'images' field as List<dynamic> to List<String>
    if (json['images'] != null) {
      images = (json['images'] as List<dynamic>).map((e) => e.toString()).toList();
    }

    // Handle 'pickup_items' field as List<dynamic> to List<GetCompletePickupItems>
    if (json['pickup_items'] != null) {
      pickupItems = List<GetCompletePickupItems>.from(
        json['pickup_items'].map((item) => GetCompletePickupItems.fromJson(item)),
      );
    }

    // Handle 'pickup_address' field as Map<String, dynamic> to GetCompletePickupAddress
    if (json['pickup_address'] != null) {
      pickupAddress = GetCompletePickupAddress.fromJson(json['pickup_address']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'pickup_status': pickupStatus,
      'pickup_status_text': pickupStatusText,
      'pickup_request_id': pickupRequestId,
      'pickup_date': pickupDate,
      'pickup_time': pickupTime,
      'pickup_cancellation_reason': pickupCancellationReason,
      'pickup_instructions': pickupInstructions,
    };

    if (images != null) {
      data['images'] = images;
    }

    if (pickupItems != null) {
      data['pickup_items'] = pickupItems!.map((item) => item.toJson()).toList();
    }

    if (pickupAddress != null) {
      data['pickup_address'] = pickupAddress!.toJson();
    }

    return data;
  }
}

class GetCompletePickupItems {
  String? priceListName;
  String? priceUnit;
  String? weightUnit;
  int? priceListId;
  int? categoryId;
  String? categoryName;

  GetCompletePickupItems(
      {this.priceListName,
        this.priceUnit,
        this.weightUnit,
        this.priceListId,
        this.categoryId,
        this.categoryName});

  GetCompletePickupItems.fromJson(Map<String, dynamic> json) {
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

class GetCompletePickupAddress {
  String? locationType;
  String? locality;
  String? addressLine;
  String? longitude;
  String? latitude;
  String? pincode;

  GetCompletePickupAddress(
      {this.locationType,
        this.locality,
        this.addressLine,
        this.longitude,
        this.latitude,
        this.pincode});

  GetCompletePickupAddress.fromJson(Map<String, dynamic> json) {
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
