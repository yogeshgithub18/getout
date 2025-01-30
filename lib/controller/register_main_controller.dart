import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_out/base_utils/base_overlays.dart';
import 'package:get_out/modal/category_response.dart';
import 'package:get_out/modal/register_response.dart';
import 'package:location/location.dart';
import 'package:dio/dio.dart' as dio;
import '../backend/api_end_points.dart';
import '../backend/base_api.dart';
import '../screens/home/home_main/bottom_navigation.dart';
import '../storage/base_shared_preference.dart';
import '../storage/sp_keys.dart';
import 'package:http/http.dart' as http;

class RegisterMainController extends GetxController {

  ///map
  final String apiKey = 'AIzaSyDAV99_3xf9mxeEXdyKppZicwW5pggdVgc';
  Rx<TextEditingController> searchLocationController=TextEditingController().obs;
  Rx<TextEditingController> searchController=TextEditingController().obs;
  RxList<Map<String, String>> filteredLocations = <Map<String, String>>[].obs;
  RxBool showSuffixIcon=false.obs;
  String code='';
  RxString gender ='Male'.obs;
  RxString mobileNo =''.obs;
  RxInt age =25.obs;
  RxString lat ='37.77608993377768'.obs;
  RxString lng ='-122.42246700282115'.obs;
  RxList<Interest> interestList  =<Interest>[].obs;
  RxList<int> interests  =<int>[].obs;
  RxList<String> friends  =<String>[].obs;
  Rx<TextEditingController> firstName=TextEditingController().obs;
  Rx<TextEditingController> email=TextEditingController().obs;
  Rx<File>? selectedFile = File("").obs;
  RxList<UserData> friendList=<UserData>[].obs;
  RxList<int> selectedFriend=<int>[].obs;
  // RxList<String> filteredLocations = <String>[].obs;
  Future<void> getCategory() async{
    await BaseAPI().get(url: ApiEndPoints().getCategories).then((response){
     if(response!=null){
       CategoryResponse categoryResponse=CategoryResponse.fromJson(response.data);
       interestList.value=categoryResponse.data??[];
     }
    });
  }

  Future<void> getUsers() async{
    await BaseAPI().get(url: ApiEndPoints().getUsers).then((response){
      print("response---$response");
      if(response!=null){
        friendList.value=(response.data['data'] as List).map<UserData>((e)=> UserData.fromJson(e)).toList();
      }
    });
  }

  Future<void> getLocation() async {
    print("helloooo");
    Location location = Location();
    LocationData? locationData;
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
     BaseOverlays().showLoader();
    locationData = await location.getLocation();
     BaseOverlays().dismissOverlay(showLoader: true);
    lat.value=locationData.latitude.toString();
    lng.value=locationData.longitude.toString();
    print("helloooo---${lat.value}");
  }


  Future<void>register() async{
    dio.FormData params = dio.FormData.fromMap({
      "country_code":code,
      "phone_number" :mobileNo.value,
      "first_name" :firstName.value.text,
      "email" :email.value.text,
      "gender" :gender.value,
      "how_old" :age.value,
      "lattitute" :lat.value,
      "longitute" :lng.value,
      "interest" :interests.join(','),
      "new_friend_list" :selectedFriend.join(','),
      'profile': await dio.MultipartFile.fromFile(selectedFile!.value.path, filename:selectedFile?.value.path.split("/").last??"")
    });
    debugPrint("params---$params");
    await BaseAPI().post(url: ApiEndPoints().register,data:params).then((response){
      debugPrint("responsee---$response");
       if(response!=null){
         RegisterResponse userResponse=RegisterResponse.fromJson(response.data);
         BaseSharedPreference().setBool(SpKeys().isLoggedIn, true);
         BaseSharedPreference().setString(SpKeys().apiToken, userResponse.data?.token ?? "");
         BaseSharedPreference().setInt(SpKeys().userId, userResponse.data?.id ?? "");
         BaseSharedPreference().setJson(SpKeys().user,userResponse.data??{});
         Get.offAll( ()=> const BottomNavigation());
       }
    });
  }

  // Function to get location suggestions
  Future<void> fetchSuggestions(String query) async {
    if (query.isEmpty) return;
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=$apiKey&types=(cities)');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      filteredLocations.value = (data['predictions'] as List)
          .map((e) => {
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