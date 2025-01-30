import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_out/backend/api_end_points.dart';
import 'package:get_out/backend/base_api.dart';
import 'package:get_out/base_utils/base_overlays.dart';
import 'package:get_out/modal/gallery_response.dart';
import 'package:get_out/modal/register_response.dart';
import 'package:get_out/screens/login/login.dart';
import 'package:dio/dio.dart' as dio;
import '../modal/contact_response.dart';
import '../modal/faq_response.dart';
import '../modal/itinerary_list_response.dart';
import '../modal/my_friend_response.dart';
import '../screens/login/signup.dart';
import '../storage/base_shared_preference.dart';
import 'package:contacts_service/contacts_service.dart';

class ProfileController extends GetxController {
  Rx<TextEditingController> firstName= TextEditingController().obs;
  Rx<TextEditingController> query= TextEditingController().obs;
  Rx<TextEditingController> email= TextEditingController().obs;
  Rx<TextEditingController> uEmail= TextEditingController().obs;
  Rx<TextEditingController> uMobile= TextEditingController().obs;
  Rx<TextEditingController> uAge= TextEditingController().obs;
  Rx<TextEditingController> uGender= TextEditingController().obs;
  RxInt howOld=18.obs;
  RxString gender="Male".obs;
  RxString profile="".obs;
  RxList<Data> faqList=<Data>[].obs;
  RxList<Images> imagesList=<Images>[].obs;
  RxList<ItinenaryData> itineararyList=<ItinenaryData>[].obs;
  Rx<UserData> user=UserData().obs;
  RxList<FriendData> friendList=<FriendData>[].obs;
  RxList<UserData> friendListFlag=<UserData>[].obs;
  RxList<SyncData> contacts = <SyncData>[].obs;
  RxList<int> selectedFriend=<int>[].obs;
  RxBool isEdit=false.obs;
  RxBool isContactLoading=false.obs;
  Rx<File> selectedFile=File("").obs;
  RxList<FriendData> filteredItems = <FriendData>[].obs;

  void filterList(String query) {
    if (query.isEmpty) {
      // Show all items if the query is empty
      filteredItems.value = friendList;
    } else {
      // Filter items based on the search query
      filteredItems.value = friendList
          .where((item) =>
          (item.friendDetails?.name??'').toLowerCase().contains(query.toLowerCase().trim()))
          .toList();
    }
  }

  Future<void> getProfile() async{
    await BaseAPI().post(url: ApiEndPoints().getProfile).then((response){
      if(response!=null){
        RegisterResponse userData=RegisterResponse.fromJson(response.data);
        user.value=userData.data??UserData();
      }
    });
  }

  Future<void> getGallery() async{
    await BaseAPI().get(url: ApiEndPoints().viewGallery,showLoader: false).then((response){
      if(response!=null){
       GalleryResponse galleryResponse=GalleryResponse.fromJson(response.data);
       imagesList.value=galleryResponse.data??[];
      }
    });
  }

  Future<void> getItieneraryList() async{
    await BaseAPI().get(url: ApiEndPoints().itineraryList,showLoader: false).then((response){
      if(response!=null){
        ItieneraryListResponse itieneraryListResponse=ItieneraryListResponse.fromJson(response.data);
        itineararyList.value=itieneraryListResponse.data??[];
      }
    });
  }


  Future<void>syncContacts(List<Map> contact) async{
   dio.FormData params = dio.FormData.fromMap({
      "data": jsonEncode(contact)
    });
    debugPrint("params---$params");
   isContactLoading.value=true;
    await BaseAPI().post(url: ApiEndPoints().checkAvailability,data:params).then((response){
      debugPrint("responsee---$response");
      isContactLoading.value=false;
      SyncContactResponse syncResponse=SyncContactResponse.fromJson(response?.data);
      contacts.value=syncResponse.data??[];
    });
  }

  Future<void>addFriend(int userId,int index) async{
    Map<String,dynamic> params = {
      "new_friend_list":'$userId',
    };
    debugPrint("params---$params");
    await BaseAPI().post(url: ApiEndPoints().addFriend,data:params).then((response){
      debugPrint("responsee---$response");
       contacts[index].alreadyFriend=true;
       contacts.refresh();
      BaseOverlays().showSnackBar(message: "Added Successfully",title: "Success");
    });
  }

  Future<void> getFriend() async{
    await BaseAPI().post(url: ApiEndPoints().getFriends).then((response){
      print("response---$response");
      if(response!=null){
        MyFriendResponse data=MyFriendResponse.fromJson(response.data);
        friendList.value=data.data??[];
      }
    });
  }

  Future<void> getUsers() async{
    await BaseAPI().post(url: ApiEndPoints().getUserFriends).then((response){
      print("response---$response");
      if(response!=null){
        friendListFlag.value=(response.data['data'] as List).map<UserData>((e)=> UserData.fromJson(e)).toList();
      }
    });
  }

  Future<void> getFaq() async{
    await BaseAPI().get(url: ApiEndPoints().faqs).then((response){
      if(response!=null){
        FaqResponse faqs=FaqResponse.fromJson(response.data);
        faqList.value=faqs.data??[];
      }
    });
  }



  Future<void> logout() async{
    await BaseAPI().post(url: ApiEndPoints().logout).then((response){
      BaseOverlays().showSnackBar(message: "LogOut Successfully".tr, title: "Success");
      Get.offAll(()=>const Signup());
      BaseSharedPreference().clearLoginSession();
    });
  }

  Future<void> deleteAccount() async{
    await BaseAPI().post(url: ApiEndPoints().deleteAccount).then((response){
      BaseOverlays().showSnackBar(message: "Account deleted Successfully".tr, title: "Success");
      Get.offAll(()=>const Signup());
      BaseSharedPreference().clearLoginSession();
    });
  }


  Future<void>editProfile() async{
    dio.FormData params = dio.FormData.fromMap({
      "first_name":user.value.name,
      "email":uEmail.value.text,
      "gender" :uGender.value.text,
      "how_old" :uAge.value.text,
    });

    if ((selectedFile.value.path??"").isNotEmpty) {
      params.files.add (MapEntry("profile" ,await dio.MultipartFile.fromFile(selectedFile.value.path??"", filename: selectedFile?.value.path.split("/").last??"")));
    }
    debugPrint("params---$params");
    await BaseAPI().post(url: ApiEndPoints().editProfile,data:params).then((response){
      debugPrint("responsee---$response");
      Get.back();
      BaseOverlays().showSnackBar(message: "Submit Successfully", title: "Success");
    });
  }

  Future<void>submitQuery() async{
    Map<String,dynamic> params={
      "email":email.value.text,
      "name" :firstName.value.text,
      "last_name" :firstName.value.text,
      "phone" :user.value.mobile,
    };
    debugPrint("params---$params");
    await BaseAPI().post(url: ApiEndPoints().contactUs,data:params).then((response){
      email.value.text='';
      firstName.value.text='';
      query.value.text='';
      BaseOverlays().showSnackBar(message: "Submit Successfully",title: "Success");
    });
  }
}