class MyFriendResponse {
  bool? success;
  List<FriendData>? data;
  String? message;

  MyFriendResponse({this.success, this.data, this.message});

  MyFriendResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <FriendData>[];
      json['data'].forEach((v) {
        data!.add(new FriendData.fromJson(v));
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

class FriendData {
  int? id;
  int? userId;
  int? friendId;
  String? createdAt;
  String? updatedAt;
  FriendDetails? friendDetails;
  RoomDetails? roomDetails;

  FriendData(
      {this.id,
        this.userId,
        this.friendId,
        this.createdAt,
        this.updatedAt,
        this.friendDetails,this.roomDetails});

  FriendData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    friendId = json['friend_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    friendDetails = json['friend_details'] != null
        ? new FriendDetails.fromJson(json['friend_details'])
        : null;
    roomDetails = json['room_details'] != null
        ? new RoomDetails.fromJson(json['room_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['friend_id'] = this.friendId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.friendDetails != null) {
      data['friend_details'] = this.friendDetails!.toJson();
    }
    if (this.roomDetails != null) {
      data['room_details'] = this.roomDetails!.toJson();
    }
    return data;
  }
}

class FriendDetails {
  int? id;
  String? name;
  dynamic lastName;
  String? lattitute;
  String? longitute;
  String? howOld;
  String? email;
  String? mobile;
  dynamic dob;
  String? gender;
  int? isOnline;
  String? countryCode;
  String? otp;
  String? token;
  String? profile;
  dynamic bio;
  int? roleId;
  dynamic roomId;
  dynamic socialId;
  dynamic loginType;
  int? isVerify;
  int? status;
  int? isSendNotification;
  String? emailVerifiedAt;
  int? phoneVerifiedAt;
  dynamic deviceToken;
  dynamic socketId;
  String? createdAt;
  String? updatedAt;

  FriendDetails(
      {this.id,
        this.name,
        this.lastName,
        this.lattitute,
        this.longitute,
        this.howOld,
        this.email,
        this.mobile,
        this.dob,
        this.gender,
        this.isOnline,
        this.countryCode,
        this.otp,
        this.token,
        this.profile,
        this.bio,
        this.roleId,
        this.roomId,
        this.socialId,
        this.loginType,
        this.isVerify,
        this.status,
        this.isSendNotification,
        this.emailVerifiedAt,
        this.phoneVerifiedAt,
        this.deviceToken,
        this.socketId,
        this.createdAt,
        this.updatedAt});

  FriendDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['last_name'];
    lattitute = json['lattitute'];
    longitute = json['longitute'];
    howOld = json['how_old'];
    email = json['email'];
    mobile = json['mobile'];
    dob = json['dob'];
    gender = json['gender'];
    isOnline = json['is_online'];
    countryCode = json['country_code'];
    otp = json['otp'];
    token = json['token'];
    profile = json['profile'];
    bio = json['bio'];
    roleId = json['role_id'];
    roomId = json['room_id'];
    socialId = json['social_id'];
    loginType = json['login_type'];
    isVerify = json['is_verify'];
    status = json['status'];
    isSendNotification = json['is_send_notification'];
    emailVerifiedAt = json['email_verified_at'];
    phoneVerifiedAt = json['phone_verified_at'];
    deviceToken = json['device_token'];
    socketId = json['socket_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['last_name'] = this.lastName;
    data['lattitute'] = this.lattitute;
    data['longitute'] = this.longitute;
    data['how_old'] = this.howOld;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['is_online'] = this.isOnline;
    data['country_code'] = this.countryCode;
    data['otp'] = this.otp;
    data['token'] = this.token;
    data['profile'] = this.profile;
    data['bio'] = this.bio;
    data['role_id'] = this.roleId;
    data['room_id'] = this.roomId;
    data['social_id'] = this.socialId;
    data['login_type'] = this.loginType;
    data['is_verify'] = this.isVerify;
    data['status'] = this.status;
    data['is_send_notification'] = this.isSendNotification;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone_verified_at'] = this.phoneVerifiedAt;
    data['device_token'] = this.deviceToken;
    data['socket_id'] = this.socketId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class RoomDetails {
  int? id;
  String? ticketId;
  String? ticketType;
  String? groupName;
  String? type;
  String? lastMessage;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  RoomDetails({this.id,
    this.ticketId,
    this.ticketType,
    this.groupName,
    this.type,
    this.lastMessage,
    this.createdAt,
    this.updatedAt,
    this.deletedAt});

  RoomDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ticketId = json['ticket_id'];
    ticketType = json['ticket_type'];
    groupName = json['group_name'];
    type = json['type'];
    lastMessage = json['last_message'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ticket_id'] = this.ticketId;
    data['ticket_type'] = this.ticketType;
    data['group_name'] = this.groupName;
    data['type'] = this.type;
    data['last_message'] = this.lastMessage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}