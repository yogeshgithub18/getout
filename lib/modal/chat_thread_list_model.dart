class ChatThreadListModel {
  bool? status;
  String? message;
  ChatThreadData? data;

  ChatThreadListModel({this.status, this.message, this.data});

  ChatThreadListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ChatThreadData.fromJson(json['data']) : null;
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

class ChatThreadData {
  bool? success;
  List<ChatThreadListData>? data;
  String? message;

  ChatThreadData({this.success, this.data, this.message});

  ChatThreadData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ChatThreadListData>[];
      json['data'].forEach((v) {
        data!.add(ChatThreadListData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class ChatThreadListData {
  int? id;
  String? groupName;
  String? groupImage;
  String? type;
  String? lastMessage;
  int? totalUnread;
  String? updatedAt;
  List<Chatuser>? chatuser;
  Group ? group;
  // Null? bookingId;

  ChatThreadListData(
      {this.id,
        this.groupName,
        this.groupImage,
        this.type,
        this.lastMessage,
        this.totalUnread,
        this.updatedAt,
        this.chatuser,
        this.group
        // this.bookingId
      });

  ChatThreadListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupName = json['group_name'];
    groupImage = json['group_image'];
    type = json['type'];
    lastMessage = json['last_message'];
    totalUnread = json['total_unread'];
    updatedAt = json['updated_at'];
    if (json['chatuser'] != null) {
      chatuser = <Chatuser>[];
      json['chatuser'].forEach((v) {
        chatuser!.add(Chatuser.fromJson(v));
      });
    }
    group = json['group'] != null ? Group.fromJson(json['group']) : null;
    // bookingId = json['booking_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['group_name'] = groupName;
    data['group_image'] = groupImage;
    data['type'] = type;
    data['last_message'] = lastMessage;
    data['total_unread'] = totalUnread;
    data['updated_at'] = updatedAt;
    if (chatuser != null) {
      data['chatuser'] = chatuser!.map((v) => v.toJson()).toList();
    }
    if (this.group != null) {
      data['group'] = this.group!.toJson();
    }
    // data['booking_id'] = bookingId;
    return data;
  }
}

class Chatuser {
  int? id;
  int? convenienceId;
  int? userId;
  GetUser? getUser;

  Chatuser({this.id, this.convenienceId, this.userId, this.getUser});

  Chatuser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    convenienceId = json['convenience_id'];
    userId = json['user_id'];
    getUser = json['get_user'] != null
        ? GetUser.fromJson(json['get_user'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['convenience_id'] = convenienceId;
    data['user_id'] = userId;
    if (getUser != null) {
      data['get_user'] = getUser!.toJson();
    }
    return data;
  }
}

class GetUser {
  int? id;
  String? email;
  String? fullName;
  String? userName;
  String? name;
  // Null? mobileNo;
  // Null? countryCode;
  int? isOnline;
  String? profileImage;

  GetUser(
      {this.id,
        this.email,
        this.fullName,
        this.userName,
        this.name,
        // this.mobileNo,
        // this.countryCode,
        this.isOnline,
        this.profileImage});

  GetUser.fromJson(Map<String, dynamic> json) {
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

class Group {
  int id;
  String roomId;
  String groupName;
  List<GroupMember> groupMembers;
  dynamic groupImage;
  String createdBy;
  String lastMsgTimestamp;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  Group({
    required this.id,
    required this.roomId,
    required this.groupName,
    required this.groupMembers,
    this.groupImage,
    required this.createdBy,
    required this.lastMsgTimestamp,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    id: json["id"],
    roomId: json["room_id"],
    groupName: json["group_name"],
    groupMembers: List<GroupMember>.from(json["group_members"].map((x) => GroupMember.fromJson(x))),
    groupImage: json["group_image"],
    createdBy: json["created_by"],
    lastMsgTimestamp: json["last_msg_timestamp"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "room_id": roomId,
    "group_name": groupName,
    "group_members": List<dynamic>.from(groupMembers.map((x) => x.toJson())),
    "group_image": groupImage,
    "created_by": createdBy,
    "last_msg_timestamp": lastMsgTimestamp,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };

  @override
  String toString() {
    // TODO: implement toString
    return "group---$id";
  }
}

class GroupMember {
  int id;
  int groupId;
  int userId;
  String role;
  DateTime createdAt;
  DateTime updatedAt;
  UserDetails ? userDetails;

  GroupMember({
    required this.id,
    required this.groupId,
    required this.userId,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.userDetails,
  });

  factory GroupMember.fromJson(Map<String, dynamic> json) => GroupMember(
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