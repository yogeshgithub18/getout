import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_out/backend/api_end_points.dart';
import 'package:get_out/base_utils/base_overlays.dart';
import 'package:get_out/modal/otp_response.dart';

import '../backend/base_api.dart';
import '../modal/register_response.dart';
import '../screens/login/confirm.dart';
import '../screens/login/login.dart';
import '../screens/login/verify_otp.dart';
import '../storage/base_shared_preference.dart';
import '../storage/sp_keys.dart';
import 'package:dio/dio.dart' as dio;
class LoginController extends GetxController{
 Rx<TextEditingController> mobileController = TextEditingController().obs;
 Rx<TextEditingController> otpController = TextEditingController().obs;
 RxString countryCode="+1".obs;

 Future<void>loginCheck() async{
  Map<String,dynamic> params={
   "country_code":countryCode.value,
   "phone_number" :mobileController.value.text
  };
  debugPrint("params---$params");
  await BaseAPI().post(url: ApiEndPoints().loginCheck,data:params).then((response){
     debugPrint("responsee---$response");
     Get.to(()=>const VerifyOtp());
     //Get.to(()=>const Login());
  });
 }

 Future<void>otpVerify() async{
  Map<String,dynamic> params={
   "mobile" :mobileController.value.text,
   "deviceType" :"android",
   "deviceId" :"GVHJBJF454545BHJGJGBJ",
   "otp" :otpController.value.text,
   "country_code" :countryCode.value,
  };
  debugPrint("params---$params");
  await BaseAPI().post(url: ApiEndPoints().otpVerify,data:params).then((response){
   if(response!=null) {
    OtpResponse otpResponse = OtpResponse.fromJson(response.data);
    debugPrint("responsee---$response");
    if (otpResponse.success ?? false) {
     BaseSharedPreference().setBool(
         SpKeys().isLoggedIn, otpResponse.data?.userData?.isVerify != 0);
     BaseSharedPreference().setInt(
         SpKeys().userId, otpResponse.data?.userData?.id ?? "");
     BaseSharedPreference().setString(
         SpKeys().apiToken, otpResponse.data?.userData?.token ?? "");
     BaseSharedPreference().setJson(
         SpKeys().user, otpResponse.data?.userData ?? {});
     Get.to(() =>
         Confirm(isNew: otpResponse.data?.userData?.isVerify == 0,
          mobile: otpResponse.data!.userData!.mobile!,
          code: countryCode.value,));
     }else{
     BaseOverlays().showSnackBar(message:otpResponse.message??'Invalid OTP');
    }
   }
  });
 }

 Future<void>resendCode() async{
  Map<String,dynamic> params={
   "country_code":countryCode.value,
   "phone_number" :mobileController.value.text
  };
  debugPrint("params---$params");
  await BaseAPI().post(url: ApiEndPoints().resendOtp,data:params).then((response){
     debugPrint("responsee---$response");
  });
 }

 Future<void>socialLogin() async{
  dio.FormData params = dio.FormData.fromMap({
   "socialId":"code",
   "socialType" :"code",
   "name" :"code",
   "email" :"code",
   "deviceToken" :"code",
   "deviceModel" :"code",
   "deviceType" :"code",
   //'profile': await dio.MultipartFile.fromFile(selectedFile!.value.path, filename:selectedFile?.value.path.split("/").last??"")
  });
  debugPrint("params---$params");
  await BaseAPI().post(url: ApiEndPoints().socialLogin,data:params).then((response){
   debugPrint("responsee---$response");
   if(response!=null){

   }
  });
 }

}