class CancelReasonList {
  int? status;
  String? message;
  List<Data>? data;

  CancelReasonList({this.status, this.message, this.data});

  CancelReasonList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? cancelReasonId;
  String? reason;

  Data({this.cancelReasonId, this.reason});

  Data.fromJson(Map<String, dynamic> json) {
    cancelReasonId = json['cancel_reason_id'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cancel_reason_id'] = this.cancelReasonId;
    data['reason'] = this.reason;
    return data;
  }
}
