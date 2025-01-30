class ThemeResponse {
  bool? success;
  List<ThemeList>? data;
  String? message;

  ThemeResponse({this.success, this.data, this.message});

  ThemeResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ThemeList>[];
      json['data'].forEach((v) {
        data!.add(new ThemeList.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class ThemeList {
  int? id;
  String? name;
  String? photo;
  int? status;
  String? createdAt;
  String? updatedAt;

  ThemeList(
      {this.id,
        this.name,
        this.photo,
        this.status,
        this.createdAt,
        this.updatedAt});

  ThemeList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
