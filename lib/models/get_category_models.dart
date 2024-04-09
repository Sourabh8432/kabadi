class GetCategoryModels {
  int? status;
  String? message;
  List<GetCategoryData>? data;

  GetCategoryModels({this.status, this.message, this.data});

  GetCategoryModels.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetCategoryData>[];
      json['data'].forEach((v) {
        data!.add(new GetCategoryData.fromJson(v));
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

class GetCategoryData {
  String? categoryName;
  int? categoryId;
  String? categoryImage;
  String? priceListName;
  bool isCheck;

  GetCategoryData({
    this.categoryName,
    this.categoryId,
    this.categoryImage,
    this.priceListName,
    this.isCheck = false,
  });

  GetCategoryData.fromJson(Map<String, dynamic> json)
      : categoryName = json['category_name'],
        categoryId = json['category_id'],
        categoryImage = json['category_image'],
        priceListName = json['price_list_name'],
        isCheck = json['is_check'] ?? false; // Ensure proper conversion to boolean

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_name'] = categoryName;
    data['category_id'] = categoryId;
    data['category_image'] = categoryImage;
    data['price_list_name'] = priceListName;
    data['is_check'] = isCheck;
    return data;
  }
}

