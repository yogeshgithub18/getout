class ItieneraryDetailsResponse {
  bool? success;
  ItineararyData? data;
  String? message;

  ItieneraryDetailsResponse({this.success, this.data, this.message});

  ItieneraryDetailsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new ItineararyData.fromJson(json['data']) : null;
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

class ItineararyData {
  int? id;
  int? userId;
  String? eventPlaceId;
  String? subCategories;
  String? eventName;
  String? latitude;
  String? longitude;
  String? startTime;
  String? endTime;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<ItenaryDetails>? itenaryDetails;

  ItineararyData(
      {this.id,
        this.userId,
        this.eventPlaceId,
        this.subCategories,
        this.eventName,
        this.latitude,
        this.longitude,
        this.startTime,
        this.endTime,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.itenaryDetails});

  ItineararyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    eventPlaceId = json['event_place_id'];
    subCategories = json['sub_categories'];
    eventName = json['event_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['itenary_details'] != null) {
      itenaryDetails = <ItenaryDetails>[];
      json['itenary_details'].forEach((v) {
        itenaryDetails!.add(new ItenaryDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['event_place_id'] = this.eventPlaceId;
    data['sub_categories'] = this.subCategories;
    data['event_name'] = this.eventName;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.itenaryDetails != null) {
      data['itenary_details'] =
          this.itenaryDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItenaryDetails {
  int? id;
  int? userId;
  String? latitude;
  String? longitude;
  String? placeId;
  String? name;
  String? rating;
  String? userRatingsTotal;
  String? vicinity;
  dynamic priceLevel;
  String? types;
  String? openNow;
  String? photo;
  int? status;
  String? fetchCategory;
  String? searchForMe;
  String? createdAt;
  String? updatedAt;

  ItenaryDetails(
      {this.id,
        this.userId,
        this.latitude,
        this.longitude,
        this.placeId,
        this.name,
        this.rating,
        this.userRatingsTotal,
        this.vicinity,
        this.priceLevel,
        this.types,
        this.openNow,
        this.photo,
        this.status,
        this.fetchCategory,
        this.searchForMe,
        this.createdAt,
        this.updatedAt});

  ItenaryDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    placeId = json['place_id'];
    name = json['name'];
    rating = json['rating'];
    userRatingsTotal = json['user_ratings_total'];
    vicinity = json['vicinity'];
    priceLevel = json['price_level'];
    types = json['types'];
    openNow = json['open_now'];
    photo = json['photo'];
    status = json['status'];
    fetchCategory = json['fetch_category'];
    searchForMe = json['search_for_me'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    return data;
  }
}
