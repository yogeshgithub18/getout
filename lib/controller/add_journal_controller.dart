import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_out/base_utils/base_overlays.dart';
import 'package:get_out/controller/base_controller.dart';
import 'package:get_out/modal/common_response.dart';

import '../backend/api_end_points.dart';
import '../backend/base_api.dart';
import '../modal/group_list_response.dart';
import '../modal/my_friend_response.dart';
import '../modal/swipe_card_response.dart';
import '../screens/home/camera/share.dart';
import '../screens/home/home_main/bottom_navigation.dart';

class AddJournalController extends GetxController{
  Rx<File>? selectedFile = File("").obs;
  BaseController controller=Get.find<BaseController>();
  RxInt skip=0.obs;
  RxString radius='5000'.obs;
  RxList<Cards> cards=<Cards>[].obs;
  RxString selectedReview=''.obs;
  Rx<TextEditingController> searchController=TextEditingController().obs;
  Rx<TextEditingController> captionController=TextEditingController().obs;
  RxList<FriendData> friendList=<FriendData>[].obs;
  RxList<GroupData> groupList = <GroupData>[].obs;
  //pagination
  RxBool isLastPage=false.obs;
  RxInt pageNumber=0.obs;
  RxBool error=false.obs;
  RxBool loading=true.obs;
  RxBool isFetchingData=true.obs;
  final RxInt numberOfPostsPerRequest = 10.obs;
  final RxInt nextPageTrigger = 3.obs;
  RxString chatType=''.obs;
  RxInt selectedId=0.obs;
  Rx<User> selectedUser=User().obs;

  Future<void> getFriend() async{
    await BaseAPI().post(url: ApiEndPoints().getFriends,showLoader: false).then((response){
      print("response---$response");
      if(response!=null){
        MyFriendResponse data=MyFriendResponse.fromJson(response.data);
        friendList.value=data.data??[];
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

  Future<void>addJournal({required String type}) async{
    dio.FormData params = dio.FormData.fromMap({
      'caption':captionController.value.text.trim(),
      'photo': await dio.MultipartFile.fromFile(selectedFile!.value.path, filename:selectedFile?.value.path.split("/").last??"")
    });
    if(type=='review'){
      params.fields.add(const MapEntry('type', 'product_review'));
      params.fields.add( MapEntry('place_ids',selectedReview.value));
    }
    debugPrint("params---$params");
    await BaseAPI().post(url: ApiEndPoints().addToGallery,data:params).then((response){
      debugPrint("response---$response");
      if(response!=null){
        Get.offAll( ()=> const BottomNavigation());
        BaseOverlays().showSnackBar(message: "Added to gallery",title: "Success");
      }
    });
  }

  Future<void> getHomeDataAPI(String type) async {
    try {
      if(type!='load'){
        cards.value=[];
        skip.value=0;
      }
      Map<String,dynamic> params={
        "lat":controller.user.value.lattitute,
        "lng":controller.user.value.longitute,
        "skip":type=='load'?skip.value+10:0,
        "radius":radius.value,
        "filter_interest":'',
        "filter_key_word":searchController.value.text,
      };
      await BaseAPI().get(url: ApiEndPoints().getEvents,queryParameters: params).then((response)
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

  Future<String>fileUpload() async{
    String image='';
    dio.FormData params = dio.FormData.fromMap({
      'attachment': await dio.MultipartFile.fromFile(selectedFile!.value.path, filename:selectedFile?.value.path.split("/").last??"")
    });
    debugPrint("params---$params");
    await BaseAPI().post(url: ApiEndPoints().fileUpload,data:params).then((response){
      debugPrint("response---$response");
      if(response!=null){
        CommonResponse data=CommonResponse.fromJson(response.data);
        image=data.data['image'];
      }
    });
    return image;
  }

    Future<void> getCards() async{
    cards.value=[];
    Map<String,dynamic> params={
      "type":"all",
      "filter_category":''
    };
    await BaseAPI().get(url:ApiEndPoints().favStarList,queryParameters: params).then((response){
      if(response!=null){
        SwipeCardResponse cardsResponse=SwipeCardResponse.fromJson(response.data);
        cards.value=cardsResponse.data??[];
      }
    });
  }
}