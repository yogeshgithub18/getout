import 'package:get_out/modal/swipe_card_response.dart';

class ChatModel {
  bool? status;
  String? message;
  ChatDataModel? data;

  ChatModel({this.status, this.message, this.data});

  ChatModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ChatDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ChatDataModel {
  bool? success;
  ChatDataListModel? data;
  String? message;

  ChatDataModel({this.success, this.data, this.message});

  ChatDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data =
        json['data'] != null ? ChatDataListModel.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class ChatDataListModel {
  List<ChatListingModel>? data;
  int? currentPage;
  int? from;
  int? lastPage;

  // Links? links;
  // dynamic nextPageUrl;
  int? perPage;

  // dynamic prevPageUrl;
  int? to;
  int? total;

  ChatDataListModel(
      {this.data,
      this.currentPage,
      this.from,
      this.lastPage,
      // this.links,
      // this.nextPageUrl,
      this.perPage,
      // this.prevPageUrl,
      this.to,
      this.total});

  ChatDataListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ChatListingModel>[];
      json['data'].forEach((v) {
        data!.add(ChatListingModel.fromJson(v));
      });
    }
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    // links = json['links'] != null ? Links.fromJson(json['links']) : null;
    // nextPageUrl = json['next_page_url'];
    perPage = json['per_page'];
    // prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['current_page'] = currentPage;
    data['from'] = from;
    data['last_page'] = lastPage;
    // if (links != null) {
    //   data['links'] = links!.toJson();
    // }
    // data['next_page_url'] = nextPageUrl;
    data['per_page'] = perPage;
    // data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class ChatListingModel {
  int? id;
  int? convenienceId;
  int? chatUserId;
  int? fromId;
  int? toId;
  int? replayId;
  int? like_count;
  int? dislike_count;
  int? emoji_count;
  String? message;
  String? file;
  String? fileType;
  String? isRead;
  String? date;
  String? time;
  String? createdAt;
  String? updatedAt;
  Sender? sender;
  Sender? receiver;
  int? tip;
  List<Cards> ? place;
  List<EventDetails>? eventDetails;

  ChatListingModel(
      {this.id,
      this.convenienceId,
      this.chatUserId,
      this.fromId,
      this.toId,
      this.replayId,
      this.like_count,
      this.dislike_count,
      this.emoji_count,
      this.message,
      this.file,
      this.fileType,
      this.isRead,
      this.date,
      this.time,
      this.createdAt,
      this.updatedAt,
      this.sender,
      this.receiver,
        this.place,
        this.eventDetails,
      this.tip});

  ChatListingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    convenienceId = json['convenience_id'];
    chatUserId = json['chat_user_id'];
    fromId = json['from_id'];
    toId = json['to_id'];
    replayId = json['replay_id'];
    emoji_count = json['emoji_count'];
    like_count = json['like_count'];
    dislike_count = json['dislike_count'];
    message = json['message'];
    file = json['file'];
    fileType = json['file_type'];
    isRead = json['is_read'];
    date = json['date'];
    time = json['time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    receiver = json['receiver'] != null ? Sender.fromJson(json['receiver']) : null;
    tip = json['tip'];
    if (json['place'] != null) {
      place = <Cards>[];
      json['place'].forEach((v) {
        place!.add(Cards.fromJson(v));
      });
    }
    if (json['eventDetails'] != null) {
      eventDetails = <EventDetails>[];
      json['eventDetails'].forEach((v) {
        eventDetails!.add(new EventDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['convenience_id'] = convenienceId;
    data['chat_user_id'] = chatUserId;
    data['from_id'] = fromId;
    data['to_id'] = toId;
    data['replay_id'] = replayId;
    data['message'] = message;
    data['file'] = file;
    data['file_type'] = fileType;
    data['is_read'] = isRead;
    data['date'] = date;
    data['time'] = time;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (sender != null) {
      data['sender'] = sender!.toJson();
    }
    if (receiver != null) {
      data['receiver'] = receiver!.toJson();
    }
    data['tip'] = tip;
    return data;
  }
}

class Sender {
  int? id;
  String? email;
  String? fullName;
  String? userName;
  String? name;

  // dynamic mobileNo;
  // dynamic countryCode;
  int? isOnline;
  String? profileImage;

  Sender(
      {this.id,
      this.email,
      this.fullName,
      this.userName,
      this.name,
      // this.mobileNo,
      // this.countryCode,
      this.isOnline,
      this.profileImage});

  Sender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    fullName = json['full_name'];
    userName = json['user_name'];
    name = json['name'];
    // mobileNo = json['mobile_no'];
    // countryCode = json['country_code'];
    isOnline = json['is_online'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['full_name'] = fullName;
    data['user_name'] = userName;
    data['name'] = name;
    // data['mobile_no'] = mobileNo;
    // data['country_code'] = countryCode;
    data['is_online'] = isOnline;
    data['profile_image'] = profileImage;
    return data;
  }
}

// class Links {
//
//
//   Links({});
//
// Links.fromJson(Map<String, dynamic> json) {
// }
//
// Map<String, dynamic> toJson() {
// final Map<String, dynamic> data = new Map<String, dynamic>();
// return data;
// }
// }

class Data {
  int? id;
  int? convenienceId;
  int? chatUserId;
  int? fromId;
  int? toId;
  int? replayId;
  String? message;
  String? file;
  String? fileType;
  String? isRead;
  String? date;
  String? time;
  String? createdAt;
  String? updatedAt;
  Sender? sender;
  Sender? receiver;
  int? tip;

  Data(
      {this.id,
      this.convenienceId,
      this.chatUserId,
      this.fromId,
      this.toId,
      this.replayId,
      this.message,
      this.file,
      this.fileType,
      this.isRead,
      this.date,
      this.time,
      this.createdAt,
      this.updatedAt,
      this.sender,
      this.receiver,
      this.tip});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    convenienceId = json['convenience_id'];
    chatUserId = json['chat_user_id'];
    fromId = json['from_id'];
    toId = json['to_id'];
    replayId = json['replay_id'];
    message = json['message'];
    file = json['file'];
    fileType = json['file_type'];
    isRead = json['is_read'];
    date = json['date'];
    time = json['time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    receiver =
        json['receiver'] != null ? Sender.fromJson(json['receiver']) : null;
    tip = json['tip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['convenience_id'] = convenienceId;
    data['chat_user_id'] = chatUserId;
    data['from_id'] = fromId;
    data['to_id'] = toId;
    data['replay_id'] = replayId;
    data['message'] = message;
    data['file'] = file;
    data['file_type'] = fileType;
    data['is_read'] = isRead;
    data['date'] = date;
    data['time'] = time;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (sender != null) {
      data['sender'] = sender!.toJson();
    }
    if (receiver != null) {
      data['receiver'] = receiver!.toJson();
    }
    data['tip'] = tip;
    return data;
  }
}

class EventDetails {
  int? id;
  int? userId;
  dynamic eventPlaceId;
  dynamic subCategories;
  String? eventName;
  String? latitude;
  String? longitude;
  String? startTime;
  String? endTime;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? theme;
  String? userName;
  int? eventsCount;

  EventDetails(
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
        this.theme,
        this.userName,
        this.eventsCount});

  EventDetails.fromJson(Map<String, dynamic> json) {
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
    theme = json['theme'];
    userName = json['user_name'];
    eventsCount = json['events_count'];
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
    data['theme'] = this.theme;
    data['user_name'] = this.userName;
    data['events_count'] = this.eventsCount;
    return data;
  }
}
