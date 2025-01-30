import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_out/base_utils/base_overlays.dart';
import 'package:get_out/modal/common_response.dart';
import 'package:get_out/modal/theme_card_response.dart';

import '../backend/api_end_points.dart';
import '../backend/base_api.dart';
import '../modal/itienerary_details_response.dart';
import '../modal/subcategory_response.dart';
import '../modal/swipe_card_response.dart';
import '../screens/chat/generate_itinerary.dart';
import '../storage/base_shared_preference.dart';
import 'base_controller.dart';
import 'package:http/http.dart' as http;
class ItineraryController extends GetxController{
  Rx<TextEditingController> eventController =TextEditingController().obs;
  BaseController controller=Get.find<BaseController>();
  RxString catType=''.obs,from='normal'.obs;
  RxString placeId=''.obs;
  RxString lat=''.obs;
  RxString lng=''.obs;
  RxString startTime=''.obs;
  RxString endTime=''.obs;
  RxString selectedTheme=''.obs;
  RxList<String> attachEvents=<String>[].obs;
  RxList<int> attachCategory=<int>[].obs;
  RxList<ThemeList> interestList  =<ThemeList>[].obs;

  RxInt skip=0.obs;
  RxString radius='5000'.obs;
  RxList<Cards> cards=<Cards>[].obs;
  RxList<Cards> themeCard=<Cards>[].obs;
  RxList<String> selectedReview=<String>[].obs;  //pagination
  RxList<Cards> selectedEvents=<Cards>[].obs;  //pagination
  RxBool isLastPage=false.obs;
  RxInt pageNumber=0.obs;
  RxBool error=false.obs;
  RxBool loading=true.obs;
  RxBool isFetchingData=true.obs;
  final RxInt numberOfPostsPerRequest = 10.obs;
  final RxInt nextPageTrigger = 3.obs;

  ////map
  final String apiKey = 'AIzaSyDAV99_3xf9mxeEXdyKppZicwW5pggdVgc';
  Rx<TextEditingController> searchKeywordController=TextEditingController().obs;
  Rx<TextEditingController> searchController=TextEditingController().obs;
  RxList<Map<String, String>> filteredLocations = <Map<String, String>>[].obs;
  RxBool showSuffixIcon=false.obs;

  void moveUp(int index) {
    if (index > 0) {
      final temp = selectedEvents[index];
      selectedEvents[index] = selectedEvents[index - 1];
      selectedEvents[index - 1] = temp;
    }
  }

  void moveDown(int index) {
    if (index < selectedEvents.length - 1) {
      final temp = selectedEvents[index];
      selectedEvents[index] = selectedEvents[index + 1];
      selectedEvents[index + 1] = temp;
    }
  }

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1; // Account for index shift during dragging
    }
    final item = selectedEvents.removeAt(oldIndex);
    selectedEvents.insert(newIndex, item);
  }

  Future<void> getTheme() async{
    await BaseAPI().get(url: ApiEndPoints().themeList).then((response){
      if(response!=null){
        ThemeResponse subCategory=ThemeResponse.fromJson(response.data);
        interestList.value=subCategory.data??[];
      }
    });
  }



  Future<void> getEventsAPI(String type) async {
    try {
      if(type!='load'){
        cards.value=[];
        skip.value=0;
      }
      Map<String,dynamic> params={
        "lat":controller.user.value.lattitute,
        "lng":controller.user.value.longitute,
        "skip":type=='load'?skip.value+10:0,
        "category":catType.value,
        "radius":radius.value,
        "filter_interest":'',
        "filter_key_word":'',
      };
      await BaseAPI().get(url: ApiEndPoints().getEvents,queryParameters: params,showLoader:type!='load').then((response)
      async {
        if (response != null) {
          SwipeCardResponse cardsResponse=SwipeCardResponse.fromJson(response.data);
          if (cardsResponse.data != null) {
            List <Cards> pages= cardsResponse.data?? [];
            isLastPage.value = pages.length < numberOfPostsPerRequest.value;
            loading.value = false;
            pageNumber.value = pageNumber.value + 1;
            cards.addAll(pages);
          }
        }
      });
    } catch (_) {

    }
  }

  Future<void> getThemeEventsAPI() async {
    try {
      Map<String,dynamic> params={
        "theme_id":selectedTheme.value,
      };
      await BaseAPI().get(url: ApiEndPoints().themeEvents,queryParameters: params,showLoader:true).then((response) {
         if (response != null) {
             SwipeCardResponse cardsResponse = SwipeCardResponse.fromJson(response.data);
              themeCard.value= cardsResponse.data??[];
        }
      });
    } catch (e) {
     print("eee---$e");
    }
  }


  Future<void>generateItinerary() async{
    Map<String,dynamic> params = {
      "place_id":placeId.value,
      "event_name" :eventController.value.text,
      "start_time" :startTime.value,
      "end_time" :endTime.value,
      "latitude" :lat.value,
      "longitude" :lng.value,
      "theme" :selectedTheme.value,
      "attach_events" :selectedEvents.map((e)=> e.placeId).toList().join(','),
    };
    debugPrint("params---$params");
    await BaseAPI().post(url: ApiEndPoints().createItinerary,data:params).then((response){
      debugPrint("response---$response");
      if(response!=null){
        CommonResponse commonResponse=CommonResponse.fromJson(response.data);
        if(from.value=='chat'){
          print("from id --->>idd---${commonResponse.data['id'].toString()}");
          BaseSharedPreference().setString("event_id",commonResponse.data['id'].toString());

          Future.delayed(const Duration(milliseconds: 1500),(){
            Get.back();
          });
        }else{
          Get.off(() => GenerateItinerary(from:from.value,id: commonResponse.data['id'].toString()));
          BaseOverlays().showSnackBar(message: "Itinerary created", title: "Success");
        }
      }
    });
  }


  ///// map
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