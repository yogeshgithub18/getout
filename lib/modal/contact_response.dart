class SyncContactResponse {
  bool? success;
  List<SyncData>? data;
  String? message;

  SyncContactResponse({this.success, this.data, this.message});

  SyncContactResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SyncData>[];
      json['data'].forEach((v) {
        data!.add(new SyncData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class SyncData {
  String? name;
  String? number;
  String? email;
  int ? userId;
  bool ? isavailable;
  bool ? alreadyFriend;


  SyncData(
      {this.name,
        this.number,
        this.email,
        this.userId,this.alreadyFriend,
        this.isavailable});

  SyncData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    number = json['number'];
    email = json['email'];
    userId = json['userId'];
    alreadyFriend = json['alreadyFriend'];
    isavailable= json['isavailable'];
  }
}