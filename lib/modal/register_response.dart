class RegisterResponse {
  bool? success;
  UserData? data;
  String? message;

  RegisterResponse({this.success, this.data, this.message});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
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



class UserData {
  int? id;
  String ? name;
  dynamic lastName;
  dynamic lattitute;
  dynamic longitute;
  dynamic howOld;
  String ? email;
  String? mobile;
  dynamic dob;
  dynamic gender;
  int? isOnline;
  String? countryCode;
  String? otp;
  String? token;
  dynamic profile;
  dynamic bio;
  int? roleId;
  dynamic roomId;
  dynamic socialId;
  dynamic loginType;
  int? isVerify;
  int? status;
  int? is_friend;
  int? isSendNotification;
  String? emailVerifiedAt;
  int? phoneVerifiedAt;
  dynamic deviceToken;
  dynamic socketId;
  String? createdAt;
  String? updatedAt;

  UserData(
      {this.id,
        this.name,
        this.lastName,
        this.lattitute,
        this.longitute,
        this.howOld,
        this.email,
        this.mobile,
        this.dob,
        this.is_friend,
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

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['last_name'];
    lattitute = json['lattitute'];
    longitute = json['longitute'];
    howOld = json['how_old'];
    email = json['email'];
    is_friend = json['is_friend'];
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
