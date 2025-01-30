import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_out/controller/chat_controller.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common_screens/app_text.dart';
import '../../common_screens/colors.dart';
import '../../custom_app_screen/custom_appbar_container.dart';
import '../../custom_app_screen/custom_group_card.dart';

class OpenProfile extends StatefulWidget {
  final int groupId;
  const OpenProfile({super.key,required this.groupId});

  @override
  State<OpenProfile> createState() => _OpenProfileState();
}

class _OpenProfileState extends State<OpenProfile> {
  ChatController controller=Get.find<ChatController>();
  List<String> groupFirst = [
    "Savannah Nguyen",
    "Savannah Nguyen",
    "Savannah Nguyen",
    "Savannah Nguyen",
  ];
  List<String> groupSecond = [
    '9233838923',
    '9233838923',
    '9233838923',
    '9233838923'
  ];

  Set<int> selectedIndices = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getGroupInfo(widget.groupId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoRRes.white,
      appBar: AppBar(
        backgroundColor: ColoRRes.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Padding(
              padding: EdgeInsets.only(left: 15.sp, top: 12.5.sp, bottom: 8.sp),
              child: const CustomChatContainer(
                assetPath: 'assets/chat/back.svg',
              )),
        ),
        title: Container(
          //alignment: Alignment.,
          child: const AppTexts.inter16W600(
            'Group info',
          ),
        ),
        //centerTitle: true,
        // actions: [
        //   Padding(
        //       padding: EdgeInsets.only(
        //         right: 15.sp,
        //         top: 14.sp,
        //       ),
        //       child: const CustomChatContainer(
        //         assetPath: 'assets/chat/share.svg',
        //       )),
        // ],
      ),
      body:Obx(()=>controller.isGroupLoad.value?SizedBox():SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 4.h),
            Center(
              child:
              ClipRRect(
                borderRadius: BorderRadius.circular(18.sp),
                child:CachedNetworkImage(
                  imageUrl: controller.groupInfo.value.groupImage??'',
                  height: 12.h,
                  width: 26.w,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: SizedBox(
                      height: 12.h,
                      width: 26.w,
                      child: const Icon(
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
                      height: 12.h,
                      width: 26.w,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h),
             Text(
              controller.groupInfo.value.groupName??'',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 28,
                color: ColoRRes.black,
              ),
            ),
            SizedBox(height: 1.h),
             AppTexts.inter18W500(
              '${controller.groupInfo.value.groupMembers?.length} members',
              textColor: ColoRRes.profileTextColor,
            ),
            SizedBox(height: 4.h),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColoRRes.backGroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.sp),
                  topRight: Radius.circular(25.sp),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 25.sp),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AppTexts.inter20W500('Activity'),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: ColoRRes.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.sp),
                                child: const Icon(Icons.arrow_back_rounded,
                                    color: ColoRRes.textColor, size: 22),
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Container(
                              decoration: BoxDecoration(
                                color: ColoRRes.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.sp),
                                child: const Icon(Icons.arrow_forward_rounded,
                                    color: ColoRRes.textColor, size: 22),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return const ActivityCard();
                        },
                      ),
                    ),
                    const Row(
                      children: [
                        AppTexts.inter20W500('Group Members'),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    color: ColoRRes.inColor,
                                    borderRadius: BorderRadius.circular(12.sp),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(13.sp),
                                    child: SvgPicture.asset(
                                        'assets/chat/groupUser.svg'),
                                  )),
                              SizedBox(width: 4.w), // Adjust as needed
                              const AppTexts.inter18W600(
                                'Add Member',
                                textColor: ColoRRes.cardTextColor,
                              ),
                            ],
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                color: ColoRRes.indicatorColor,
                                shape: BoxShape.circle),
                            child: Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: const Icon(
                                Icons.add_rounded,
                                color: ColoRRes.white,
                                size: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.5.h),
                    ListView.builder(
                      itemCount: controller.groupInfo.value.groupMembers?.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.sp),
                          child: CustomGroupCard(
                            imagePath:controller.groupInfo.value.groupMembers?[index].userDetails?.profile??'assets/images/user.png',
                            title: controller.groupInfo.value.groupMembers?[index].userDetails?.name??'N/A',
                            subtitle: controller.groupInfo.value.groupMembers?[index].userDetails?.mobile??'N/A',
                            id: controller.groupInfo.value.groupMembers?[index].userDetails?.id??0,
                            onTap: () {
                                 controller.groupLeft(widget.groupId);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class ActivityCard extends StatelessWidget {
  const ActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.sp, top: 20.sp),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14.sp),
                child: Image.asset(
                  'assets/chat/addUser.png',
                  height: 20.h,
                  width: 28.w,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
                decoration:  BoxDecoration(
                    color: ColoRRes.white,
                  borderRadius: BorderRadius.circular(10.sp)
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: Center(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/chat/distance.svg',
                          height: 1.5.h,
                          width: 1.5.w,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 1.w,),
                        const AppTexts.inter14W500(
                          '1 km Distance',
                          fontSize: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 10.sp,
                bottom: 10.sp,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 44.sp,
                      child: const AppTexts.poppins12W500(
                        'Amherst Coffee Shop ',
                        textColor: ColoRRes.white,
                      ),
                    ),
                    SizedBox(
                      width: 44.sp,
                      child: const AppTexts.poppins8W300(
                        'Jatin Prajapaty | Owner',
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
