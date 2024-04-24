class PickupRequestModels {
  int? status;
  String? message;
  PickupRequestData? data;

  PickupRequestModels({this.status, this.message, this.data});

  PickupRequestModels.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? PickupRequestData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PickupRequestData {
  List<PickupRequestUpcoming>? upcoming;
  List<PickupRequestPrevious>? previous;

  PickupRequestData({this.upcoming, this.previous});

  PickupRequestData.fromJson(Map<String, dynamic> json) {
    upcoming = json['upcoming'] != null
        ? List<PickupRequestUpcoming>.from(json['upcoming'].map((x) => PickupRequestUpcoming.fromJson(x)))
        : null;
    previous = json['previous'] != null
        ? List<PickupRequestPrevious>.from(json['previous'].map((x) => PickupRequestPrevious.fromJson(x)))
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (upcoming != null) {
      data['upcoming'] = upcoming!.map((x) => x.toJson()).toList();
    }
    if (previous != null) {
      data['previous'] = previous!.map((x) => x.toJson()).toList();
    }
    return data;
  }
}

class PickupRequestUpcoming {
  String? pickupStatus;
  String? pickupItemsName;
  String? pickupStatusText;
  String? pickupRequestId;
  String? pickupDate;
  String? pickupTime;
  List<String>? images;
  String? pickupCancellationReason;
  List<PickupRequestItems>? pickupItems;
  PickupRequestAddress? pickupAddress;
  String? pickupInstructions;
  String? payment;
  String? remark;

  PickupRequestUpcoming({
    this.pickupStatus,
    this.pickupItemsName,
    this.pickupStatusText,
    this.pickupRequestId,
    this.pickupDate,
    this.pickupTime,
    this.images,
    this.pickupCancellationReason,
    this.pickupItems,
    this.pickupAddress,
    this.pickupInstructions,
    this.payment,
    this.remark,
  });

  PickupRequestUpcoming.fromJson(Map<String, dynamic> json) {
    pickupStatus = json['pickup_status'];
    pickupItemsName = json['pickup_items_name'];
    pickupStatusText = json['pickup_status_text'];
    pickupRequestId = json['pickup_request_id'];
    pickupDate = json['pickup_date'];
    pickupTime = json['pickup_time'];
    images = json['images'] != null ? List<String>.from(json['images']) : null;
    pickupCancellationReason = json['pickup_cancellation_reason'];
    if (json['pickup_items'] != null) {
      pickupItems = List<PickupRequestItems>.from(json['pickup_items'].map((x) => PickupRequestItems.fromJson(x)));
    }
    pickupAddress = json['pickup_address'] != null ? PickupRequestAddress.fromJson(json['pickup_address']) : null;
    pickupInstructions = json['pickup_instructions'];
    payment = json['payment'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['pickup_status'] = pickupStatus;
    data['pickup_items_name'] = pickupItemsName;
    data['pickup_status_text'] = pickupStatusText;
    data['pickup_request_id'] = pickupRequestId;
    data['pickup_date'] = pickupDate;
    data['pickup_time'] = pickupTime;
    if (images != null) {
      data['images'] = images;
    }
    data['pickup_cancellation_reason'] = pickupCancellationReason;
    if (pickupItems != null) {
      data['pickup_items'] = pickupItems!.map((x) => x.toJson()).toList();
    }
    if (pickupAddress != null) {
      data['pickup_address'] = pickupAddress!.toJson();
    }
    data['pickup_instructions'] = pickupInstructions;
    data['payment'] = payment;
    data['remark'] = remark;
    return data;
  }
}

class PickupRequestPrevious {
  String? pickupStatus;
  String? pickupItemsName;
  String? pickupStatusText;
  String? pickupRequestId;
  String? pickupDate;
  String? pickupTime;
  List<String>? images;
  String? pickupCancellationReason;
  List<PickupRequestItems>? pickupItems;
  PickupRequestAddress? pickupAddress;
  String? pickupInstructions;
  String? payment;
  String? remark;

  PickupRequestPrevious({
    this.pickupStatus,
    this.pickupItemsName,
    this.pickupStatusText,
    this.pickupRequestId,
    this.pickupDate,
    this.pickupTime,
    this.images,
    this.pickupCancellationReason,
    this.pickupItems,
    this.pickupAddress,
    this.pickupInstructions,
    this.payment,
    this.remark,
  });

  PickupRequestPrevious.fromJson(Map<String, dynamic> json) {
    pickupStatus = json['pickup_status'];
    pickupItemsName = json['pickup_items_name'];
    pickupStatusText = json['pickup_status_text'];
    pickupRequestId = json['pickup_request_id'];
    pickupDate = json['pickup_date'];
    pickupTime = json['pickup_time'];
    images = json['images'] != null ? List<String>.from(json['images']) : null;
    pickupCancellationReason = json['pickup_cancellation_reason'];
    if (json['pickup_items'] != null) {
      pickupItems = List<PickupRequestItems>.from(json['pickup_items'].map((x) => PickupRequestItems.fromJson(x)));
    }
    pickupAddress = json['pickup_address'] != null ? PickupRequestAddress.fromJson(json['pickup_address']) : null;
    pickupInstructions = json['pickup_instructions'];
    payment = json['payment'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['pickup_status'] = pickupStatus;
    data['pickup_items_name'] = pickupItemsName;
    data['pickup_status_text'] = pickupStatusText;
    data['pickup_request_id'] = pickupRequestId;
    data['pickup_date'] = pickupDate;
    data['pickup_time'] = pickupTime;
    if (images != null) {
      data['images'] = images;
    }
    data['pickup_cancellation_reason'] = pickupCancellationReason;
    if (pickupItems != null) {
      data['pickup_items'] = pickupItems!.map((x) => x.toJson()).toList();
    }
    if (pickupAddress != null) {
      data['pickup_address'] = pickupAddress!.toJson();
    }
    data['pickup_instructions'] = pickupInstructions;
    data['payment'] = payment;
    data['remark'] = remark;
    return data;
  }
}

class PickupRequestItems {
  String? priceListName;
  String? priceUnit;
  String? weightUnit;
  int? priceListId;
  int? categoryId;
  String? categoryName;

  PickupRequestItems({
    this.priceListName,
    this.priceUnit,
    this.weightUnit,
    this.priceListId,
    this.categoryId,
    this.categoryName,
  });

  PickupRequestItems.fromJson(Map<String, dynamic> json) {
    priceListName = json['price_list_name'];
    priceUnit = json['price_unit'];
    weightUnit = json['weight_unit'];
    priceListId = json['price_list_id'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['price_list_name'] = priceListName;
    data['price_unit'] = priceUnit;
    data['weight_unit'] = weightUnit;
    data['price_list_id'] = priceListId;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    return data;
  }
}

class PickupRequestAddress {
  String? locationType;
  String? locality;
  String? addressLine;
  String? longitude;
  String? latitude;
  String? pincode;

  PickupRequestAddress({
    this.locationType,
    this.locality,
    this.addressLine,
    this.longitude,
    this.latitude,
    this.pincode,
  });

  PickupRequestAddress.fromJson(Map<String, dynamic> json) {
    locationType = json['location_type'];
    locality = json['locality'];
    addressLine = json['address_line'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['location_type'] = locationType;
    data['locality'] = locality;
    data['address_line'] = addressLine;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['pincode'] = pincode;
    return data;
  }
}
