import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_out/backend/api_end_points.dart';
import 'package:get_out/backend/base_api.dart';
import 'package:get_out/base_utils/base_overlays.dart';
import 'package:get_out/modal/common_response.dart';
import 'package:get_out/modal/register_response.dart';
import '../modal/swipe_card_response.dart';
import '../storage/base_shared_preference.dart';
import '../storage/sp_keys.dart';

class BaseController extends GetxController{
  Rx<UserData> user=UserData().obs;
  Rx<Cards> cardsDetails=Cards().obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("basedatetime---111--${DateTime.now()}");
    setUser();

  }

  setUser()async{
    final bool isLoggedIn = await BaseSharedPreference().getBool(SpKeys().isLoggedIn)??false;
    if (isLoggedIn) {
      Map<String,dynamic> data = await BaseSharedPreference().getJson(SpKeys().user);
      user.value= UserData.fromJson(data);
      print("basedatetime--${DateTime.now()}");
      print("data=--->${user.value.lattitute}");
      print("data=--->${user.value.longitute}");
    }
  }

  Future<void> getDetails(String id)async {
    cardsDetails.value=Cards();
    Map<String,dynamic> params={"place_id":id};
    await BaseAPI().get(url: ApiEndPoints().eventDetails,queryParameters: params,showLoader: false).then((response){
      cardsDetails.value= response?.data['data']!=null?Cards.fromJson(response?.data['data']):Cards();
      if(cardsDetails.value.fileType=='video'){
       ( cardsDetails.value.multipleImages??[]).add(cardsDetails.value.photo!);
      }
      cardsDetails.refresh();
    });
  }

  Future<void>handleEvents(String id,String type) async{
    Map<String,dynamic> params={
      "type":type,
      "place_id" :id
    };
    debugPrint("params---$params");
    await BaseAPI().post(url: ApiEndPoints().handleEvents,data:params).then((response){
      debugPrint("handleEvents responsee---$response");
      CommonResponse commonResponse=CommonResponse.fromJson(response?.data);
      BaseOverlays().showSnackBar(message:commonResponse.message??'',title:"Success");
    });
  }

}