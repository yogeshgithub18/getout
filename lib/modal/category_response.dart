class CategoryResponse {
  bool? success;
  List<Interest>? data;
  String? message;

  CategoryResponse({this.success, this.data, this.message});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Interest>[];
      json['data'].forEach((v) {
        data!.add(new Interest.fromJson(v));
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

class Interest {
  int? id;
  String? title;
  String? description;
  dynamic image;
  int? status;
  dynamic createdAt;
  dynamic updatedAt;

  Interest(
      {this.id,
        this.title,
        this.description,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt});

  Interest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
