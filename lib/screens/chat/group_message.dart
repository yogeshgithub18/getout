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
class GroupMessage extends StatefulWidget {
  const GroupMessage({super.key});

  @override
  State<GroupMessage> createState() => _GroupMessageState();
}

class _GroupMessageState extends State<GroupMessage> {
  ChatController controller=Get.find<ChatController>();
  BaseController baseController=Get.find<BaseController>();

  @override
  void initState() {
    super.initState();
    controller.getGroupAllChat();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppTexts.inter12W600('All Group'),
            SizedBox(height: 1.5.h),
            Obx(()=> controller.groupChatListLoading.value?Center(
                child: Image.asset(
                  'assets/images/loader.gif',
                  height: 100,
                  width: 100,
                )):(controller.groupChatThreadListData.value.data?.data??[]).isEmpty?const Padding(
                  padding: EdgeInsets.only(top:100.0),
                  child: Center(child: Text("No group chat yet")),
                ):ListView.builder(
              itemCount: controller.groupChatThreadListData.value.data?.data?.length,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                ChatThreadListData? userModal=controller.groupChatThreadListData.value.data?.data?[index];
                  return InkWell(
                    onTap: () async {
                      Get.to(()=>UserChating(groupId:userModal?.group?.id, chatType:"group",userName:userModal?.group?.groupName??"",receiveId:userModal!.group!.id.toString(),profileImage:userModal.group?.groupImage??"",roomId: userModal.id.toString(),));
                    },
                    child: CustomCard(
                      imagePath:userModal?.group?.groupImage??"",
                      title:userModal?.group?.groupName??"",
                      subtitle:userModal?.lastMessage??'',
                      time:userModal?.updatedAt??"",
                      messageCount: userModal?.totalUnread??0,
                    ),
                  );
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.image,size: 25,),
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