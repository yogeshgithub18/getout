import 'package:get_out/modal/swipe_card_response.dart';

class ThemeEventsResponse {
  bool? success;
  List<Cards>? data;
  String? message;

  ThemeEventsResponse({this.success, this.data, this.message});

  ThemeEventsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Cards>[];
      json['data'].forEach((v) {
        data!.add(new Cards.fromJson(v));
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

class Data {
  int? userId;
  String? fetchCategory;
  String? placeId;
  String? name;
  double? latitude;
  double? longitude;
  double? rating;
  int? userRatingsTotal;
  String? types;
  String? vicinity;
  Null? priceLevel;
  bool? openNow;
  String? searchForMe;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.userId,
        this.fetchCategory,
        this.placeId,
        this.name,
        this.latitude,
        this.longitude,
        this.rating,
        this.userRatingsTotal,
        this.types,
        this.vicinity,
        this.priceLevel,
        this.openNow,
        this.searchForMe,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fetchCategory = json['fetch_category'];
    placeId = json['place_id'];
    name = json['name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    rating = json['rating'];
    userRatingsTotal = json['user_ratings_total'];
    types = json['types'];
    vicinity = json['vicinity'];
    priceLevel = json['price_level'];
    openNow = json['open_now'];
    searchForMe = json['search_for_me'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['fetch_category'] = this.fetchCategory;
    data['place_id'] = this.placeId;
    data['name'] = this.name;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['rating'] = this.rating;
    data['user_ratings_total'] = this.userRatingsTotal;
    data['types'] = this.types;
    data['vicinity'] = this.vicinity;
    data['price_level'] = this.priceLevel;
    data['open_now'] = this.openNow;
    data['search_for_me'] = this.searchForMe;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
