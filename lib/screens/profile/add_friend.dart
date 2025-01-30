import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_out/controller/profile_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common_screens/app_text.dart';
import '../../common_screens/colors.dart';
import '../../modal/my_friend_response.dart';

class AddFriend extends StatefulWidget {
  const AddFriend({super.key});

  @override
  State<AddFriend> createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  ProfileController controller=Get.find<ProfileController>();
  TextEditingController addFriendController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    controller.filteredItems=controller.friendList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 6.h,
            decoration: BoxDecoration(
              color: ColoRRes.backGroundColor,
              borderRadius: BorderRadius.circular(35.sp),
            ),
            child: TextField(
              controller: addFriendController,
              onChanged: controller.filterList,
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
                    },
                    child: Container(
                      padding: EdgeInsets.all(14.sp),
                      decoration: const BoxDecoration(
                          color: ColoRRes.textColor, shape: BoxShape.circle),
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
          SizedBox(height: 2.h,),
          Container(
            height: 0.1.h,
            width: double.infinity,
            color: ColoRRes.dividerColor,
          ),
          SizedBox(height: 2.h,),
          const AppTexts.inter12W600(
              'All Friends',
            textColor: ColoRRes.black,
          ),
         Obx(()=> Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.friendList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                      if (controller.selectedFriend.contains(controller.friendList[index].id)) {
                        // controller.friendList[index].is_friend=0;
                         controller.friendList.refresh();
                         controller.selectedFriend.remove(controller.friendList[index].id);
                      } else {
                        controller.selectedFriend.add(controller.friendList[index].id!);
                      }
                  },
                  child: Container(
                    margin:  EdgeInsets.only(bottom: 18.sp),
                    child:Obx(()=> Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                           Container(
                           width:14.w, // Width of the square
                           height:7.h,
                          clipBehavior: Clip.antiAlias,// Height of the square
                         decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         shape: BoxShape.rectangle, // Rectangle for square shape
                         border: Border.all(width: 1, color: Colors.white),
                        ),
                        child: CachedNetworkImage(
                        imageUrl:controller.friendList[index].friendDetails?.profile??'', // Replace with your image URL
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()), // Loading indicator
                        errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)), // Error icon
                        ),
                       ),
                            SizedBox(width: 4.w,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTexts.inter14W600(controller.friendList[index].friendDetails?.name??''),
                                SizedBox(height: 0.5.h,),
                                AppTexts.inter14W400(controller.friendList[index].friendDetails?.mobile??'',fontSize: 10,textColor: ColoRRes.textSubColor,),
                              ],
                            ),
                          ],
                        ),
                       // ( controller.selectedFriend.contains(controller.friendList[index].id)) ?
                       //  Container(
                       //    height: 7.h,
                       //    width: 7.w,
                       //    decoration: const BoxDecoration(
                       //        shape: BoxShape.circle,
                       //        color: ColoRRes.primary
                       //    ),
                       //    child: const Center(child: Icon(Icons.check_rounded,color: ColoRRes.white,size: 20,)),
                       //  ):Container(
                       //    height: 7.h,
                       //    width: 7.w,
                       //    decoration: BoxDecoration(
                       //        shape: BoxShape.circle,
                       //        border: Border.all(
                       //            width: 1,
                       //            color: ColoRRes.borderColor
                       //        )
                       //    ),
                       //  )
                      ],
                     ),
                    ),
                  ),
                );
              },
            ),
          )),
        ],
      ),
    );
  }
}
