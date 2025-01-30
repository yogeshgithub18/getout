import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_out/controller/base_controller.dart';
import 'package:get_out/modal/my_friend_response.dart';
import 'package:get_out/screens/chat/user_chating.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common_screens/app_text.dart';
import '../../common_screens/colors.dart';
import '../../controller/chat_controller.dart';
import '../../custom_app_screen/custom_card_second.dart';
import '../../custom_app_screen/cutom_card.dart';
import '../../modal/chat_thread_list_model.dart';
import 'open_profile.dart';
import 'package:get/get.dart';
class DirectMessage extends StatefulWidget {
  const DirectMessage({super.key});

  @override
  State<DirectMessage> createState() => _DirectMessageState();
}

class _DirectMessageState extends State<DirectMessage> {
  ChatController controller=Get.find<ChatController>();
  BaseController baseController=Get.find<BaseController>();

  @override
  void initState() {
    // TODO: implement initState
    controller.getFriend();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppTexts.inter12W600('All Friend'),
            SizedBox(height: 1.5.h),
            SizedBox(
              height: 11.h,
              child: Obx(()=> ListView.builder(
                itemCount: controller.friendList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return AllFriendCustomCard(
                    imagePath: controller.friendList[index].friendDetails?.profile??"",
                    title: controller.friendList[index].friendDetails?.name??"",
                    onTap: () {
                       Get.to(()=>UserChating(chatType:"single",receiveId: controller.friendList[index].friendDetails!.id.toString(), roomId:controller.friendList[index].roomDetails!.id.toString(), profileImage:controller.friendList[index].friendDetails?.profile??"",
                         userName:controller.friendList[index].friendDetails?.name??"",));
                    },
                  );
                },
              ),
              ),
            ),
            const AppTexts.inter12W600('All Message'),
            SizedBox(height: 1.5.h),
           Obx(()=> controller.chatListLoading.value?Center(
               child: Image.asset(
                 'assets/images/loader.gif',
                 height: 100,
                 width: 100,
               )):ListView.builder(
              itemCount: controller.chatThreadListData.value.data?.data?.length,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                ChatThreadListData userModal=controller.chatThreadListData.value.data!.data![index];
                if(userModal.chatuser?[0].getUser?.id!=baseController.user.value.id) {
                  return InkWell(
                    onTap: () {
                      Get.to(()=>UserChating(chatType:"single",userName:userModal.chatuser?[0].getUser?.name??"",receiveId:userModal.chatuser![0].getUser!.id!.toString(),profileImage:userModal.chatuser![0].getUser?.profileImage??'' , roomId: userModal.chatuser![0].convenienceId!.toString(),));
                    },
                    child: CustomCard(
                      imagePath:userModal.chatuser?[0].getUser?.profileImage??'',
                      title:userModal.chatuser?[0].getUser?.name??"",
                      subtitle:  userModal.lastMessage??'',
                      time:userModal.updatedAt??"",
                      messageCount:userModal.totalUnread??0,
                    ),
                  );
                }
                if(userModal.chatuser?[1].getUser?.id!=baseController.user.value.id) {
                  return InkWell(
                    onTap: () {
                      Get.to(()=>UserChating(chatType:"single",userName:userModal.chatuser?[1].getUser?.name??"",receiveId:userModal.chatuser![1].getUser!.id!.toString(),profileImage:userModal.chatuser![1].getUser?.profileImage??'' , roomId: userModal.chatuser![1].convenienceId!.toString(),));
                    },
                    child: CustomCard(
                      imagePath:userModal.chatuser?[1].getUser?.profileImage??'',
                      title:userModal.chatuser?[1].getUser?.name??"",
                      subtitle:userModal.lastMessage??'',
                      time:userModal.updatedAt??"",
                      messageCount:userModal.totalUnread??0,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            )),
          ],
        ),
      ),
    );
  }
}

class AllFriendCustomCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onTap;

  const AllFriendCustomCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 18.0.sp,right: 10.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.sp),
              child: CachedNetworkImage(
                imageUrl: imagePath,
                fit: BoxFit.cover,
                width: 14.w,
                height: 7.h,
                placeholder: (context, url) => Center(
                  child: SizedBox(
                    width: 14.w,
                    height: 7.h,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.image,
                        size: 30,
                      ),
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
                    width: 14.w,
                    height: 7.h,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTexts.inter10W500(title,textColor: ColoRRes.black,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}