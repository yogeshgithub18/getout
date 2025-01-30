// import 'dart:developer';
//
// import 'package:chewie/chewie.dart';
// import 'package:defalcor/common/base_image_network.dart';
// import 'package:defalcor/modules/chatscreen/controller/chat_controller.dart';
// import 'package:defalcor/modules/chatscreen/model/chat_list_model.dart';
// import 'package:defalcor/utils/images_path.dart';
// import 'package:defalcor/utils/utils_method.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:get_out/common_screens/colors.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';
//
// import '../../../common/custom_appbar.dart';
// import '../../../common/date_time_format.dart';
// import '../../../common/post/custom_network_image_display.dart';
// import '../../../resource/api_manager/apis.dart';
// import '../../../utils/custom_colors.dart';
// import '../../../utils/text_style.dart';
// import '../model/chat_thread_list_model.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
//
// class ChatScreen extends StatefulWidget {
//   final String? userName;
//
//   const ChatScreen({super.key, this.userName});
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final controller = Get.find<ChatController>();
//
//   // ScrollController scrollController = ScrollController();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     controller.scrollController = ScrollController();
//     super.initState();
//     print('Init Calling');
//
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       controller.chatList.clear();
//       controller.firstTime.value = true;
//       controller.getUseChatDetailsSocket(maxScroller: true);
//       controller.readAllChat();
//
//       print('scrollController --> ${controller.scrollController.hasClients}');
//       if (controller.scrollController.hasClients) {
//         controller.scrollController.animateTo(
//           controller.scrollController.position.maxScrollExtent,
//           curve: Curves.bounceIn,
//           duration: const Duration(milliseconds: 100),
//         );
//       }
//       controller.scrollController.addListener(() {
//         _onScroll();
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     controller.offEmitResponse('CHAT_LIST');
//     controller.scrollController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _onScroll() async {
//     print('scrollController.hasClients -- >${controller.chatModel.value.data}');
//     if (controller.scrollController.position.pixels ==
//             controller.scrollController.position.minScrollExtent &&
//         controller.chatModel.value.data!.data != null &&
//         controller.chatModel.value.data!.data!.lastPage! >
//             controller.pageNo.value) {
//       print("_onScroll done!!");
//
//       controller.firstTime.value = false;
//       controller.pageNo.value = controller.pageNo.value + 1;
//       log('Page No ----> ${controller.pageNo.value.toString()}');
//
//       controller.moreChatDetailsSocket(pageNo: controller.pageNo.value);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // if (controller.firstTime.value) {
//     //   // controller.listenerMessage();
//     // }
//     return Scaffold(
//         resizeToAvoidBottomInset: true,
//         appBar: CustomAppBar(
//           title: capitalize(widget.userName ?? ' '),
//           leadingIcon: '',
//           isPayShow: false,
//           isBackBtnOnPressed: () {
//             Navigator.of(context).pop();
//           },
//           trailingOnPressed: () {},
//           onPressed: () {},
//         ),
//         body: Obx(() => Stack(
//               alignment: Alignment.bottomCenter,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     // _topChat(context),
//                     controller.chatList.isNotEmpty
//                         ? _bodyChat(context, controller.chatList)
//                         : _buildEmptyChatState(),
//                     const SizedBox(
//                       height: 20,
//                     )
//                   ],
//                 ),
//                 _formChat(),
//               ],
//             )));
//   }
//
//   Widget _buildEmptyChatState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           Icon(
//             Icons.chat_bubble_outline,
//             size: 100.0,
//             color: Colors.grey[400],
//           ),
//           const SizedBox(height: 16.0),
//           Text(
//             'No messages yet',
//             style: TextStyle(fontSize: 20.0, color: Colors.grey[600]),
//           ),
//           SizedBox(height: MediaQuery.of(context).size.height / 2)
//         ],
//       ),
//     );
//   }
//
//   _topChat(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               GestureDetector(
//                 onTap: () => Navigator.of(context).pop(),
//                 child: const Icon(
//                   Icons.arrow_back_ios,
//                   size: 25,
//                   color: Colors.white,
//                 ),
//               ),
//               const Text(
//                 'Fiona',
//                 style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50),
//                   color: Colors.black12,
//                 ),
//                 child: const Icon(
//                   Icons.call,
//                   size: 25,
//                   color: Colors.white,
//                 ),
//               ),
//               const SizedBox(
//                 width: 20,
//               ),
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50),
//                   color: Colors.black12,
//                 ),
//                 child: const Icon(
//                   Icons.videocam,
//                   size: 25,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _bodyChat(BuildContext context, RxList<ChatListingModel> chatList) {
//     final controller = Get.find<ChatController>();
//     return Obx(() => Expanded(
//           child: Container(
//               padding: const EdgeInsets.only(
//                   left: 15, right: 10, top: 10, bottom: 00),
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(45),
//                     topRight: Radius.circular(45)),
//                 color: Colors.white,
//               ),
//               child: Align(
//                   alignment: Alignment.topCenter,
//                   child: ListView.builder(
//                       controller: controller.scrollController,
//                       reverse: false,
//                       // Set this to true
//                       shrinkWrap: true,
//                       padding: const EdgeInsets.only(bottom: 50),
//                       itemCount: controller.chatList.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         print(
//                             'Sender --  >${controller.pageManager.currentUserId.value}');
//                         print(
//                             'Current User --  >${chatList[index].sender?.id}');
//                         print(
//                             'Current User --  >${chatList[index].file}');
//                         int isSender = controller.chatList[index].sender?.id ==
//                                 int.parse(
//                                     controller.pageManager.currentUserId.value)
//                             ? 0
//                             : 1;
//                         return _itemChat(context,
//                             avatar: isSender == 0
//                                 ? ''
//                                 : controller.chatList[index].receiver
//                                         ?.profileImage ??
//                                     ' ',
//                             chat: isSender,
//                             message: controller.chatList[index].message ?? ' ',
//                             messageType:
//                                 controller.chatList[index].fileType ?? ' ',
//                             messageFile:
//                                 // 'https://v1.checkprojectstatus.com/defalcor/public/uploads/category/review_1719292225.jpg',
//                             controller.chatList[index].file ?? '',
//                             time: DateTimeFormat.timeCard24HoursFormat.format(
//                                 DateTime.parse(
//                                     '${controller.chatList[index].createdAt}')));
//                       }))
//
//               // ListView(
//               //   physics: const BouncingScrollPhysics(),
//               //   children: [
//               //     _itemChat(
//               //       context,
//               //       avatar:
//               //           'https://media.istockphoto.com/id/1386479313/photo/happy-millennial-afro-american-business-woman-posing-isolated-on-white.jpg?s=612x612&w=0&k=20&c=8ssXDNTp1XAPan8Bg6mJRwG7EXHshFO5o0v9SIj96nY=',
//               //       chat: 1,
//               //       message:
//               //           'Alex, let’s meet this weekend. I’ll check with Dave too 😎',
//               //       time: '18.00',
//               //     ),
//               //     _itemChat(
//               //       context,
//               //       chat: 0,
//               //       message: 'Sure. Let’s aim for saturday',
//               //       time: '18.00',
//               //     ),
//               //     _itemChat(
//               //       context,
//               //       chat: 0,
//               //       message: 'I’m visiting mom this sunday 👻',
//               //       time: '18.00',
//               //     ),
//               //     _itemChat(
//               //       context,
//               //       avatar:
//               //           'https://media.istockphoto.com/id/1386479313/photo/happy-millennial-afro-american-business-woman-posing-isolated-on-white.jpg?s=612x612&w=0&k=20&c=8ssXDNTp1XAPan8Bg6mJRwG7EXHshFO5o0v9SIj96nY=',
//               //       chat: 1,
//               //       message: 'Alrighty! Will give you a call shortly 🤗',
//               //       time: '18.00',
//               //     ),
//               //     _itemChat(
//               //       context,
//               //       chat: 0,
//               //       message: '❤️',
//               //       time: '18.00',
//               //     ),
//               //     _itemChat(
//               //       context,
//               //       avatar:
//               //           'https://media.istockphoto.com/id/1386479313/photo/happy-millennial-afro-american-business-woman-posing-isolated-on-white.jpg?s=612x612&w=0&k=20&c=8ssXDNTp1XAPan8Bg6mJRwG7EXHshFO5o0v9SIj96nY=',
//               //       chat: 1,
//               //       message: 'Hey you! Are you there?',
//               //       time: '18.00',
//               //     ),
//               //     _itemChat(
//               //       context,
//               //       avatar:
//               //           'https://media.istockphoto.com/id/1386479313/photo/happy-millennial-afro-american-business-woman-posing-isolated-on-white.jpg?s=612x612&w=0&k=20&c=8ssXDNTp1XAPan8Bg6mJRwG7EXHshFO5o0v9SIj96nY=',
//               //       chat: 0,
//               //       message: '👋 Hi Jess! What’s up?',
//               //       time: '18.00',
//               //     ),
//               //   ],
//               // ),
//               ),
//         ));
//   }
//
//   _itemChat(BuildContext context,
//       {required int chat,
//       String? avatar = '',
//       message,
//       time,
//       messageType,
//       messageFile}) {
//     return StatefulBuilder(builder: (context, setState) {
//       print('File Path 0--- > ${messageFile}');
//       print('File Path 0--- > ${messageType}');
//       print('File Path 0--- > ${messageType.toString().toLowerCase() == 'pdf'}');
//
//       return Row(
//         mainAxisAlignment:
//             chat == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           avatar != ''
//               ? Avatar(
//                   image: avatar,
//                   size: 35,
//                 )
//               : const SizedBox.shrink(),
//           Flexible(
//             child: Column(
//               mainAxisAlignment:
//                   chat == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
//               crossAxisAlignment:
//                   chat == 0 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//               children: [
//                 Visibility(
//                     visible: messageType.toString().toLowerCase() == 'text',
//                     child: Container(
//                       constraints: BoxConstraints(
//                           maxWidth: MediaQuery.of(context).size.width * 0.7),
//                       margin: const EdgeInsets.only(left: 10, right: 0, top: 0),
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: chat == 0
//                             ? CustomColors.chatContainerCl
//                             : CustomColors.dropBGColor,
//                         borderRadius: chat == 0
//                             ? const BorderRadius.only(
//                                 topLeft: Radius.circular(12),
//                                 topRight: Radius.circular(4),
//                                 bottomLeft: Radius.circular(12),
//                                 bottomRight: Radius.circular(12),
//                               )
//                             : const BorderRadius.only(
//                                 topLeft: Radius.circular(4),
//                                 topRight: Radius.circular(12),
//                                 bottomLeft: Radius.circular(12),
//                                 bottomRight: Radius.circular(12),
//                               ),
//                       ),
//                       child: Text(
//                         '$message',
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     )),
//                 Visibility(
//                     visible: messageType.toString().toLowerCase() == 'image',
//                     child: imageMessage(messageFile)),
//                 Visibility(
//                     visible: messageType.toString().toLowerCase() == 'video',
//                     child: videoMessage(context, messageFile)),
//                 Visibility(
//                     visible: messageType.toString().toLowerCase() == 'pdf',
//                     child: docMessage(context, messageFile)),
//                 Padding(
//                     padding: EdgeInsets.only(left: chat == 0 ? 0 : 10),
//                     child: Text(
//                       '$time',
//                       style: const TextStyle(color: CustomColors.timeChatColor),
//                     )),
//               ],
//             ),
//           ),
//
//           // chat == 1
//           //     ? Text(
//           //         '$time',
//           //         style: TextStyle(color: Colors.grey.shade400),
//           //       )
//           //     : const SizedBox(),
//         ],
//       ).paddingOnly(bottom: 10);
//     });
//   }
//
//   Widget _formChat() {
//     return Positioned(
//       child: Align(
//         alignment: Alignment.bottomCenter,
//         child: Container(
//           height: 70,
//           padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//           color: CustomColors.blackColor,
//           child: TextField(
//             onTap: () {
//               controller.scrollController
//                   .jumpTo(controller.scrollController.position.maxScrollExtent);
//             },
//             scrollPadding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom),
//             style: CustomTextStyle.robotoMediumTextStyle(
//                     fontSize: 16, textColor: CustomColors.whiteColor)
//                 .copyWith(fontWeight: FontWeight.w400),
//             controller: controller.messageController,
//             decoration: InputDecoration(
//               hintText: 'Type your message here...',
//               hintStyle: CustomTextStyle.robotoRegularTextStyle(fontSize: 16)
//                   .copyWith(
//                       color: CustomColors.hintColor1,
//                       fontWeight: FontWeight.w300),
//               suffixIcon: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   IconButton(
//                       onPressed: () async {
//                         final pickedFile =
//                             await _addPictureSheetItemNew(context, 0);
//                       },
//                       icon: const Icon(Icons.add, color: Colors.white),
//                       padding: EdgeInsets.zero),
//                   GestureDetector(
//                       onTap: () {
//                         print(
//                             'Message TExt --- > ${controller.messageController.text.trim()}');
//                         if (controller.messageController.text
//                             .trim()
//                             .isNotEmpty) {
//                           controller.sendMassageSocket();
//                           controller.scrollController.jumpTo(controller
//                               .scrollController.position.maxScrollExtent);
//                         }
//                       },
//                       child: Container(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(50),
//                               color: CustomColors.blackColor),
//                           margin: const EdgeInsets.only(
//                               left: 0, right: 5, top: 5, bottom: 5),
//                           padding: const EdgeInsets.only(
//                               left: 9, top: 8, bottom: 8, right: 8),
//                           child: SvgPicture.asset(ImagesPath.sendMessage)
//                           // const Icon(
//                           //   Icons.send_rounded,
//                           //   color: Colors.white,
//                           //   size: 28,
//                           // ),
//                           ))
//                 ],
//               ),
//               filled: true,
//               fillColor: ColoRRes.homeConColor,
//               labelStyle: const TextStyle(fontSize: 12),
//               contentPadding: const EdgeInsets.symmetric(horizontal: 20),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(color:  ColoRRes.homeConColor),
//                 borderRadius: BorderRadius.circular(25),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(color: ColoRRes.homeConColor),
//                 borderRadius: BorderRadius.circular(25),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Future<XFile?> _addPictureSheetItemNew(
//   //     BuildContext context, int index) async {
//   //   XFile? file;
//   //   await showCupertinoModalPopup<void>(
//   //     context: context,
//   //     barrierColor: CustomColors.blackColor.withOpacity(0.70),
//   //     builder: (BuildContext context) => CupertinoActionSheet(
//   //       title: Text('Select File'.tr,
//   //           style: CustomTextStyle.robotoMediumTextStyle(
//   //               fontSize: 19, textColor: CustomColors.blackColor)),
//   //       cancelButton: Container(
//   //           decoration: BoxDecoration(
//   //               borderRadius: BorderRadius.circular(10),
//   //               border: Border.all(color: CustomColors.whiteColor, width: 2)),
//   //           child: CupertinoActionSheetAction(
//   //             onPressed: () {
//   //               Navigator.pop(context);
//   //             },
//   //             child: Text(
//   //               'Cancel'.tr,
//   //               style: CustomTextStyle.robotoMediumTextStyle(
//   //                       fontSize: 16, textColor: CustomColors.blackColor)
//   //                   .copyWith(fontWeight: FontWeight.w600),
//   //             ),
//   //           )),
//   //       actions: <CupertinoActionSheetAction>[
//   //         // CupertinoActionSheetAction(
//   //         //     onPressed: () async {
//   //         //       // Navigator.of(context).pop();
//   //         //       final dataFile = await selectVideoNew(context);
//   //         //       if (dataFile != null) {
//   //         //         file = dataFile;
//   //         //       }
//   //         //       Get.back();
//   //         //     },
//   //         //     child: Text(
//   //         //       'Take Video',
//   //         //       style: CustomTextStyle.robotoMediumTextStyle(
//   //         //           fontSize: 16, textColor: CustomColors.blackColor),
//   //         //     )),
//   //         // CupertinoActionSheetAction(
//   //         //   onPressed: () async {
//   //         //     final dataFile = await selectImage(context);
//   //         //     if (dataFile != null) {
//   //         //       // file = dataFile;
//   //         //       // controller.setPostMethod(dataFile, index);
//   //         //       setState(() {});
//   //         //     }
//   //         //     Get.back();
//   //         //   },
//   //         //   child: Text(
//   //         //     'Take Photo',
//   //         //     style: CustomTextStyle.robotoMediumTextStyle(
//   //         //       fontSize: 16,
//   //         //       textColor: CustomColors.blackColor,
//   //         //     ),
//   //         //   ),
//   //         // ),
//   //         CupertinoActionSheetAction(
//   //             onPressed: () async {
//   //               final dataFile = await selectNewFile(context);
//   //               if (dataFile != null) {
//   //                 print('FilePickerResult -- > ${dataFile}');
//   //                 await controller
//   //                     .uploadFileOnChat(context, {},
//   //                     filePath: dataFile.files.first.path ?? '',
//   //                     isRefresh: false)
//   //                     .then((value) {
//   //                   print('Path -- > ${value?.data}');
//   //                   print('Path -- > ${value?.data['data']['type']}');
//   //                   print('Path -- > ${value?.data['data']['image']}');
//   //                   controller.sendMassageSocket(
//   //                       messageType: value?.data['data']['type'],
//   //                       messageFile:
//   //                       APIS.pathUrl + value?.data['data']['image']);
//   //                 });
//   //               }
//   //               Get.back();
//   //             },
//   //             child: Text(
//   //               'Take File',
//   //               style: CustomTextStyle.robotoMediumTextStyle(
//   //                   fontSize: 16, textColor: CustomColors.blackColor),
//   //             )),
//   //       ],
//   //     ),
//   //   );
//   //
//   //   return file;
//   // }
//   //
//   // SizedBox imageMessage(String imageUrl) {
//   //   return SizedBox(
//   //       width: MediaQuery.of(context).size.width * 0.5,
//   //       child: GestureDetector(
//   //           onTap: () {
//   //             _showImageDialog(context, imageUrl);
//   //           },
//   //           child: Hero(
//   //             tag: imageUrl,
//   //             child: NetworkDisplay(
//   //               blurHash: '',
//   //               isThatImage: true,
//   //               url: imageUrl,
//   //             ),
//   //           )));
//   // }
//   //
//   // SizedBox docMessage(BuildContext context, String imageUrl) {
//   //   return SizedBox(
//   //       width: MediaQuery.of(context).size.width * 0.5,
//   //       child: GestureDetector(
//   //         onTap: () {
//   //           // Handle file tap action here
//   //           _openFile(context, 'https://v1.checkprojectstatus.com/defalcor/public/uploads/category/review_1719301640.pdf', imageUrl.split("/").last ?? 'File');
//   //         },
//   //         child: Row(
//   //           children: [
//   //             const Icon(Icons.attach_file),
//   //             const SizedBox(width: 5.0),
//   //             Expanded(
//   //                 child: Padding(
//   //                     padding: const EdgeInsets.symmetric(
//   //                         horizontal: 2, vertical: 2),
//   //                     child: Text(
//   //                       imageUrl.split("/").last ?? 'File',
//   //                       overflow: TextOverflow.ellipsis,
//   //                       style: const TextStyle(
//   //                           color: Colors.blue,
//   //                           decoration: TextDecoration.underline,
//   //                           fontSize: 17),
//   //                     ))),
//   //           ],
//   //         ),
//   //       ));
//   // }
//   //
//   // SizedBox videoMessage(BuildContext context, String imageUrl) {
//   //   return SizedBox(
//   //       width: MediaQuery.of(context).size.width * 0.5,
//   //       child: GestureDetector(
//   //           onTap: () {
//   //             _showVideoDialog(context, imageUrl);
//   //           },
//   //           child: Hero(
//   //             tag: imageUrl,
//   //             child: NetworkDisplay(
//   //               blurHash: '',
//   //               isThatImage: true,
//   //               url: imageUrl,
//   //             ),
//   //           )));
//   // }
//   //
//   // void _openFile(BuildContext context, String fileUrl, String fileName) {
//   //   // Implement logic to open the file, e.g., using WebView or other suitable widgets
//   //   // For demonstration purposes, we're showing a simple dialog here
//   //   // showDialog(
//   //   //   context: context,
//   //   //   builder: (BuildContext context) {
//   //   //     return AlertDialog(
//   //   //       title: Text(fileName),
//   //   //       content: Text('File URL: $fileUrl'),
//   //   //       actions: [
//   //   //         TextButton(
//   //   //           onPressed: () {
//   //   //             Navigator.of(context).pop();
//   //   //           },
//   //   //           child: Text('Close'),
//   //   //         ),
//   //   //       ],
//   //   //     );
//   //   //   },
//   //   // );
//   //
//   //   Navigator.push(
//   //     context,
//   //     MaterialPageRoute(
//   //       builder: (context) => FileViewerScreen(fileUrl: fileUrl, fileName: fileName),
//   //     ),
//   //   );
//   // }
//
//   // void _showImageDialog(BuildContext context, String imageUrl) {
//   //   showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return ImageDialog(imageUrl: imageUrl);
//   //     },
//   //   );
//   // }
//   //
//   // void _showVideoDialog(BuildContext context, param1) {
//   //   showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return VideoDialog(
//   //         videoPlayerController: VideoPlayerController.network(
//   //           param1,
//   //         ),
//   //         looping: true,
//   //       );
//   //     },
//   //   );
//   // }
// }
//
// // class FileViewerScreen extends StatelessWidget {
// //   final String fileUrl;
// //   final String fileName;
// //
// //   const FileViewerScreen({super.key, required this.fileUrl, required this.fileName});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(fileName),
// //       ),
// //       body: WebviewScaffold(
// //         url: fileUrl,
// //         withZoom: true, // Enable zooming
// //         withLocalStorage: true, // Enable local storage
// //         hidden: true, // Hide webview
// //         initialChild: Container(
// //           color: Colors.white,
// //           child: const Center(child: CircularProgressIndicator()),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class ImageDialog extends StatelessWidget {
// //   final String imageUrl;
// //
// //   ImageDialog({required this.imageUrl});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Dialog(
// //       insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 100),
// //       child: GestureDetector(
// //           onTap: () {
// //             Navigator.of(context).maybePop();
// //           },
// //           child: Container(
// //             padding: const EdgeInsets.all(18.0),
// //             decoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(30),
// //               image: DecorationImage(
// //                 image: NetworkImage(imageUrl),
// //                 // fit: BoxFit.cover,
// //               ),
// //             ),
// //           )),
// //     );
// //   }
// // }
// //
// // class VideoDialog extends StatefulWidget {
// //   final VideoPlayerController videoPlayerController;
// //   final bool looping;
// //
// //   const VideoDialog(
// //       {super.key, required this.videoPlayerController, required this.looping});
// //
// //   @override
// //   VideoDialogState createState() => VideoDialogState();
// // }
// //
// // class VideoDialogState extends State<VideoDialog> {
// //   late ChewieController videosController;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     videosController = ChewieController(
// //       videoPlayerController: widget.videoPlayerController,
// //       // aspectRatio: 16 / 9,
// //       autoInitialize: true,
// //       looping: widget.looping,
// //       errorBuilder: (context, errorMessage) {
// //         print('Error Message ---  >$errorMessage');
// //         return Center(child: progressBar());
// //       },
// //     );
// //   }
// //
// //   Widget progressBar() {
// //     return const CircularProgressIndicator();
// //   }
// //
// //   @override
// //   void dispose() {
// //     super.dispose();
// //     // IMPORTANT to dispose of all the used resources
// //     // widget.videoPlayerController.dispose();
// //     videosController.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Dialog(
// //         insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 100),
// //         child: GestureDetector(
// //             onTap: () {
// //               Navigator.of(context).maybePop();
// //             },
// //             child: Container(
// //               decoration: BoxDecoration(
// //                   color: Colors.white, borderRadius: BorderRadius.circular(30)),
// //               padding: const EdgeInsets.all(18.0),
// //               child: Chewie(
// //                 controller: videosController,
// //               ),
// //             )));
// //   }
// // }
// //
// // class Avatar extends StatelessWidget {
// //   final double size;
// //   final String? image;
// //   final EdgeInsets margin;
// //
// //   const Avatar(
// //       {super.key,
// //       this.image,
// //       this.size = 40,
// //       this.margin = const EdgeInsets.all(0)});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: margin,
// //       child: Container(
// //         width: size,
// //         height: size,
// //         decoration: BoxDecoration(
// //             border: Border.all(color: Colors.black),
// //             borderRadius: BorderRadius.circular(100)),
// //         padding: const EdgeInsets.all(0),
// //         child: BaseImageNetwork(
// //           link: image,
// //           borderRadius: 100,
// //           errorWidget: Icon(Icons.person, size: size),
// //         ),
// //       ),
// //     );
// //   }
// // }
