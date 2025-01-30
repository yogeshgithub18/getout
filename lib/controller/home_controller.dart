import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_out/backend/api_end_points.dart';
import 'package:get_out/backend/base_api.dart';
import 'package:get_out/modal/common_response.dart';
import 'package:get_out/modal/register_response.dart';
import 'package:get_out/modal/swipe_card_response.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:video_player/video_player.dart';

import '../modal/category_response.dart';
import 'package:http/http.dart' as http;

import '../modal/chat_thread_list_model.dart';
import '../modal/group_list_response.dart';
import '../storage/base_shared_preference.dart';
import '../storage/sp_keys.dart';
import 'base_controller.dart';
class HomeController extends GetxController {
 ///map
  final String apiKey = 'AIzaSyDAV99_3xf9mxeEXdyKppZicwW5pggdVgc';
  Rx<TextEditingController> searchKeywordController=TextEditingController().obs;
  Rx<TextEditingController> searchController=TextEditingController().obs;
  RxList<GroupData> groupList = <GroupData>[].obs;
  RxList<Map<String, String>> filteredLocations = <Map<String, String>>[].obs;
  RxBool showSuffixIcon=false.obs;
  RxBool isStatus=false.obs;
  ///card
  RxList<SwipeItem> swipeItems=<SwipeItem>[].obs;
  final matchEngine=MatchEngine().obs;
  RxInt currentIndex=0.obs;
  RxInt skip=0.obs;
  RxString radius='0'.obs;
  RxString rangeSliderValue='5000'.obs;
  RxList<Cards> cards=<Cards>[].obs;
  String lat='';
  String lng='';
  RxBool isLastPage=false.obs;
  RxBool isLoading =false.obs;
  RxList<Interest> interestList  =<Interest>[].obs;
  RxList<int> selectedInterests  =<int>[].obs;
  late Rx<VideoPlayerController>? _controller;

  Future<void> getEvents(String type)async {
    if(type == 'refresh'){
      cards.value=[];
      swipeItems.value=[];
      skip.value=0;
    }else{
      skip.value=cards.length;
    }
    Map<String,dynamic> params={
      "lat":Get.find<BaseController>().user.value.lattitute,
      "lng":Get.find<BaseController>().user.value.longitute,
      "skip":skip.value,
      "radius":radius.value,
      "filter_interest":selectedInterests.join(','),
      "filter_key_word":searchKeywordController.value.text,
    };
    await BaseAPI().get(url: ApiEndPoints().getEvents,queryParameters:params,showLoader: false).then((response){
      if(response!=null) {
        SwipeCardResponse cardsResponse = SwipeCardResponse.fromJson(response.data);
         if ((cardsResponse.data ?? []).isEmpty && !isStatus.value) {
           print("isme jaa rha h kya ---${DateTime.now()}");
               getEvents('refresh');
          }else{
           print("isme bhi jaa rha h kya--${isStatus.value}--date--${DateTime.now()}--${cardsResponse.data}}");
           isLastPage.value = (cardsResponse.data ?? []).length < 10;
           isLoading.value=false;
           cards.value = [];
           swipeItems.value = [];
           cards.value = (cardsResponse.data ?? []);
        }
      }
    });
  }

  Future<void> jobTrigger() async{
    print("start job me aa rha h kya---${DateTime.now()}");
    isStatus.value=false;
    skip.value=0;
    Map<String,dynamic> params={
      // "lat":Get.find<BaseController>().user.value.lattitute,
      // "lng":Get.find<BaseController>().user.value.longitute,
      "filter_interest":selectedInterests.join(','),
      "radius":radius.value,
    };
    await BaseAPI().get(url: ApiEndPoints().jobTrigger,queryParameters:params,showLoader: false).then((response){
      if(response!=null){
        CommonResponse categoryResponse=CommonResponse.fromJson(response.data);
        if(categoryResponse.success??false){
            isStatus.value=true;
            //getEvents("refresh");
           print("job me aa rha h kya---${DateTime.now()}--${cards.length}");
        }
      }
    });
  }

  Future<void>handleEvents(String events,String id) async{
    Map<String,dynamic> params={
      "type":events,
      "place_id" :id
    };
    debugPrint("params---$params");
    await BaseAPI().post(url: ApiEndPoints().handleEvents,data:params).then((response){
      debugPrint("handleEvents responsee---$response");
    });
  }

  Future<void>updateLatlng() async{
    Map<String,dynamic> params={
      "lattitute":lat,
      "longitute" :lng
    };
    debugPrint("params---$params");
    await BaseAPI().post(url: ApiEndPoints().updateLocation,data:params).then((response){
      debugPrint("handleEvents responsee---$response");
      RegisterResponse data=RegisterResponse.fromJson(response?.data);
      Get.find<BaseController>().user.value=data.data!;
      BaseSharedPreference().setJson(SpKeys().user,data.data??{});
      Get.back(result: true);
    });
  }

  Future<void> getCategory() async{
    await BaseAPI().get(url: ApiEndPoints().getCategories,showLoader: false).then((response){
      if(response!=null){
        CategoryResponse categoryResponse=CategoryResponse.fromJson(response.data);
        interestList.value=categoryResponse.data??[];
      }
    });
  }

  Future<void> getGroup() async{
    int? user_Id=Get.find<BaseController>().user.value.id;
    print("userId___$user_Id");
    Map<String,dynamic> params={
      "user_id":user_Id,
      "type" :"group"
    };
    await BaseAPI().post(url: ApiEndPoints().groupList,data:params,showLoader: false).then((response){
      if(response!=null){
        print("gripuop---$response");
        GroupListResponse modal=GroupListResponse.fromJson(response.data);
        groupList.value=modal.data??[];
      }
    });
  }

  // Function to get location suggestions
  Future<void> fetchSuggestions(String query) async {
    if (query.isEmpty) return;
    print("query--$query");
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$apiKey&types=(cities)');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      filteredLocations.value = (data['predictions'] as List).map((e) => {
        'description': e['description'] as String,
        'place_id': e['place_id'] as String,
      }).toList();
     // log("----loc----${filteredLocations}");
    } else {
      print("Failed to fetch suggestions");
    }
  }

  // Function to get latitude and longitude for a selected place
  Future<Map<String, double>?> getPlaceLatLng(String placeId) async {
    final url = Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final location = data['result']['geometry']['location'];
      return {
        'lat': location['lat'],
        'lng': location['lng'],
      };
    } else {
      debugPrint("Failed to fetch location details");
      return null;
    }
  }

}