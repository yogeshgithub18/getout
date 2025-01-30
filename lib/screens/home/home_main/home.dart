import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_out/common_screens/colors.dart';
import 'package:get_out/controller/base_controller.dart';
import 'package:get_out/controller/home_controller.dart';
import 'package:get_out/modal/swipe_card_response.dart';
import 'package:get_out/screens/home/home_main/notification.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:video_player/video_player.dart';
import '../../../common_screens/app_text.dart';
import '../../../controller/chat_controller.dart';
import '../../../main.dart';
import '../../chat/direct_message.dart';
import '../../chat/join_plan_detail/join_plan_detail.dart';
import '../../chat/user_chating.dart';
import 'company.dart';
import 'home_map_screen.dart';
import 'home_search.dart';
import 'package:flutter/services.dart';
class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  BaseController baseController = Get.find<BaseController>();
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    if (controller.cards.isEmpty) {
      controller.isLoading.value = true;
      controller.jobTrigger();
      _loadInitialCards();
    }
    controller.searchKeywordController.value.text = '';
    controller.selectedInterests.value = [];
    controller.getCategory();
    Future.delayed(const Duration(seconds:1),(){
    controller.getGroup();
    });
  }

  bool isSearchVisible = false;

  void _loadInitialCards() {
    Future.delayed(const Duration(milliseconds: 3000), () async {
      controller.lat = baseController.user.value.lattitute ?? '';
      controller.lng = baseController.user.value.longitute ?? '';
      controller.cards.value = [];
      controller.swipeItems.value = [];
      controller.isLoading.value = true;
      await controller.getEvents("refresh");
      _addItemsToSwipeList(controller.cards);
    });
  }

  void loadMoreCards() async {
    print("load more callled");
    if (controller.isLastPage.value || controller.cards.isEmpty) return;
    controller.isLoading.value = true;
    await controller.getEvents("load");
    _addItemsToSwipeList(controller.cards);
    controller.isLoading.value = false;
  }

  void _addItemsToSwipeList(List<Cards> items) {
    for (var item in items) {
      controller.swipeItems.add(SwipeItem(
          content: item,
          likeAction: () => swipeRight(),

          ///controller.handleEvents("fav", item.placeId!),
          nopeAction: () => swipeLeft(),

          /// controller.handleEvents("star", item.placeId!),
          superlikeAction: () => swipeUp()

          ///controller.handleEvents("not-apear", item.placeId!),
          ));
    }
    controller.matchEngine.value =
        MatchEngine(swipeItems: controller.swipeItems);
  }

  void swipeLeft() {
    controller.matchEngine.value.currentItem?.nope();
  }

  void swipeUp() {
    controller.matchEngine.value.currentItem?.superLike();
  }

  void swipeRight() {
    controller.matchEngine.value.currentItem?.like();
  }

  void toggleSearch() {
    if (isSearchVisible) {
      Navigator.of(context).pop();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            alignment: Alignment.topCenter,
            child: Container(
              height: 6.h,
              decoration: BoxDecoration(
                color: ColoRRes.backGroundColor,
                borderRadius: BorderRadius.circular(35.sp),
              ),
              child: TextField(
                autofocus: true,
                controller: searchLocationController,
                cursorColor: ColoRRes.black,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 16.sp, right: 16.sp),
                    child: SvgPicture.asset('assets/images/search.svg'),
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 10.sp),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const HomeSearch());
                      },
                      child: Container(
                        padding: EdgeInsets.all(14.sp),
                        decoration: const BoxDecoration(
                          color: ColoRRes.primary,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          'assets/chat/searchSetting.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    color: ColoRRes.textSubColor,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 19.sp, horizontal: 15.sp),
                ),
              ),
            ),
          );
        },
      ).then((_) {
        setState(() {
          isSearchVisible = false;
        });
      });
      setState(() {
        isSearchVisible = true;
      });
    }
  }

  TextEditingController searchLocationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColoRRes.white,
        resizeToAvoidBottomInset: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 4.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 18.sp, right: 18.sp, top: 18.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/splash.svg',
                    color: ColoRRes.textColor,
                    height: 44,
                    fit: BoxFit.fill,
                  ),
                  homeAppBar('assets/images/search.svg',
                      'assets/home/search.svg', 'assets/home/notification.svg'),
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Obx(() => Expanded(
                  child: controller.isLoading.value
                      ? Center(
                          child: Image.asset(
                          'assets/images/loader.gif',
                          height: 100,
                          width: 100,
                        ))
                      : controller.cards.isEmpty
                          ? const Center(child: Text("No data found"))
                          : SwipeCards(
                              matchEngine: controller.matchEngine.value,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12.sp),
                                  child: Stack(
                                      alignment: Alignment.topLeft,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(() => Company(id: controller.swipeItems[index].content.placeId!));
                                          },
                                          child: Visibility(
                                            visible:(controller.swipeItems[index].content.isVerify ?? 0)!=0 && controller.swipeItems[index].content.fileType=='video',
                                            replacement:
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(12.sp),
                                              child: CachedNetworkImage(
                                                imageUrl: controller.swipeItems[index].content.photo,
                                                fit: BoxFit.cover,
                                                width: 100.w,
                                                height: 100.h,
                                                placeholder: (context, url) => const Center(
                                                  child: Icon(Icons.image,size: 30,),
                                                ),
                                                errorWidget: (context, url, error) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: ColoRRes.borderColor),
                                                      borderRadius: BorderRadius.circular(8.sp),
                                                    ),
                                                    child: Image.asset(
                                                      "assets/images/noImage.jpg",
                                                      fit: BoxFit.fill,
                                                      width: 100.w,
                                                      height: 100.h,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            child: VideoWidget(videoUrl:controller.swipeItems[index].content.photo),
                                          ),
                                        ),
                                        IntrinsicWidth(
                                          child: Container(
                                            height: 4.h,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10.sp,
                                                vertical: 15.sp),
                                            decoration: BoxDecoration(
                                              color: ColoRRes.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10.sp),
                                              child: Center(
                                                child: Row(
                                                  mainAxisSize: MainAxisSize
                                                      .min, // Ensures row takes only necessary width
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/chat/distance.svg',
                                                      height: 2.h,
                                                      width: 2.w,
                                                      color: ColoRRes.primary,
                                                      fit: BoxFit.contain,
                                                    ),
                                                    SizedBox(
                                                      width: 1.w,
                                                    ),
                                                    AppTexts.inter14W500(
                                                      '${controller.swipeItems[index].content.distanceMiles.toStringAsFixed(2)} miles Distance',
                                                      fontSize: 12,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 15.sp,
                                          bottom: 10.sp,
                                          right: 0,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            width: 50.sp,
                                                            child: AppTexts
                                                                .poppins18W500(
                                                              controller
                                                                  .swipeItems[
                                                                      index]
                                                                  .content
                                                                  .name,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          (controller.swipeItems[
                                                                              index]
                                                                          .content
                                                                          .isVerify ??
                                                                      0) !=
                                                                  0
                                                              ? SvgPicture.asset(
                                                                  'assets/home/verify.svg')
                                                              :const SizedBox(),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 60.sp,
                                                        child: AppTexts
                                                            .poppins8W300(
                                                          controller
                                                              .swipeItems[index]
                                                              .content
                                                              .vicinity,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 11,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            right: 15.sp,
                                                            top: 14.sp,
                                                          ),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              Get.to(() =>
                                                                  JoinPlanDetail(
                                                                    page:'home',
                                                                    from: 'normal',
                                                                    type: controller.swipeItems[index].content.fetchCategory,
                                                                    placeId: controller
                                                                        .swipeItems[
                                                                            index]
                                                                        .content
                                                                        .placeId,
                                                                  ));
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: ColoRRes
                                                                      .primary,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  border: Border.all(
                                                                      width:
                                                                          0.5,
                                                                      color: ColoRRes
                                                                          .white)),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(14
                                                                            .sp),
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  'assets/chat/flotEdit.svg',
                                                                  height: 3.h,
                                                                  width: 3.h,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              ),
                                                            ),
                                                          )),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            right: 15.sp,
                                                            top: 14.sp,
                                                          ),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              showDualListBottomSheet(context,controller
                                                                  .swipeItems[index]
                                                                  .content
                                                                  .placeId);
                                                              // Share.share(
                                                              //     'Check out this amazing app: https://yourapp.link');
                                                              //
                                                              },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: ColoRRes
                                                                      .primary,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  border: Border.all(
                                                                      width:
                                                                          0.5,
                                                                      color: ColoRRes
                                                                          .white)),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(14
                                                                            .sp),
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  'assets/home/share.svg',
                                                                  height: 3.h,
                                                                  width: 3.h,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              ),
                                                            ),
                                                          ))
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 15.sp,
                                                    bottom: 12.sp,
                                                    top: 20.sp),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        swipeUp();
                                                        controller.handleEvents(
                                                            "not-apear",
                                                            controller
                                                                .swipeItems[
                                                                    index]
                                                                .content
                                                                .placeId!);
                                                      },
                                                      child: buildIconContainer2(
                                                          'assets/home/close.svg',
                                                          ColoRRes.white,
                                                          false),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        swipeRight();
                                                        //  if(controller.swipeItems[index].content.isStar==1){
                                                        //    controller.swipeItems[index].content.isStar=0;
                                                        //  }else{
                                                        //    controller.swipeItems[index].content.isStar=1;
                                                        //  }
                                                        //  setState(() {
                                                        //
                                                        //  });
                                                        controller.handleEvents(
                                                            "star",
                                                            controller
                                                                .swipeItems[
                                                                    index]
                                                                .content
                                                                .placeId!);
                                                      },
                                                      child: buildIconContainer(
                                                          'assets/chat/chatStar.svg',
                                                          ColoRRes.textColor,
                                                          controller
                                                                  .swipeItems[
                                                                      index]
                                                                  .content
                                                                  .isStar ==
                                                              1),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        // if(controller.swipeItems[index].content.isFav==1){
                                                        //   controller.swipeItems[index].content.isFav=0;
                                                        // }else{
                                                        //   controller.swipeItems[index].content.isFav=1;
                                                        // }
                                                        // setState(() {
                                                        //
                                                        // });
                                                        controller.handleEvents(
                                                            "fav",
                                                            controller
                                                                .swipeItems[
                                                                    index]
                                                                .content
                                                                .placeId!);
                                                        swipeRight();
                                                      },
                                                      child: buildIconContainer(
                                                          'assets/home/like.svg',
                                                          ColoRRes
                                                              .indicatorColor,
                                                          controller
                                                                  .swipeItems[
                                                                      index]
                                                                  .content
                                                                  .isFav ==
                                                              1),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                );
                              },
                              onStackFinished: () async {
                                controller.cards.value = [];
                                controller.swipeItems.value = [];
                                controller.isLoading.value = true;
                                controller.radius.value = "0";
                                controller.jobTrigger();
                                await controller.getEvents("refresh");
                                controller.isLoading.value = false;
                                _addItemsToSwipeList(controller.cards);
                              },
                              itemChanged: (SwipeItem item, int index) {
                                controller.currentIndex.value = index;
                                if (!controller.isLastPage.value &&
                                    index == controller.swipeItems.length - 3) {
                                  loadMoreCards();
                                } else if (index ==
                                    controller.swipeItems.length - 1) {
                                  // Expand the search radius or other fallback
                                  // controller.radius.value = (int.parse(controller.radius.value) + 1000).toString();
                                  _loadInitialCards();
                                }
                              },
                              leftSwipeAllowed: true,
                              rightSwipeAllowed: true,
                              upSwipeAllowed: true,
                              fillSpace: true,
                            ),
                )
            ),
          ],
        ));
  }

  Widget buildIconContainer(String assetPath, Color color, bool isFav) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color,
          border: Border.all(width: 1.5, color: ColoRRes.white)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26.sp, vertical: 14.sp),
        child: SvgPicture.asset(
          assetPath,
          color: isFav ? Colors.red : ColoRRes.white,
          height: 3.h,
          width: 3.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget buildIconContainer2(String assetPath, Color color, bool isFav) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color,
          border: Border.all(width: 1.5, color: ColoRRes.white)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26.sp, vertical: 14.sp),
        child: SvgPicture.asset(
          assetPath,
          color: ColoRRes.black,
          height: 3.h,
          width: 3.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget homeAppBar(String image1, image2, image3) {
    return Row(
      children: [
        GestureDetector(
          //onTap:toggleSearch,
          onTap: () async {
            bool? result = await Get.to(() => const HomeSearch());
            if (result ?? false) {
              controller.cards.value = [];
              controller.swipeItems.value = [];
              controller.radius.value = controller.rangeSliderValue.value;
              controller.isLoading.value = true;
              controller.jobTrigger();
              Future.delayed(const Duration(seconds: 3), () async {
                await controller.getEvents("refresh");
                controller.isLoading.value = false;
                _addItemsToSwipeList(controller.cards);
              });
            }
          },
          child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColoRRes.backGroundColor,
              ),
              child: Padding(
                padding: EdgeInsets.all(14.sp),
                child: SvgPicture.asset(
                  image1,
                  height: 2.h,
                  width: 2.w,
                  fit: BoxFit.contain,
                ),
              )),
        ),
        SizedBox(
          width: 4.w,
        ),
        GestureDetector(
          onTap: () async {
            bool? result = await Get.to(() => const HomeMapScreen());
            if (result ?? false) {
              controller.cards.value = [];
              controller.swipeItems.value = [];
              controller.isLoading.value = true;
              controller.jobTrigger();
              Future.delayed(const Duration(seconds: 3), () async {
                await controller.getEvents("refresh");
                controller.isLoading.value = false;
                _addItemsToSwipeList(controller.cards);
              });
            }
          },
          child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: ColoRRes.backGroundColor),
              child: Padding(
                padding: EdgeInsets.all(14.sp),
                child: SvgPicture.asset(
                  image2,
                  height: 2.h,
                  width: 2.w,
                  fit: BoxFit.contain,
                ),
              )),
        ),
        SizedBox(
          width: 4.w,
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => const NotificationScreen());
          },
          child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: ColoRRes.backGroundColor),
              child: Padding(
                padding: EdgeInsets.all(14.sp),
                child: SvgPicture.asset(
                  image3,
                  height: 2.h,
                  width: 2.w,
                  fit: BoxFit.contain,
                ),
              )),
        ),
      ],
    );
  }

  void showDualListBottomSheet(BuildContext context,String placid) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
             Obx(()=> _buildHorizontalUserList(placid)),
              Divider(),
              // Second List for Social Icons
              SizedBox(height: 10),
              _buildFixedSocialIconList(placid),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // Horizontal List for Users
  Widget _buildHorizontalUserList(String placId) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: controller.groupList.map((user) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: (){
                Get.back();
                Get.put(ChatController());
                Future.delayed(const Duration(seconds:1),(){
                  Get.to(()=>UserChating(placeId:placId,chatType:"group",userName:user.group?.groupName??"",receiveId:user.group!.id.toString(),profileImage:user.group?.groupImage??"",roomId: user.id.toString(),));
                });
              },
              child: Column(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: user.group?.groupImage ?? '',
                      fit: BoxFit.cover,
                      width: 14.w,
                      height: 7.h,
                      placeholder: (context, url) => Center(
                        child: Icon(Icons.image,size: 25,),
                      ),
                      errorWidget: (context, url, error) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: ColoRRes.borderColor),
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: Image.asset(
                            "assets/images/noImage.jpg",
                            fit: BoxFit.fill,
                            width: 14.w,
                            height: 7.h,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    user.groupName??'',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Fixed List for Social Icons
  Widget _buildFixedSocialIconList(String placId) {
    final socialIcons = [
      {"icon": "assets/home/chain.svg", "label": "Email", "color":  Color(0XFF121212)},
      {"icon": "assets/home/fb.svg", "label": "Facebook", "color": Color(0XFF0062E0)},
      {"icon": "assets/home/whatsapp.svg", "label": "WhatsApp", "color": Color(0XFF00D95F)},
      {"icon": "assets/home/insta.svg", "label": "Email", "color":Color(0XFFFF0000)},
      {"icon": "assets/home/telegram.svg", "label": "Telegram", "color":Color(0XFF0088CC)},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: socialIcons.map((social) {
        return Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor:social['color'] as Color,
              child: SvgPicture.asset(
                social["icon"].toString(),
               // color:social['color'] as Color,
                height: 30,
                width: 30,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

class VideoWidget extends StatefulWidget {
  final String videoUrl;

  const VideoWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> with RouteAware {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!); // Subscribe to route changes
  }

  @override
  void initState() {
    super.initState();
    print("urll===--${widget.videoUrl}");
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl),)
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
        _controller.play();
        //_setFullScreenMode();
      });
  }
  void _setFullScreenMode() {
    // Set preferred device orientation to portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Hide status and navigation bars
   // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  void _exitFullScreenMode() {
    // Reset preferred device orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // Show status and navigation bars
   // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  @override
  void dispose() {
    _exitFullScreenMode();
    routeObserver.unsubscribe(this); /// Reset full-screen settings when the widget is disposed
    _controller.dispose();
    super.dispose();
  }


  // Called when the route is pushed onto the navigation stack
  @override
  void didPush() {
    super.didPush();
    _controller.play(); // Start video playback when this screen is pushed
  }

  // Called when the current route is popped off the navigation stack
  @override
  void didPop() {
    super.didPop();
    _controller.pause(); // Pause the video when the screen is popped
  }

  // Called when the top route changes but this route remains in the stack
  @override
  void didPopNext() {
    super.didPopNext();
    _controller.play(); // Resume video playback when coming back to this screen
  }

  // Called when this route is covered by another route
  @override
  void didPushNext() {
    super.didPushNext();
    _controller.pause(); // Pause video playback when navigating to another screen
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    if (!_isInitialized) {
      return Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey)
          ), child:  Center(child: Image.asset(
        'assets/images/loader.gif', // Replace with your GIF file path
        height: 100, // Adjust size as needed
        width: 100,
      ),));
    }
    return Container(
      width: 100.w,
      height: 100.h,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
             border: Border.all(color: Colors.grey)
          ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FittedBox(
          fit: BoxFit.cover, // Forces the video to cover the area
          child: SizedBox(
            width: _controller.value.size.width,
            height: _controller.value.size.height-kToolbarHeight,
            child: VideoPlayer(_controller),
          ),
        ),
      ),
    );
    // return Container(
    //     height: 100.h,
    //   decoration: BoxDecoration(
    //       color: Colors.white,
    //      borderRadius: BorderRadius.circular(12.sp),
    //     border: Border.all(color: Colors.grey)
    //     ),
    //   child: Center(
    //     child: AspectRatio(
    //       aspectRatio: _controller.value.aspectRatio,
    //       child: VideoPlayer(_controller),
    //     ),
    //   ),
    // );
  }
}