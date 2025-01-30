class ItieneraryListResponse {
  bool? success;
  List<ItinenaryData>? data;
  String? message;

  ItieneraryListResponse({this.success, this.data, this.message});

  ItieneraryListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ItinenaryData>[];
      json['data'].forEach((v) {
        data!.add(new ItinenaryData.fromJson(v));
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

class ItinenaryData {
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

  ItinenaryData(
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

  ItinenaryData.fromJson(Map<String, dynamic> json) {
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
  int? eventId;
  String? placeId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  EventsDetails? eventsDetails;


  ItenaryDetails(
      {this.id,
        this.eventId,
        this.placeId,
        this.userId,
        this.createdAt,
        this.eventsDetails,
        this.updatedAt});

  ItenaryDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventId = json['event_id'];
    placeId = json['place_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    eventsDetails = json['events_details'] != null
        ? new EventsDetails.fromJson(json['events_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_id'] = this.eventId;
    data['place_id'] = this.placeId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.eventsDetails != null) {
      data['events_details'] = this.eventsDetails!.toJson();
    }
    return data;
  }
}

class EventsDetails {
  String? photo;
  String? placeId;

  EventsDetails({this.photo, this.placeId});

  EventsDetails.fromJson(Map<String, dynamic> json) {
    photo = json['photo'];
    placeId = json['place_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photo'] = this.photo;
    data['place_id'] = this.placeId;
    return data;
  }
}