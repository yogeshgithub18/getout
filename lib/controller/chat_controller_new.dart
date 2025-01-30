// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';
//
// import 'package:defalcor/modules/profile/controller/profile_controller.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../../../common/get_it/page_manager.dart';
// import '../../../common/get_it/service_locator.dart';
// import '../../../resource/api_manager/apiLoader.dart';
// import '../../../resource/api_manager/api_manager.dart';
// import '../../../resource/api_manager/api_model.dart';
// import '../../../resource/api_manager/apis.dart';
// import '../../../utils/local_storage.dart';
// import 'package:socket_io_client/socket_io_client.dart' as io;
//
// import '../model/chat_list_model.dart';
// import '../model/chat_thread_list_model.dart';
// import 'package:path_provider/path_provider.dart';
//
// class ChatController extends GetxController {
//   final APIManager _apiManager = APIManager.apiManagerInstance;
//   final APIS _apis = APIS.apisSharedInstance;
//   final LocalStorage localStorage = LocalStorage.localStorageSharedInstance;
//   final TextEditingController messageController = TextEditingController();
//
//   // late ScrollController scrollController;
//
//   RxBool chatListLoading = true.obs, firstTime = true.obs;
//   RxString roomId = ''.obs, receiveId = ''.obs;
//   RxInt pageNo = 1.obs;
//   final pageManager = getIt<PageManager>();
//
//   // ChatListUserData theadListDate = ChatListUserData();
//   // ChatThreadListModel threadListDate = ChatThreadListModel();
//   Rx<ChatThreadListModel> chatThreadListData = ChatThreadListModel().obs;
//   Rx<ChatModel> chatModel = ChatModel().obs;
//   RxList<ChatListingModel> chatList = <ChatListingModel>[].obs;
//
//   late ScrollController scrollController;
//
//   // Web Socket
//   io.Socket? socket;
//
//   late ProfileController profileController;
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     if (ProfileController().initialized) {
//       profileController = Get.find();
//     } else {
//       profileController = Get.put(ProfileController());
//     }
//     onInitCalling();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     if (socket != null && socket!.connected) {
//       socket!.disconnected;
//       log("socket disconnected dispose method");
//     }
//   }
//
//   onInitCalling() {
//     Future.delayed(Duration.zero, () {
//       initSocket();
//     });
//   }
//
//   void initSocket() {
//     if (ProfileController().initialized) {
//       profileController = Get.find();
//     } else {
//       profileController = Get.put(ProfileController());
//     }
//     log("calling socket");
//     update();
//     if (socket != null && socket!.connected) {
//       print('socket catch --  >');
//       log("socket");
//       socket!.disconnected;
//     }
//     socket = io.io(APIS.socketUrl, <String, dynamic>{
//       'autoConnect': false,
//       'transports': ['websocket'],
//       // 'Authorization': 'Bearer ' + token!.toString()
//     });
//     try {
//       socket!.connect();
//       print('socket catch --  > ${socket?.connected}');
//     } catch (e) {
//       print('socket catch --  >');
//     }
//     socket!.onConnect((_) {
//       log("socket connect");
//       onConnect();
//     });
//     socket!.onDisconnect((_) {
//       chatListLoading.value = false;
//       // update();
//       log("socket Disconnect");
//       print('socket catch --  >');
//       initSocket();
//     });
//     socket!.onConnectError((err) {
//       chatListLoading.value = false;
//       // update();
//       log("onConnectError");
//       log(err.toString());
//       print(err);
//       print('socket catch --  >');
//       initSocket();
//     });
//     socket!.onError((err) {
//       chatListLoading.value = false;
//       print(err);
//       initSocket();
//     });
//   }
//
//   void onConnect() async {
//     try {
//       print("User Id ---> ${pageManager.currentUserId.value}");
//       socket!.emit("CONNECT", {
//         'senderId': pageManager.currentUserId.value,
//       });
//       log(jsonEncode({'senderId': pageManager.currentUserId.value}));
//       socket!.on("CONNECT_RESPONSE", (data) {
//         log("CONNECT_RESPONSE");
//         log("on ---> \n");
//         log(data.toString());
//         joinRoom();
//       });
//     } catch (e) {
//       print('On Connect Catch ---  >${e.toString()}');
//     }
//   }
//
//   joinRoom() async {
//     log("Join Room");
//     try {
//       socket!.emit("THREADS_LIST",
//           {'senderId': pageManager.currentUserId.value, 'search': ''});
//       socket!.on("THREADS_LIST_RESPONSE", (data) {
//         log("THREADS_LIST_RESPONSE");
//         log(jsonEncode({
//           'senderId': pageManager.currentUserId.value,
//         }));
//         log("on ---> \n");
//         log(data.toString());
//         var decodedData = jsonDecode(data);
//         chatThreadListData.value = ChatThreadListModel.fromJson(decodedData);
//         chatListLoading.value = false;
//       });
//     } catch (e) {
//       print('On Connect Catch ---  >${e.toString()}');
//     }
//   }
//
//   getUseChatDetailsSocket({bool maxScroller = false}) async {
//     try {
//       if (socket != null && socket!.connected) {
//         socket!.emit("CHAT_LIST", {
//           'senderId': pageManager.currentUserId.value,
//           'roomId': roomId.value,
//           'page': pageNo.value
//         });
//
//         socket!.on("CHAT_LIST_RESPONSE", (data) {
//           print('Init Calling 2');
//           var decodedData = jsonDecode(data);
//            chatModel.value = ChatModel.fromJson(decodedData);
//           if (firstTime.value) {
//             chatList.clear();
//             chatList.addAll(chatModel.value.data?.data?.data ?? []);
//             if (maxScroller && !scrollController.hasClients) {
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 scrollController
//                     .jumpTo(scrollController.position.maxScrollExtent);
//               });
//             }
//           } else {
//             chatList.addAll(chatModel.value.data?.data?.data ?? []);
//             firstTime.value = true;
//           }
//         });
//
//         socket!.on("SEND_MESSAGE_RESPONSE", (data) {
//           firstTime.value = true;
//           print('SEND_MESSAGE_RESPONSE Listener -- > $data');
//           moreChatDetailsSocket(pageNo: 1, maxScroller: true);
//           readAllChat();
//         });
//
//         socket!.on("READ_MESSAGE_RESPONSE", (data) {});
//       } else {
//         initSocket();
//       }
//     } catch (e) {
//       print('CHAT_LIST_RESPONSE ---> ${e.toString()}');
//     }
//   }
//
//   readAllChat() async {
//     socket!.emit("READ_MESSAGE", {
//       'senderId': pageManager.currentUserId.value,
//       'roomId': roomId.value,
//       'messageId': pageNo.value,
//       'type': 'all'
//     });
//   }
//
//   void sendMassageSocket({String messageType  = 'TEXT', messageFile = ''}) async {
//     print('messageType --- > $messageType    messageFile ----> $messageFile');
//     socket!.emit("SEND_MESSAGE", {
//       'senderId': pageManager.currentUserId.value,
//       'receiveId': receiveId.value,
//       'roomId': roomId.value,
//       'message': messageController.text.trim(),
//       'messageType': messageType,
//       'messageFile': messageFile,
//       'tipId': '0',
//     });
//     messageController.clear();
//     firstTime.value = true;
//   }
//
//   moreChatDetailsSocket({int? pageNo, bool maxScroller = false}) async {
//     socket!.emit("CHAT_LIST", {
//       'senderId': pageManager.currentUserId.value,
//       'roomId': roomId.value,
//       'page': pageNo
//     });
//     if (maxScroller && scrollController.hasClients) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         Future.delayed(const Duration(milliseconds: 800), () {
//           scrollController.jumpTo(scrollController.position.maxScrollExtent);
//         });
//       });
//     }
//   }
//
//   offEmitResponse(emitName) {
//     chatList.clear();
//     pageNo.value = 1;
//     socket!.off(emitName);
//     socket!.off('SEND_MESSAGE_RESPONSE');
//     socket!.off('CHAT_LIST_RESPONSE');
//   }
//   ///Upload FIle in Chat
//   Future<ApiResponseModel?> uploadFileOnChat(
//       BuildContext context, Map<String, dynamic> map,
//       {bool isRefresh = false, String filePath = ''}) async {
//     isRefresh ? null : showLoader(context);
//     ApiResponseModel apiResponse;
//
//     final FileInfo docuFile = FileInfo(
//         File(filePath), "attachment", "attachment", filePath.split(".").last);
//
//     apiResponse = await _apiManager.multipartRequest(
//       _apis.fileUploadOnChat,
//       [docuFile],
//       [],
//       Method.post,
//       map,
//     );
//
//     log("Add Post In Chat Data API Response -----> ${apiResponse.data}");
//     log("Add Post In Chat Data API Response -----> ${apiResponse.status}  ... ${apiResponse.data['success']}");
//     log("Add Post In Chat Data API Response -----> ${apiResponse.error}");
//     if (apiResponse.status) {
//       if (apiResponse.data['success']) {
//         isRefresh ? null : Get.back();
//         return apiResponse;
//       } else {
//         throw HttpException(apiResponse.data['message'] ?? '');
//       }
//     } else {
//       throw HttpException(apiResponse.error?.description ?? '');
//     }
//   }
//
//   ///Create Chat Thread
//   Future<ApiResponseModel?> createThread(
//       BuildContext context, Map<String, dynamic> map,
//       {bool isRefresh = false}) async {
//     isRefresh ? null : showLoader(context);
//     ApiResponseModel apiResponse = await _apiManager.request(
//       _apis.createThread,
//       Method.post,
//       map,
//     );
//     log("Add Post Favorite Data API Response -----> ${apiResponse.data}");
//     log("Add Post Favorite Data API Response -----> ${apiResponse.status}  ... ${apiResponse.data['success']}");
//     log("Add Post Favorite Data API Response -----> ${apiResponse.error}");
//     if (apiResponse.status) {
//       if (apiResponse.data['success']) {
//         isRefresh ? null : Get.back();
//         return apiResponse;
//       } else {
//         throw HttpException(apiResponse.data['message'] ?? '');
//       }
//     } else {
//       throw HttpException(apiResponse.error?.description ?? '');
//     }
//   }
//
//   String dirloc = "";
//   Future<bool> checkFile(String url) async {
//     // log("Hello Android");
//
//     dirloc = "";
//     update();
//     final status;
//     // = await Permission.storage.request()
//     if (Platform.isAndroid) {
//       AndroidDeviceInfo android = await DeviceInfoPlugin().androidInfo;
//       if(android.version.sdkInt > 32){
//
//         status =  await Permission.manageExternalStorage.request();
//         dirloc = "${(await getExternalStorageDirectory())!.path}/download/Defalcor/";
//       }
//       else{
//         status = await Permission.storage.request();
//         dirloc = "${(await getExternalStorageDirectory())!.path}/download/Defalcor/";
//       }
//     }
//     else{
//       status =  await Permission.storage.request();
//       dirloc = (await getApplicationDocumentsDirectory()).path;
//     }
//     log(status.toString());
//     if(dirloc != "") {
//       // String url = "https://v5.checkprojectstatus.com/evolve/public/documents/pdf/1710840089.pdf";
//       var pdfName ="$dirloc" + url.split("/").last;
//       if (await File(pdfName).exists()){
//         return false;
//       }
//       else{
//         log("Download Code Block")           ;
//         log('$pdfName');
//         return true;
//       }
//
//
//     }
//     else{
//       log("Denied");
//       if (Platform.isAndroid) {
//         AndroidDeviceInfo android = await DeviceInfoPlugin().androidInfo;
//         if(android.version.sdkInt > 32){
//           await Permission.manageExternalStorage.request();
//         }
//         else{
//           await Permission.storage.request();
//         }
//       }
//       else{
//         await Permission.storage.request();
//       }
//       return false;
//     }
//
//   }
// }
