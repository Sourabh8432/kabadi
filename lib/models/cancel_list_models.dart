class CancelList {
  int? status;
  String? message;
  List<CancelListData>? data;

  CancelList({this.status, this.message, this.data});

  CancelList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CancelListData>[];
      json['data'].forEach((v) {
        data!.add(new CancelListData.fromJson(v));
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

class CancelListData {
  int? cancelReasonId;
  String? reason;

  CancelListData({this.cancelReasonId, this.reason});

  CancelListData.fromJson(Map<String, dynamic> json) {
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
