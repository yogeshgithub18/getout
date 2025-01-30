class ActionCount {
  bool? success;
  Data? data;
  String? message;

  ActionCount({this.success, this.data, this.message});

  ActionCount.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? likeCount;
  String? dislikeCount;
  String? emojiCount;

  Data({this.likeCount, this.dislikeCount, this.emojiCount});

  Data.fromJson(Map<String, dynamic> json) {
    likeCount = json['like_count'];
    dislikeCount = json['dislike_count'];
    emojiCount = json['emoji_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['like_count'] = this.likeCount;
    data['dislike_count'] = this.dislikeCount;
    data['emoji_count'] = this.emojiCount;
    return data;
  }
}
