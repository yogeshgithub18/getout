class GalleryResponse {
  bool? success;
  List<Images>? data;
  String? message;

  GalleryResponse({this.success, this.data, this.message});

  GalleryResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Images>[];
      json['data'].forEach((v) {
        data!.add(new Images.fromJson(v));
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

class Images {
  int? id;
  int? userId;
  dynamic photo;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;

  Images(
      {this.id,
        this.userId,
        this.photo,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    photo = json['photo'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['photo'] = this.photo;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
