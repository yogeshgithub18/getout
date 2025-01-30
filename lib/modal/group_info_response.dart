class GroupInfoResponse {
  bool? success;
  GroupData? data;
  String? message;

  GroupInfoResponse({this.success, this.data, this.message});

  GroupInfoResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new GroupData.fromJson(json['data']) : null;
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

class GroupData {
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

  GroupData(
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

  GroupData.fromJson(Map<String, dynamic> json) {
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
  int id;
  int groupId;
  int userId;
  String role;
  DateTime createdAt;
  DateTime updatedAt;
  UserDetails ? userDetails;

  GroupMembers({
    required this.id,
    required this.groupId,
    required this.userId,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.userDetails,
  });

  factory GroupMembers.fromJson(Map<String, dynamic> json) => GroupMembers(
    id: json["id"],
    groupId: json["group_id"],
    userId: json["user_id"],
    role: json["role"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    userDetails:json['user_details']!=null?UserDetails.fromJson(json["user_details"]):null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "group_id": groupId,
    "user_id": userId,
    "role": role,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "user_details": userDetails?.toJson(),
  };
}

class UserDetails {
  int id;
  String? name;
  dynamic lastName;
  String? lattitute;
  String? longitute;
  String? howOld;
  String? email;
  String? mobile;
  dynamic dob;
  String? gender;
  int isOnline;
  String countryCode;
  String otp;
  String token;
  String? profile;
  dynamic bio;
  int roleId;
  dynamic roomId;
  dynamic socialId;
  dynamic loginType;
  int isVerify;
  int status;
  int radius;
  int isSendNotification;
  DateTime emailVerifiedAt;
  int phoneVerifiedAt;
  dynamic deviceToken;
  dynamic socketId;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deviceType;
  dynamic deviceModel;

  UserDetails({
    required this.id,
    this.name,
    this.lastName,
    this.lattitute,
    this.longitute,
    this.howOld,
    this.email,
    this.mobile,
    this.dob,
    this.gender,
    required this.isOnline,
    required this.countryCode,
    required this.otp,
    required this.token,
    this.profile,
    this.bio,
    required this.roleId,
    this.roomId,
    this.socialId,
    this.loginType,
    required this.isVerify,
    required this.status,
    required this.radius,
    required this.isSendNotification,
    required this.emailVerifiedAt,
    required this.phoneVerifiedAt,
    this.deviceToken,
    this.socketId,
    required this.createdAt,
    required this.updatedAt,
    this.deviceType,
    this.deviceModel,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) =>
      UserDetails(
        id: json["id"],
        name: json["name"],
        lastName: json["last_name"],
        lattitute: json["lattitute"],
        longitute: json["longitute"],
        howOld: json["how_old"],
        email: json["email"],
        mobile: json["mobile"],
        dob: json["dob"],
        gender: json["gender"],
        isOnline: json["is_online"],
        countryCode: json["country_code"],
        otp: json["otp"],
        token: json["token"],
        profile: json["profile"],
        bio: json["bio"],
        roleId: json["role_id"],
        roomId: json["room_id"],
        socialId: json["social_id"],
        loginType: json["login_type"],
        isVerify: json["is_verify"],
        status: json["status"],
        radius: json["radius"],
        isSendNotification: json["is_send_notification"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        phoneVerifiedAt: json["phone_verified_at"],
        deviceToken: json["device_token"],
        socketId: json["socket_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deviceType: json["device_type"],
        deviceModel: json["device_model"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "last_name": lastName,
        "lattitute": lattitute,
        "longitute": longitute,
        "how_old": howOld,
        "email": email,
        "mobile": mobile,
        "dob": dob,
        "gender": gender,
        "is_online": isOnline,
        "country_code": countryCode,
        "otp": otp,
        "token": token,
        "profile": profile,
        "bio": bio,
        "role_id": roleId,
        "room_id": roomId,
        "social_id": socialId,
        "login_type": loginType,
        "is_verify": isVerify,
        "status": status,
        "radius": radius,
        "is_send_notification": isSendNotification,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "phone_verified_at": phoneVerifiedAt,
        "device_token": deviceToken,
        "socket_id": socketId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "device_type": deviceType,
        "device_model": deviceModel,
      };
}
