import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get_out/common_screens/colors.dart';
import 'package:get_out/controller/chat_controller.dart';
import 'package:get_out/controller/itninerary_controller.dart';
import 'package:get_out/modal/my_friend_response.dart';
import 'package:get_out/storage/base_shared_preference.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common_screens/app_text.dart';
import '../../common_screens/view_image_single.dart';
import '../../controller/base_controller.dart';
import '../../modal/chat_list_model.dart';
import '../../modal/swipe_card_response.dart';
import '../home/home_main/company.dart';
import 'generate_itinerary.dart';
import 'join_plan_detail/join_plan_detail.dart';
import 'join_plan_detail/pages/add_from_library.dart';
import 'open_profile.dart';
import 'package:get/get.dart';

class UserChating extends StatefulWidget {
  final String receiveId, roomId, profileImage, userName, chatType;
  final String ? placeId,imageUrl;
  final int ? groupId;
  const UserChating(
      {super.key,
        this.placeId,
        this.groupId,
        this.imageUrl,
      required this.receiveId,
      required this.roomId,
      required this.profileImage,
      required this.userName,
      required this.chatType});

  @override
  State<UserChating> createState() => _UserChatingState();
}

class _UserChatingState extends State<UserChating> {
  ChatController controller = Get.find<ChatController>();
  BaseController baseController = Get.find<BaseController>();
  int? userId;
  @override
  void initState() {
    // TODO: implement initState
    controller.isChatHide.value=true;
    userId = baseController.user.value.id;
    controller.receiveId.value = widget.receiveId.toString();
    controller.roomId.value = widget.roomId.toString();
    print("roomId---${controller.roomId.value}---${controller.receiveId.value}---${widget.imageUrl}");
    controller.scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller.chatList.clear();
      controller.firstTime.value = true;
      controller.getUseChatDetailsSocket(maxScroller: true, type: widget.chatType);
      if(widget.placeId!=null) {
        controller.placeId.value = widget.placeId!;
        Future.delayed(const Duration(seconds: 1),(){
          controller.sendMassageSocket(messageType: 'place',senderType: widget.chatType);
        });
      }
      if(widget.imageUrl!=null) {
        Future.delayed(const Duration(seconds: 1),(){
          controller.sendMassageSocket(messageType: 'IMAGE',messageFile:widget.imageUrl,senderType: widget.chatType);
        });
      }
       controller.readAllChat();
      if (controller.scrollController.hasClients) {
        controller.scrollController.animateTo(
          controller.scrollController.position.maxScrollExtent,
          curve: Curves.bounceIn,
          duration: const Duration(milliseconds: 100),
        );
      }
      controller.scrollController.addListener(() {
        _onScroll();
      });
    });
    super.initState();
  }

  Future<void> _onScroll() async {
    print('scrollController.hasClients -- >${controller.chatModel.value.data}');
    if (controller.scrollController.position.pixels ==
            controller.scrollController.position.minScrollExtent &&
        controller.chatModel.value.data!.data != null &&
        controller.chatModel.value.data!.data!.lastPage! >
            controller.pageNo.value) {
      print("_onScroll done!!");

      controller.firstTime.value = false;
      controller.pageNo.value = controller.pageNo.value + 1;
      log('Page No ----> ${controller.pageNo.value.toString()}');
      controller.moreChatDetailsSocket(pageNo: controller.pageNo.value);
    }
  }

  @override
  void dispose() {
    controller.offEmitResponse('CHAT_LIST');
    controller.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      appBar: ChatAppBar(
        profileImageUrl: widget.profileImage,
        userName: widget.userName,
        isOnline: true,
        type: widget.chatType,
          groupId:widget.groupId
      ),
      backgroundColor: ColoRRes.backGroundColor,
      body: Obx(() => Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.chatList.isNotEmpty
                      ? _bodyChat(context, controller.chatList)
                      : _buildEmptyChatState(),
                  const SizedBox(
                    height:100,
                  )
                ],
              ),
             Obx(()=> Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if(controller.isChatHide.value)
                    Container(
                      margin: EdgeInsets.only(top: 20.sp, bottom: 12.sp),
                      height: 7.h,
                      decoration: BoxDecoration(
                        color: ColoRRes.white,
                        borderRadius: BorderRadius.circular(50.sp),
                      ),
                      child: TextField(
                        controller: controller.messageController.value,
                        cursorColor: ColoRRes.black,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          prefixIcon:widget.chatType.toLowerCase()=='group'? InkWell(
                            onTap: (){
                              if(widget.chatType.toLowerCase()=='group') {
                                controller.isChatHide.value = false;
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 11.sp, right: 16.sp),
                              child: Container(
                                padding: EdgeInsets.all(12.sp),
                                decoration: const BoxDecoration(
                                    color: ColoRRes.textColor,
                                    shape: BoxShape.circle),
                                child: const Icon(
                                  Icons.close_rounded,
                                  color: ColoRRes.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ):SizedBox.shrink(),
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 10.sp),
                            child: GestureDetector(
                              onTap: () {
                                if(controller.messageController.value.text.trim().isNotEmpty) {
                                  controller.sendMassageSocket(senderType: widget.chatType);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(14.sp),
                                decoration: const BoxDecoration(
                                    color: ColoRRes.indicatorColor,
                                    shape: BoxShape.circle),
                                child: SvgPicture.asset(
                                  'assets/chat/sendMessage.svg',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          hintText: 'Type Message',
                          hintStyle: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: ColoRRes.textSubColor,
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 20.sp,
                          ),
                        ),
                      ),
                    ),
                    if(widget.chatType.toLowerCase()=='group')
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              controller.isChatHide.value=true;
                            },
                            child: buildIconContainer(
                              'assets/chat/message.svg',
                              ColoRRes.indicatorColor,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              List<Cards> ? result= await Get.to(()=>const AddFromLibrary());
                              if(result!=null && result.isNotEmpty){
                                controller.selectedEvents.value=result;
                                controller.sendMassageSocket(senderType:widget.chatType,messageType: 'place');
                              }
                            },
                            child: buildIconContainer(
                              'assets/chat/chatStar.svg',
                              ColoRRes.chatStarColor,
                            ),
                          ),
                          InkWell(
                            onTap: ()async{
                            await Get.to(()=>const JoinPlanDetail(page:'chat',from:'chat',type:'',placeId: '',))?.whenComplete(() async {
                              String ? id=await BaseSharedPreference().getString("event_id");
                              print("event_id---$id");
                              if((id??'').isNotEmpty){
                                controller.eventId.value=id!;
                                controller.sendMassageSocket(messageType:'event',senderType: widget.chatType);
                              }
                            });
                            },
                            child: buildIconContainer(
                              'assets/chat/flotEdit.svg',
                              ColoRRes.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ],
          )),
    );
  }

  String dateTime(String date) {
    DateTime parsedDateTime = DateTime.parse(date);
    TimeOfDay time =
        TimeOfDay(hour: parsedDateTime.hour, minute: parsedDateTime.minute);
    return formatTimeOfDay(time);
  }

  String formatTimeOfDay(TimeOfDay time) {
    // Convert 24-hour time to 12-hour format
    final hour = time.hourOfPeriod == 0
        ? 12
        : time.hourOfPeriod; // Convert 0 to 12 for 12-hour format
    final minute =
        time.minute.toString().padLeft(2, '0'); // Add leading zero to minutes
    final period = time.period == DayPeriod.am ? "AM" : "PM";

    return "$hour:$minute $period";
  }

  Widget _bodyChat(BuildContext context, RxList<ChatListingModel> chatList) {
    final controller = Get.find<ChatController>();
    print(" called list view");
    return Obx(() => Expanded(
           child: Container(
              padding: const EdgeInsets.only(left: 15, right: 10, top: 10, bottom: 00),
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45)),
                color: ColoRRes.backGroundColor,
              ),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: ListView.builder(
                      controller: controller.scrollController,
                      reverse: false,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: 50),
                      itemCount: controller.chatList.length,
                      itemBuilder: (BuildContext context, int index) {
                        print('Current User --  >${chatList[index].sender?.id}');
                        print('file --  >${chatList[index].file}');
                        int isSender = controller.chatList[index].sender?.id == userId ? 0 : 1;
                        return _itemChat(
                          context,
                          index:index,
                          chat_id:controller.chatList[index].id??0,
                          likeCount:controller.chatList[index].like_count??0,
                          dislikeCount:controller.chatList[index].dislike_count??0,
                          emojiCount:controller.chatList[index].emoji_count??0,
                          avatar: isSender == 0
                              ? ''
                              : controller
                                      .chatList[index].sender?.profileImage ??
                                  ' ',
                          chat: isSender,
                          message: controller.chatList[index].message ?? ' ',
                          messageType: controller.chatList[index].fileType ?? ' ',
                          messageFile: controller.chatList[index].file ?? '',
                          place: controller.chatList[index].place??[],
                          event: controller.chatList[index].eventDetails??[],
                          time: dateTime(controller.chatList[index].createdAt!), //"12:55"
                        );
                      }))),
        ));
  }

  Widget _itemChat(BuildContext context,
      {required int chat,
       int chat_id=0,
       required int index,
       int likeCount=0,
       int dislikeCount=0,
       int emojiCount=0,
        List<Cards> ? place,
        List<EventDetails> ? event,
      String? avatar = '',
      message,
      time,
      messageType,
      messageFile}) {
    return StatefulBuilder(builder: (context, setState) {
      return Row(
        mainAxisAlignment:
            chat == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          avatar != ''
              ?
             ClipOval(
      child: CachedNetworkImage(
        imageUrl: avatar ?? '', // Ensure the URL is not null
        fit: BoxFit.cover,
        width: 9.w,
        height: 4.h,
        placeholder: (context, url) => Center(
          child: SizedBox(
            width: 9.w,
            height: 4.h,
            child: const Icon(
              Icons.image,
              size: 24, // Adjust icon size as needed
              color: Colors.grey, // Adjust icon color as needed
            ),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
            border: Border.all(color: ColoRRes.borderColor),
            borderRadius: BorderRadius.circular(8.sp),
          ),
          child: Image.asset(
            "assets/images/noImage.jpg",
            fit: BoxFit.fill,
            width: 9.w,
            height: 4.h,
          ),
        ),
      ),
      )
              : const SizedBox.shrink(),
              Flexible(
            child: Column(
              mainAxisAlignment:
                  chat == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
              crossAxisAlignment:
                  chat == 0 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Visibility(
                    visible: messageType.toString().toLowerCase() == 'text',
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7),
                      margin: const EdgeInsets.only(left: 10, right: 0, top: 0),
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.sp, vertical: 16.sp),
                      decoration: BoxDecoration(
                        color: chat == 0 ? ColoRRes.textColor : ColoRRes.white,
                        borderRadius: chat == 0
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(4),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              )
                            : const BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                      ),
                      child: AppTexts.inter12W400(
                        '$message',
                        textColor:
                            chat == 0 ? ColoRRes.white : ColoRRes.textColor,
                      ),
                    )),
                Visibility(
                  visible: messageType.toString().toLowerCase() == 'place',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: (place ?? []).map((e) {
                      return InkWell(
                        onTap: (){
                          Get.to(() => Company(
                              id: e.placeId));
                        },
                        child: Container(
                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7,minWidth:18.w ),
                          margin: const EdgeInsets.only(left: 10, right: 0, top: 10),
                          padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                          decoration: BoxDecoration(
                            color: chat == 0 ? ColoRRes.textColor : ColoRRes.white,
                            borderRadius: BorderRadius.circular(10), // Unified border radius
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    child: CachedNetworkImage(
                                      imageUrl: e.photo ?? '', // Handle null URL
                                      height: 20.h,
                                      width: 35.w,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Center(
                                        child: Icon(
                                          Icons.image,
                                          size: 40, // Adjust icon size if necessary
                                          color: Colors.grey, // Customize icon color if needed
                                        ),
                                      ),
                                      errorWidget: (context, url, error) => Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: ColoRRes.borderColor),
                                          borderRadius: BorderRadius.circular(12.sp),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.sp),
                                          child: Image.asset(
                                            "assets/images/noImage.jpg",
                                            fit: BoxFit.fill,
                                            height: 20.h,
                                            width: 35.w,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width:35.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap:()async{
                                       await controller.likeDislike(chat_id,"like",index);
                                      },
                                      child: buildIconContainer2(
                                        'assets/chat/like.svg',
                                        ColoRRes.indicatorColor,
                                        likeCount
                                      ),
                                    ),
                                    InkWell(
                                      onTap:(){
                                        controller.likeDislike(chat_id,"emoji",index);

                                      },
                                      child: buildIconContainer2(
                                        'assets/chat/smile.svg',
                                        ColoRRes.indicatorColor,
                                        emojiCount
                                      ),
                                    ),
                                    InkWell(
                                      onTap:(){
                                        controller.likeDislike(chat_id,"dislike",index);
                                      },
                                      child: buildIconContainer2(
                                        'assets/chat/dislike.svg',
                                        ColoRRes.chatStarColor,
                                        dislikeCount
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Visibility(
                  visible: messageType.toString().toLowerCase() == 'image',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          Get.to(()=>ViewImageSingle(images:messageFile,text:''));

                        },
                        child: Container(
                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7,minWidth:18.w ),
                          margin: const EdgeInsets.only(left: 10, right: 0, top: 10),
                          padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                          decoration: BoxDecoration(
                            color: chat == 0 ? ColoRRes.textColor : ColoRRes.white,
                            borderRadius: BorderRadius.circular(10), // Unified border radius
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.sp),
                                child: CachedNetworkImage(
                                  imageUrl: messageFile,
                                  height: 20.h,
                                  width: 35.w,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                    child: SizedBox(
                                      height: 20.h,
                                      width: 35.w,
                                      child: const Icon(
                                        Icons.image,
                                        size: 40, // Adjust icon size as needed
                                        color: Colors.grey, // Customize icon color
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: ColoRRes.borderColor),
                                      borderRadius: BorderRadius.circular(12.sp),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.sp),
                                      child: Image.asset(
                                        "assets/images/noImage.jpg",
                                        fit: BoxFit.fill,
                                        height: 20.h,
                                        width: 35.w,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]
                  ),
                ),
                if(messageType.toString().toLowerCase() == 'event')
                InkWell(
                  onTap: (){
                    Get.to(() => GenerateItinerary(from:'normal',id: event![0].id.toString()));
                  },
                  child: Container(
                    width: 60.w,
                    decoration: const BoxDecoration(
                      color: ColoRRes.textColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        bottomLeft: Radius.circular(14),
                        bottomRight: Radius.circular(14),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               AppTexts.inter16W400(
                                '${event?[0].userName??''} Made a Plan',
                                textColor: ColoRRes.white,
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              Container(
                                width: double.infinity,
                                height: 0.5,
                                color: ColoRRes.white.withOpacity(0.7),
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Start location : ',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        color: ColoRRes.white.withOpacity(0.5),
                                        fontSize: 10,
                                      ),
                                    ),
                                    WidgetSpan(
                                      child: FutureBuilder<String>(
                                        future: getLocationName(event?[0].latitude??'0.0',event?[0].longitude??'0.0'),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return const Text(
                                              "Loading...",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontFamily: 'Inter',
                                                color: Colors.grey,
                                              ),
                                            );
                                          } else if (snapshot.hasError) {
                                            return const Text(
                                              "Error fetching location",
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontFamily: 'Inter',
                                                color: Colors.red,
                                              ),
                                            );
                                          } else {
                                            return Text(
                                              snapshot.data ?? "Unknown location",
                                              style: const TextStyle(
                                                fontSize: 10,
                                                fontFamily: 'Inter',
                                                color: Colors.white,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Time :',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        color: ColoRRes.white.withOpacity(0.5),
                                        fontSize: 10,
                                      ),
                                    ),
                                     TextSpan(
                                      text:getDifference(event?[0].startTime??'12:00 PM',event?[0].endTime??'12:00 PM'),
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        color: ColoRRes.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Activity :',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        color: ColoRRes.white.withOpacity(0.5),
                                        fontSize: 10,
                                      ),
                                    ),
                                     TextSpan(
                                      text: event?[0].eventsCount.toString(),
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        color: ColoRRes.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Container(
                        //         padding: EdgeInsets.symmetric(vertical: 16.sp),
                        //         decoration: const BoxDecoration(
                        //           color: ColoRRes.primary,
                        //           borderRadius: BorderRadius.only(
                        //             bottomLeft: Radius.circular(10),
                        //           ),
                        //         ),
                        //         child: const Center(
                        //           child: AppTexts.inter14W500(
                        //             'Join Plan',
                        //             textColor: ColoRRes.white,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child: Container(
                        //         padding: EdgeInsets.symmetric(vertical: 16.sp),
                        //         decoration: const BoxDecoration(
                        //           color: ColoRRes.chatStarColor,
                        //           borderRadius: BorderRadius.only(
                        //             bottomRight: Radius.circular(10),
                        //           ),
                        //         ),
                        //         child: const Center(
                        //           child: AppTexts.inter14W500(
                        //             'Leave',
                        //             textColor: ColoRRes.white,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: chat == 0 ? 0 : 10),
                    child: AppTexts.inter10W500(
                      '$time',
                    )),
              ],
            ),
          ),
        ],
      ).paddingOnly(bottom: 10);
    });
  }

  Future<String> getLocationName(String lat,String lng) async {
    String name='';
    List<Placemark> placemarks = await placemarkFromCoordinates(double.parse(lat), double.parse(lng),);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      name= '${place.street}, ${place.locality}, ${place.country}';
    }
    return name;
  }

  String getDifference(String startTime, String endTime) {
    DateTime now = DateTime.now();

    // Convert start and end time to DateTime objects
    DateTime? start = convertTo24Hour(startTime);
    DateTime? end = convertTo24Hour(endTime);

    // Check for null values
    if (start == null || end == null) {
      return "Invalid time format!";
    }

    // Assign current date to the times
    start = DateTime(now.year, now.month, now.day, start.hour, start.minute);
    end = DateTime(now.year, now.month, now.day, end.hour, end.minute);

    // Calculate the difference
    Duration difference = end.difference(start);

    // Format the difference
    String hours = difference.inHours.toString();
    String minutes = (difference.inMinutes % 60).toString();

    return "$hours hours and $minutes minutes";
  }

  DateTime? convertTo24Hour(String time) {
    final format = RegExp(r'(\d+):(\d+)\s*(AM|PM)');
    final match = format.firstMatch(time);

    if (match != null) {
      int hour = int.parse(match.group(1)!);
      int minute = int.parse(match.group(2)!);
      String period = match.group(3)!;

      if (period == "PM" && hour != 12) {
        hour += 12; // Convert PM to 24-hour format
      }
      if (period == "AM" && hour == 12) hour = 0; // Midnight case for AM

      return DateTime(0, 0, 0, hour, minute); // Return DateTime object
    }
    return null;
  }


  Widget _buildEmptyChatState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.chat_bubble_outline,
            size: 100.0,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16.0),
          Text(
            'No messages yet',
            style: TextStyle(fontSize: 20.0, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget buildIconContainer(String assetPath, Color color) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: color,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26.5.sp, vertical: 14.sp),
        child: SvgPicture.asset(
          assetPath,
          height: 4.h,
          width: 4.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget buildIconContainer2(String assetPath, Color color,int count) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: 3.h,
        width: 10.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Row(
            children: [
              Expanded(
                child: SvgPicture.asset(
                  assetPath,
                  height:15,
                  width: 15,
                ),
              ),
              if(count>0)
              Text(count.toString(),style: TextStyle(color: Colors.white),),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String profileImageUrl;
  final String userName;
  final String type;
  final int? groupId;
  final bool isOnline;

  const ChatAppBar({
    super.key,
    this.groupId,
    required this.profileImageUrl,
    required this.userName,
    required this.isOnline,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(Get.width * .20),
      child: AppBar(
        backgroundColor: ColoRRes.backGroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.sp),
              child:
              CachedNetworkImage(
                imageUrl: profileImageUrl,
                fit: BoxFit.cover,
                width: 12.w,
                height: 5.h,
                placeholder: (context, url) => Center(
                  child: SizedBox(
                    width: 12.w,
                    height: 5.h,
                    child: Icon(
                      Icons.image,
                      size: 24, // Adjust icon size as needed
                      color: Colors.grey, // Customize icon color
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: ColoRRes.borderColor),
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                  child: Image.asset(
                    "assets/images/noImage.jpg",
                    fit: BoxFit.fill,
                    width: 10.w,
                    height: 5.h,
                  ),
                ),
              ),
            ),
            SizedBox(width: 4.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 2.5.h,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: AppTexts.inter15W600(
                    userName,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                AppTexts.inter14W400(
                  isOnline ? "Online" : "Offline",
                  textColor: isOnline ? Colors.green : ColoRRes.onlineColor,
                  fontSize: 10,
                ),
              ],
            ),
          ],
        ),
        actions: [
          if(type!='single')
          Container(
            decoration: BoxDecoration(
              color: ColoRRes.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: (){
                Get.to(()=> OpenProfile(groupId:groupId!));
              },
              child: Padding(
                padding: EdgeInsets.all(10.sp),
                child: const Icon(
                  Icons.more_vert_rounded,
                  color: ColoRRes.textColor,
                  size: 25,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}
class JoinPlanContainer extends StatelessWidget {
  const JoinPlanContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 60.w,
            decoration: const BoxDecoration(
              color: ColoRRes.textColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14),
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(15.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppTexts.inter16W400(
                        'Pandya Made a Plan',
                        textColor: ColoRRes.white,
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      Container(
                        width: double.infinity,
                        height: 0.5,
                        color: ColoRRes.white.withOpacity(0.7),
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Start location : ',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                color: ColoRRes.white.withOpacity(0.5),
                                fontSize: 10,
                              ),
                            ),
                            const TextSpan(
                              text: 'New Delhi, India',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                color: ColoRRes.white,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Time :',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                color: ColoRRes.white.withOpacity(0.5),
                                fontSize: 10,
                              ),
                            ),
                            const TextSpan(
                              text: ' 5 hour',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                color: ColoRRes.white,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 1.5.h,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Activity :',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                color: ColoRRes.white.withOpacity(0.5),
                                fontSize: 10,
                              ),
                            ),
                            const TextSpan(
                              text: '5',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                color: ColoRRes.white,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16.sp),
                        decoration: const BoxDecoration(
                          color: ColoRRes.primary,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: const Center(
                          child: AppTexts.inter14W500(
                            'Join Plan',
                            textColor: ColoRRes.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16.sp),
                        decoration: const BoxDecoration(
                          color: ColoRRes.chatStarColor,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: const Center(
                          child: AppTexts.inter14W500(
                            'Leave',
                            textColor: ColoRRes.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 1.2.h,
          ),
          const AppTexts.inter10W500('3:16 Pm')
        ],
      );
  }
}