import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_out/modal/group_info_response.dart';
import 'package:get_out/storage/base_shared_preference.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:get_out/backend/api_end_points.dart';
import 'package:get_out/backend/base_api.dart';
import '../modal/action_modal_response.dart';
import '../modal/chat_list_model.dart';
import '../modal/chat_thread_list_model.dart';
import '../modal/common_response.dart';
import '../modal/my_friend_response.dart';
import '../modal/swipe_card_response.dart';
import 'base_controller.dart';
class ChatController extends GetxController{
  RxList<FriendData> friendList=<FriendData>[].obs;
  Rx<GroupData> groupInfo=GroupData().obs;
  Rx<TextEditingController> groupNameController = TextEditingController().obs;
  RxBool isChattingLoad=false.obs;
  RxList<FriendData> selectedGroup=<FriendData>[].obs;
  Rx<File>? selectedImage = File("").obs;
  String ImageUrl='';
  io.Socket? socket;
  RxList<Cards> selectedEvents=<Cards>[].obs;
  BaseController controller=Get.find<BaseController>();
  ///
   Rx<TextEditingController> messageController = TextEditingController().obs;
  RxBool chatListLoading = true.obs,groupChatListLoading=true.obs, firstTime = true.obs;
  RxString roomId = ''.obs, receiveId = ''.obs,placeId=''.obs,eventId=''.obs;
  RxInt pageNo = 1.obs;
  Rx<ChatThreadListModel> chatThreadListData = ChatThreadListModel().obs;
  Rx<ChatThreadListModel> groupChatThreadListData = ChatThreadListModel().obs;
  Rx<ChatModel> chatModel = ChatModel().obs;
  RxList<ChatListingModel> chatList = <ChatListingModel>[].obs;
  late ScrollController scrollController;
  RxBool isChatHide=true.obs;
  RxBool isGroupLoad=false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    onInitCalling();
  }

  @override
  void dispose() {
    super.dispose();
    if (socket != null && socket!.connected) {
      socket!.disconnect();
      print("socket disconnected dispose method band ho gya");
    }
  }

  onInitCalling() {
    Future.delayed(Duration.zero, () {
      connectSocket();
    });
  }
  connectSocket() async {
    if (socket != null && socket!.connected) {
      print('socket catch --  > band ho gya');
      print("socket band ho gya");
      socket!.disconnect();
    }
    socket = io.io("https://novelgamechangeritsolutions.com:3000/",
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        "force new connection": true,
        "reconnectionAttempt": "Infinity",
         "timeout": 10000,
      },
    );
    chatListLoading.value=true;
    socket?.connect();
    socket!.onConnect((_) {
      print("socket connect");
      onConnect();
    });
    socket!.onDisconnect((_) {
      chatListLoading.value = false;
      print("socket Disconnect--band ho gya");
      print('socket catch --  > ');
      //connectSocket();
    });
    socket!.onConnectError((err) {
      chatListLoading.value = false;
      // update();
      print("onConnectError--band ho gya");
      print(err.toString());
      print(err);
      print('socket catch --  >');
     // connectSocket();
    });
    socket!.onError((err) {
      print("onError--band ho gya");
      chatListLoading.value = false;
      print(err);
     // connectSocket();
    });
  }

  void onConnect() async {
    try {
      int userId=controller.user.value.id!;
      print("user--$userId");
      socket!.emit("CONNECT", {"senderId":userId});
      socket!.on("CONNECT_RESPONSE", (data) {
        print("CONNECT_RESPONSE");
        print("on ---> \n");
        print(data.toString());
        joinRoom();
      });
    } catch (e) {
      print('On Connect Catch ---  >${e.toString()}');
    }
  }

  joinRoom() async {
    print("Join Room");
    try {
      int userId=controller.user.value.id!;
      socket!.emit("THREADS_LIST", {"senderId":userId,"search":'','type':''});
      socket!.on("THREADS_LIST_RESPONSE", (data) {
        print("THREADS_LIST_RESPONSE Join for single");
        print("on ---> \n");
        printFullData(data.toString());
        Map<String,dynamic> decodedData = jsonDecode(data);
        ChatThreadListModel modal=ChatThreadListModel.fromJson(decodedData);
         chatListLoading.value = false;
        if(modal.data?.data?[0].type=="SINGLE") {
          chatThreadListData.value = modal;
        }else{
          groupChatListLoading.value=false;
          print("group ka chat");
        }
      });
    } catch (e) {
      print('On Connect Catch ---  >${e.toString()}');
    }
  }

  getUseChatDetailsSocket({bool maxScroller = false,required String type}) async {
    try {
      if (socket != null && socket!.connected) {
        int userId=controller.user.value.id!;
        socket!.emit("CHAT_LIST",{
          'senderId': userId,
          'roomId': roomId.value,
          'page': pageNo.value,
          'type':type
        });

        socket!.on("CHAT_LIST_RESPONSE", (data) {
          print('Init Calling 2');
          var decodedData = jsonDecode(data);
          printFullData('CHAT_LIST_RESPONSE----$decodedData');
          chatModel.value = ChatModel.fromJson(decodedData);
          if (firstTime.value) {
            chatList.clear();
            chatList.addAll((chatModel.value.data?.data?.data ?? []).reversed.toList());
            if (maxScroller && !scrollController.hasClients) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                scrollController.jumpTo(scrollController.position.maxScrollExtent);
              });
            }
          } else {
            chatList.addAll((chatModel.value.data?.data?.data ?? []).reversed.toList());
            firstTime.value = true;
          }
        });

        socket!.on("SEND_MESSAGE_RESPONSE", (data) {
          firstTime.value = true;
          print('SEND_MESSAGE_RESPONSE Listener -- > $data');
          moreChatDetailsSocket(pageNo: 1, maxScroller: true);
          readAllChat();
        });

        socket!.on("READ_MESSAGE_RESPONSE", (data) {});
      } else {
        print("its re calling");
       // connectSocket();
      }
    } catch (e) {
      print('CHAT_LIST_RESPONSE ---> ${e.toString()}');
    }
  }

  offEmitResponse(emitName) {
    chatList.clear();
    pageNo.value = 1;
    socket!.off(emitName);
    socket!.off('SEND_MESSAGE_RESPONSE');
    socket!.off('CHAT_LIST_RESPONSE');
  }

  readAllChat() async {
    int userId=controller.user.value.id!;
    socket!.emit("READ_MESSAGE", {
      'senderId': userId,
      'roomId': roomId.value,
      'messageId': pageNo.value,
      'type': 'all'
    });
  }

  getGroupAllChat() async {
    try {
      int userId=controller.user.value.id!;
      print("called for group");
      socket!.emit("THREADS_LIST", {"senderId":userId,"search":'','type':'group'});
      socket!.on("THREADS_LIST_RESPONSE", (data) {
        print("THREADS_LIST_RESPONSE Join for group");
        log(data.toString());
        var decodedData = jsonDecode(data);
        ChatThreadListModel modal=ChatThreadListModel.fromJson(decodedData);
         chatListLoading.value = false;
         groupChatListLoading.value = false;
        if(modal.data?.data?[0].type!="SINGLE") {
          groupChatThreadListData.value = ChatThreadListModel.fromJson(decodedData);
          groupChatListLoading.value = false;
        }
      });
    } catch (e) {
      print('On Connect Catch ---  >${e.toString()}');
    }
  }

  void sendMassageSocket({String messageType  = 'TEXT', messageFile = '',senderType}) async {
    int userId=controller.user.value.id!;
    print("messageFile---$messageFile--");
    socket!.emit("SEND_MESSAGE", {
      'senderId': userId,
      'receiveId': receiveId.value,
      'roomId': roomId.value,
      'message': messageController.value.text.trim(),
      'messageType': messageType,
      'messageFile': messageFile,
      'tipId': '0',
      'senderType':senderType,
      'event_id':messageType=="event"?eventId.value:'',
      'library_id':messageType=="place"?placeId.isNotEmpty?placeId.value:selectedEvents.map((e)=> e.placeId).toList().join('~'):''
    });
    messageController.value.clear();
    selectedEvents.clear();
    placeId.value='';
    eventId.value='';
    BaseSharedPreference().setString('event_id','');
    firstTime.value = true;
  }

  moreChatDetailsSocket({int? pageNo, bool maxScroller = false}) async {
    int userId=controller.user.value.id!;
    socket!.emit("CHAT_LIST", {
      'senderId': userId,
      'roomId': roomId.value,
      'page': pageNo
    });
    if (maxScroller && scrollController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 800), () {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        });
      });
    }
  }

  Future<void> getFriend() async{
    await BaseAPI().post(url: ApiEndPoints().getFriends,showLoader: false).then((response){
      print("response---$response");
      if(response!=null){
        MyFriendResponse data=MyFriendResponse.fromJson(response.data);
        friendList.value=data.data??[];
      }
    });
  }

  Future<void> getGroupInfo(int id) async{
    Map<String,dynamic> param={
      "group_id":id
    };
    isGroupLoad.value=true;
    await BaseAPI().post(url: ApiEndPoints().groupInfo,showLoader:true,data: param).then((response){
      print("response---$response");
      isGroupLoad.value=false;
      if(response!=null){
        GroupInfoResponse group=GroupInfoResponse.fromJson(response.data);
        groupInfo.value=group.data??GroupData();
      }
    });
  }

  Future<void> groupLeft(int id) async{
    Map<String,dynamic> param={
      "group_id":id
    };
    await BaseAPI().post(url: ApiEndPoints().leftGroup,showLoader:true,data: param).then((response){
      print("response---$response");
      if(response!=null){
        getGroupInfo(id);
      }
    });
  }

  Future<void>createChatGroup() async{
    dio.FormData params = dio.FormData.fromMap({
      "group_name":groupNameController.value.text.trim(),
      "userIds" :selectedGroup.map((e)=>e.friendDetails!.id).toList().join(','),
    });
    if ((selectedImage?.value.path??"").isNotEmpty) {
      params.files.add (MapEntry("image" ,await dio.MultipartFile.fromFile(selectedImage!.value.path??"", filename: selectedImage?.value.path.split("/").last??"")));
    }
    debugPrint("params---$params");
    await BaseAPI().post(url: ApiEndPoints().createGroup,data:params).then((response){
      debugPrint("responsee---$response");
      if(response!=null){

      }
    });
  }

  void printFullData(String data) {
    const int chunkSize = 800; // Choose a size smaller than the limit to avoid truncation.
    for (int i = 0; i < data.length; i += chunkSize) {
      print(data.substring(i, i + chunkSize > data.length ? data.length : i + chunkSize));
    }
  }

  Future<void>likeDislike(int id,String action,int index) async{
    Map<String,dynamic> params = {
      "chat_id":id,
      "action" :action,
    };
    debugPrint("params---$params");
    await BaseAPI().post(url: ApiEndPoints().likeDislikeChat,data:params).then((response){
      debugPrint("response---$response");
      if(response!=null){
        ActionCount responseCount=ActionCount.fromJson(response.data);
        chatList[index].like_count=int.parse(responseCount.data?.likeCount??"0");
        chatList[index].dislike_count=int.parse(responseCount.data?.dislikeCount??"0");
        chatList[index].emoji_count=int.parse(responseCount.data?.emojiCount??"0");
        chatList.refresh();

      }
    });
  }

}