import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_out/controller/base_controller.dart';
import 'package:get_out/screens/chat/join_plan_detail/pages/add_from_library.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common_screens/app_text.dart';
import '../../../../common_screens/colors.dart';
import '../../../../controller/itninerary_controller.dart';
import '../../../../custom_app_screen/custom_rating_card.dart';
import '../../../../modal/swipe_card_response.dart';
import '../../../home/home_main/company.dart';

class SelectYouPlan extends StatefulWidget {
  final String page;
  const SelectYouPlan({super.key,required this.page});

  @override
  State<SelectYouPlan> createState() => _SelectYouPlanState();
}

class _SelectYouPlanState extends State<SelectYouPlan> {
  ItineraryController controller=Get.find<ItineraryController>();

  @override
  void initState() {
    // TODO: implement initState
    if(widget.page=='home') {
      controller.getEventsAPI("refresh");
      controller.getThemeEventsAPI();
    }else{
      controller.getEventsAPI("refresh");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 3.h),
          const AppTexts.inter24W600(
            'Select your Plan',
            textColor: ColoRRes.textColor,
          ),
          SizedBox(height: 1.h),
          const AppTexts.inter14W400(
            'Please enter your name to request a \nprofile creation',
            textColor: ColoRRes.subTextColor,
          ),
          SizedBox(height: 3.h),
          Visibility(
            visible: widget.page=='home',
            replacement: SizedBox(
              height: 18.h,
              child:Obx(() {
                if (controller.cards.isEmpty) {
                  if (controller.loading.value) {
                    return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: CircularProgressIndicator(),
                        ));
                  } else if (controller.error.value) {
                    return const Center(
                        child: Text("Error in fetching list")
                    );
                  } else {
                    return const Center(
                        child: Text("No data found")
                    );
                  }
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.cards.length,
                  itemBuilder: (context, index) {
                    if (!controller.isLastPage.value && index == controller.cards.length - controller.nextPageTrigger.value) {
                      controller.getEventsAPI("load");
                    }
                    if (index == controller.cards.length) {
                      if (controller.error.value) {
                        return const Center(
                            child: Text("Error in fetching list")
                        );
                      } else {
                        return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: CircularProgressIndicator(),
                            ));
                      }
                    }
                    return Padding(
                        padding: EdgeInsets.only(right: 2.5.w),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.sp),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      Get.to(()=>Company(id:controller.cards[index].placeId!));
                                    },
                                    child:
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16.sp),
                                      child: CachedNetworkImage(
                                        imageUrl: controller.cards[index].photo ?? '',
                                        height: 18.h,
                                        width: 36.w,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                          child: SizedBox(
                                              height: 18.h,
                                              width: 36.w,
                                              child: Icon(Icons.image,size: 25,)),
                                        ),
                                        errorWidget: (context, url, error) => Image.asset(
                                          "assets/images/noImage.jpg",
                                          fit: BoxFit.fill,
                                          height: 18.h,
                                          width: 36.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10.sp,
                                    right: 10.sp,
                                    bottom: 10.sp,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap :(){
                                            if (controller.selectedEvents.contains(controller.cards[index])) {
                                              controller.selectedEvents.remove(controller.cards[index]);
                                            } else {
                                              controller.selectedEvents.add(controller.cards[index]);
                                            }
                                          },
                                          child:Obx(()=> buildIconContainer(
                                              controller.selectedEvents.contains(controller.cards[index])?'assets/home/close.svg':'assets/home/add.svg',
                                              ColoRRes.primary,false
                                          )),
                                        ),
                                        SizedBox(width: 2.w,),
                                        GestureDetector(
                                          onTap :(){
                                            if(controller.cards[index].isFav==1){
                                              controller.cards[index].isFav=0;
                                            }else{
                                              controller.cards[index].isFav=1;
                                            }
                                            controller.cards.refresh();
                                            Get.find<BaseController>().handleEvents(controller.cards[index].placeId!,"fav");
                                          },
                                          child: buildIconContainer(
                                              'assets/home/like.svg',
                                              ColoRRes.chatStarColor,controller.cards[index].isFav==1
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                    );
                  },
                );
              }),
            ),
            child: SizedBox(
              height: 18.h,
              child:Obx(() {
                if (controller.themeCard.isEmpty) {
                  return const Center(
                      child: Text("No data found")
                  );
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.themeCard.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.only(right: 2.5.w),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.sp),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      Get.to(()=>Company(id:controller.themeCard[index].placeId!));
                                    },
                                    child:ClipRRect(
                                      borderRadius: BorderRadius.circular(16.sp),
                                      child: CachedNetworkImage(
                                        imageUrl: controller.themeCard[index].photo ?? '',
                                        height: 18.h,
                                        width: 36.w,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => const Center(
                                          child: Icon(Icons.image,size: 25,),
                                        ),
                                        errorWidget: (context, url, error) {
                                          return Image.asset(
                                            "assets/images/noImage.jpg",
                                            fit: BoxFit.fill,
                                            height: 18.h,
                                            width: 36.w,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10.sp,
                                    right: 10.sp,
                                    bottom: 10.sp,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap :(){
                                            if (controller.selectedEvents.contains(controller.themeCard[index])) {
                                              controller.selectedEvents.remove(controller.themeCard[index]);
                                            } else {
                                              controller.selectedEvents.add(controller.themeCard[index]);
                                            }
                                          },
                                          child:Obx(()=> buildIconContainer(
                                              controller.selectedEvents.contains(controller.themeCard[index])?'assets/home/close.svg':'assets/home/add.svg',
                                              ColoRRes.primary,false
                                          )),
                                        ),
                                        SizedBox(width: 2.w,),
                                        GestureDetector(
                                          onTap :(){
                                            if(controller.themeCard[index].isFav==1){
                                              controller.themeCard[index].isFav=0;
                                            }else{
                                              controller.themeCard[index].isFav=1;
                                            }
                                            controller.themeCard.refresh();
                                            Get.find<BaseController>().handleEvents(controller.themeCard[index].placeId!,"fav");
                                          },
                                          child: buildIconContainer(
                                              'assets/home/like.svg',
                                              ColoRRes.chatStarColor,controller.themeCard[index].isFav==1
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                    );
                  },
                );
              }),
            ),
          ),
          SizedBox(height: 2.5.h),
          SizedBox(
            width: double.infinity,
            height: 7.h,
            child: ElevatedButton(
              onPressed: () async {
                List<Cards> ? result= await Get.to(()=>const AddFromLibrary());
                if(result!=null && result.isNotEmpty){
                  controller.selectedEvents.addAll(result);
                }
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: ColoRRes.chatStarColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const AppTexts.inter18W500(
                'Add from Library',
              ),
            ),
          ),
          SizedBox(height: 2.5.h),
          if(widget.page=='home')...[
            const AppTexts.inter24W600(
              'You may also like',
              textColor: ColoRRes.textColor,
            ),
            SizedBox(height: 2.5.h),
            SizedBox(
              height: 18.h,
              child:Obx(() {
                if (controller.cards.isEmpty) {
                  if (controller.loading.value) {
                    return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: CircularProgressIndicator(),
                        ));
                  } else if (controller.error.value) {
                    return const Center(
                        child: Text("Error in fetching list")
                    );
                  } else {
                    return const Center(
                        child: Text("No data found")
                    );
                  }
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.cards.length,
                  itemBuilder: (context, index) {
                    if (!controller.isLastPage.value && index == controller.cards.length - controller.nextPageTrigger.value) {
                      controller.getEventsAPI("load");
                    }
                    if (index == controller.cards.length) {
                      if (controller.error.value) {
                        return const Center(
                            child: Text("Error in fetching list")
                        );
                      } else {
                        return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: CircularProgressIndicator(),
                            ));
                      }
                    }
                    return Padding(
                        padding: EdgeInsets.only(right: 2.5.w),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.sp),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  GestureDetector(
                                    onTap:(){
                                      Get.to(()=>Company(id:controller.cards[index].placeId!));
                                    },
                                    child:
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16.sp),
                                      child: CachedNetworkImage(
                                        imageUrl: controller.cards[index].photo ?? '',
                                        height: 18.h,
                                        width: 36.w,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                          child: SizedBox(
                                              height: 18.h,
                                              width: 36.w,
                                              child: Icon(Icons.image,size: 25,)),
                                        ),
                                        errorWidget: (context, url, error) => Image.asset(
                                          "assets/images/noImage.jpg",
                                          fit: BoxFit.fill,
                                          height: 18.h,
                                          width: 36.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10.sp,
                                    right: 10.sp,
                                    bottom: 10.sp,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap :(){
                                            if (controller.selectedEvents.contains(controller.cards[index])) {
                                              controller.selectedEvents.remove(controller.cards[index]);
                                            } else {
                                              controller.selectedEvents.add(controller.cards[index]);
                                            }
                                          },
                                          child:Obx(()=> buildIconContainer(
                                              controller.selectedEvents.contains(controller.cards[index])?'assets/home/close.svg':'assets/home/add.svg',
                                              ColoRRes.primary,false
                                          )),
                                        ),
                                        SizedBox(width: 2.w,),
                                        GestureDetector(
                                          onTap :(){
                                            if(controller.cards[index].isFav==1){
                                              controller.cards[index].isFav=0;
                                            }else{
                                              controller.cards[index].isFav=1;
                                            }
                                            controller.cards.refresh();
                                            Get.find<BaseController>().handleEvents(controller.cards[index].placeId!,"fav");
                                          },
                                          child: buildIconContainer(
                                              'assets/home/like.svg',
                                              ColoRRes.chatStarColor,controller.cards[index].isFav==1
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                    );
                  },
                );
              }),
            ),
          ]
        ],
      ),
    );
  }
  Widget buildIconContainer(String assetPath, Color color,bool isFav) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
          border: Border.all(width: 1, color: ColoRRes.white)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.5.sp, vertical: 10.sp),
        child: SvgPicture.asset(
          assetPath,
          color: isFav?Colors.red[900]:ColoRRes.white,
          height: 2.h,
          width: 2.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}