class GroupListResponse {
  bool? success;
  List<GroupData>? data;
  String? message;

  GroupListResponse({this.success, this.data, this.message});

  GroupListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <GroupData>[];
      json['data'].forEach((v) {
        data!.add(new GroupData.fromJson(v));
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

class GroupData {
  int? id;
  String? groupName;
  String? groupImage;
  String? type;
  String? lastMessage;
  int? totalUnread;
  String? updatedAt;
  dynamic chatuser;
  Group? group;

  GroupData(
      {this.id,
        this.groupName,
        this.groupImage,
        this.type,
        this.lastMessage,
        this.totalUnread,
        this.updatedAt,
        this.chatuser,
        this.group});

  GroupData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupName = json['group_name'];
    groupImage = json['group_image'];
    type = json['type'];
    lastMessage = json['last_message'];
    totalUnread = json['total_unread'];
    updatedAt = json['updated_at'];
    chatuser = json['chatuser'];
    group = json['group'] != null ? new Group.fromJson(json['group']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_name'] = this.groupName;
    data['group_image'] = this.groupImage;
    data['type'] = this.type;
    data['last_message'] = this.lastMessage;
    data['total_unread'] = this.totalUnread;
    data['updated_at'] = this.updatedAt;
    data['chatuser'] = this.chatuser;
    if (this.group != null) {
      data['group'] = this.group!.toJson();
    }
    return data;
  }
}

class Group {
  int? id;
  String? roomId;
  String? groupName;
  List<GroupMembers>? groupMembers;
  String? groupImage;
  String? createdBy;
  String? lastMsgTimestamp;
  int? status;
  String? createdAt;
  String? updatedAt;

  Group(
      {this.id,
        this.roomId,
        this.groupName,
        this.groupMembers,
        this.groupImage,
        this.createdBy,
        this.lastMsgTimestamp,
        this.status,
        this.createdAt,
        this.updatedAt});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomId = json['room_id'];
    groupName = json['group_name'];
    if (json['group_members'] != null) {
      groupMembers = <GroupMembers>[];
      json['group_members'].forEach((v) {
        groupMembers!.add(new GroupMembers.fromJson(v));
      });
    }
    groupImage = json['group_image'];
    createdBy = json['created_by'];
    lastMsgTimestamp = json['last_msg_timestamp'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['room_id'] = this.roomId;
    data['group_name'] = this.groupName;
    if (this.groupMembers != null) {
      data['group_members'] =
          this.groupMembers!.map((v) => v.toJson()).toList();
    }
    data['group_image'] = this.groupImage;
    data['created_by'] = this.createdBy;
    data['last_msg_timestamp'] = this.lastMsgTimestamp;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class GroupMembers {
  int? id;
  int? groupId;
  int? userId;
  String? role;
  String? createdAt;
  String? updatedAt;
  UserDetails? userDetails;

  GroupMembers(
      {this.id,
        this.groupId,
        this.userId,
        this.role,
        this.createdAt,
        this.updatedAt,
        this.userDetails});

  GroupMembers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    userId = json['user_id'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_id'] = this.groupId;
    data['user_id'] = this.userId;
    data['role'] = this.role;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.toJson();
    }
    return data;
  }
}

class UserDetails {
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
  int? radius;
  int? isSendNotification;
  String? emailVerifiedAt;
  int? phoneVerifiedAt;
  dynamic deviceToken;
  String? socketId;
  String? createdAt;
  String? updatedAt;
  dynamic deviceType;
  dynamic deviceModel;

  UserDetails(
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
        this.radius,
        this.isSendNotification,
        this.emailVerifiedAt,
        this.phoneVerifiedAt,
        this.deviceToken,
        this.socketId,
        this.createdAt,
        this.updatedAt,
        this.deviceType,
        this.deviceModel});

  UserDetails.fromJson(Map<String, dynamic> json) {
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
    radius = json['radius'];
    isSendNotification = json['is_send_notification'];
    emailVerifiedAt = json['email_verified_at'];
    phoneVerifiedAt = json['phone_verified_at'];
    deviceToken = json['device_token'];
    socketId = json['socket_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deviceType = json['device_type'];
    deviceModel = json['device_model'];
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
    data['radius'] = this.radius;
    data['is_send_notification'] = this.isSendNotification;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone_verified_at'] = this.phoneVerifiedAt;
    data['device_token'] = this.deviceToken;
    data['socket_id'] = this.socketId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['device_type'] = this.deviceType;
    data['device_model'] = this.deviceModel;
    return data;
  }
}
