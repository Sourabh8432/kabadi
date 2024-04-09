class GetPriceList {
  int? status;
  String? message;
  List<GetPriceData>? data;

  GetPriceList({this.status, this.message, this.data});

  GetPriceList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetPriceData>[];
      json['data'].forEach((v) {
        data!.add(new GetPriceData.fromJson(v));
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

class GetPriceData {
  int? id;
  String? name;
  String? image;
  List<GetPriceSubCategories>? subCategories;

  GetPriceData({this.id, this.name, this.image, this.subCategories});

  GetPriceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    if (json['sub_categories'] != null) {
      subCategories = <GetPriceSubCategories>[];
      json['sub_categories'].forEach((v) {
        subCategories!.add(new GetPriceSubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    if (this.subCategories != null) {
      data['sub_categories'] =
          this.subCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetPriceSubCategories {
  int? id;
  int? categoryId;
  String? name;
  String? priceUnit;
  String? weightUnit;

  GetPriceSubCategories(
      {this.id, this.categoryId, this.name, this.priceUnit, this.weightUnit});

  GetPriceSubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    priceUnit = json['price_unit'];
    weightUnit = json['weight_unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['price_unit'] = this.priceUnit;
    data['weight_unit'] = this.weightUnit;
    return data;
  }
}
