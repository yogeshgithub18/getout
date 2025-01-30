class SwipeCardResponse {
  bool? success;
  List<Cards>? data;
  List<Bars>? bars;
  dynamic message;

  SwipeCardResponse({this.success, this.data, this.bars, this.message});

  SwipeCardResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Cards>[];
      json['data'].forEach((v) {
        data!.add(new Cards.fromJson(v));
      });
    }
    if (json['bars'] != null) {
      bars = <Bars>[];
      json['bars'].forEach((v) {
        bars!.add(new Bars.fromJson(v));
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
    if (this.bars != null) {
      data['bars'] = this.bars!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }

  @override
  String toString()=>"dataaaa----$success";
}

class Cards {
  int? id;
  int? userId;
  String ? description;
  dynamic latitude;
  dynamic longitude;
  dynamic placeId;
  dynamic name;
  dynamic rating;
  dynamic userRatingsTotal;
  dynamic vicinity;
  dynamic priceLevel;
  dynamic types;
  dynamic openNow;
  String ? photo;
  String ? fileType;
  int? status;
  int? isVerify;
  dynamic fetchCategory;
  dynamic searchForMe;
  dynamic createdAt;
  dynamic updatedAt;
  int? isFav;
  int? isStar;
  dynamic distanceMiles;
  List<ReviewData>? reviewData;
  List<String>? multipleImages;

  Cards(
      {this.id,
        this.userId,
        this.latitude,
        this.longitude,
        this.placeId,
        this.name,
        this.rating,
        this.userRatingsTotal,
        this.vicinity,
        this.description,
        this.priceLevel,
        this.types,
        this.fileType,
        this.isVerify,
        this.openNow,
        this.photo,
        this.status,
        this.fetchCategory,
        this.searchForMe,
        this.createdAt,
        this.updatedAt,
        this.isFav,
        this.isStar,
        this.distanceMiles,
        this.multipleImages,
        this.reviewData});

  Cards.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    placeId = json['place_id'];
    name = json['name'];
    isVerify = json['is_verify'];
    rating = json['rating'];
    description=json['description'];
    userRatingsTotal = json['user_ratings_total'];
    vicinity = json['vicinity'];
    priceLevel = json['price_level'];
    types = json['types'];
    fileType = json['file_types'];
    openNow = json['open_now'];
    photo = json['photo'];
    status = json['status'];
    fetchCategory = json['fetch_category'];
    searchForMe = json['search_for_me'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isFav = json['is_fav'];
    isStar = json['is_star'];
    distanceMiles = json['distance_miles'];
    if (json['multiple_images'] != null) {
      multipleImages = json['multiple_images'].cast<String>();
    }
    if (json['review_data'] != null) {
      reviewData = <ReviewData>[];
      json['review_data'].forEach((v) {
        reviewData!.add(ReviewData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['place_id'] = this.placeId;
    data['name'] = this.name;
    data['rating'] = this.rating;
    data['user_ratings_total'] = this.userRatingsTotal;
    data['vicinity'] = this.vicinity;
    data['price_level'] = this.priceLevel;
    data['types'] = this.types;
    data['open_now'] = this.openNow;
    data['photo'] = this.photo;
    data['status'] = this.status;
    data['fetch_category'] = this.fetchCategory;
    data['search_for_me'] = this.searchForMe;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_fav'] = this.isFav;
    data['distance_miles'] = this.distanceMiles;
    data['multiple_images'] = this.multipleImages;
    if (this.reviewData != null) {
      data['review_data'] = this.reviewData!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString()=>"dataaaa----$isFav";
}
class ReviewData {
  int? id;
  int? userId;
  dynamic photo;
  dynamic placeId;
  dynamic caption;
  int? status;
  dynamic createdAt;
  dynamic updatedAt;

  ReviewData(
      {this.id,
        this.userId,
        this.photo,
        this.placeId,
        this.caption,
        this.status,
        this.createdAt,
        this.updatedAt});

  ReviewData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    photo = json['photo'];
    placeId = json['place_id'];
    caption = json['caption'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['photo'] = this.photo;
    data['place_id'] = this.placeId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Bars {
  int? id;
  dynamic barTitle;
  int? barPercentage;
  int? barStatus;
  dynamic createdAt;
  dynamic updatedAt;

  Bars(
      {this.id,
        this.barTitle,
        this.barPercentage,
        this.barStatus,
        this.createdAt,
        this.updatedAt});

  Bars.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barTitle = json['bar_title'];
    barPercentage = json['bar_percentage'];
    barStatus = json['bar_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bar_title'] = this.barTitle;
    data['bar_percentage'] = this.barPercentage;
    data['bar_status'] = this.barStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
