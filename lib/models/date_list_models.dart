class DateList {
  int? status;
  String? message;
  List<DateListData>? data;

  DateList({this.status, this.message, this.data});

  DateList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DateListData>[];
      json['data'].forEach((v) {
        data!.add(DateListData.fromJson(v));
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

class DateListData {
  String? date;
  String? dateText;

  DateListData({this.date, this.dateText});

  DateListData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    dateText = json['date_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['date_text'] = this.dateText;
    return data;
  }
}
