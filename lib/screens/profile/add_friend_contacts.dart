import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_out/controller/profile_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get_out/base_utils/base_overlays.dart';
import '../../common_screens/app_text.dart';
import '../../common_screens/colors.dart';
import '../../../custom_app_screen/custom_main_button.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:contacts_service/contacts_service.dart';

class AddFriendContact extends StatefulWidget {
  const AddFriendContact({super.key});

  @override
  State<AddFriendContact> createState() => _AddFriendContactState();
}

class _AddFriendContactState extends State<AddFriendContact> {
  ProfileController controller = Get.find<ProfileController>();
  TextEditingController addFriendController = TextEditingController();

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
                    onTap: () {},
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
          SizedBox(
            height: 2.h,
          ),
          Container(
            height: 0.1.h,
            width: double.infinity,
            color: ColoRRes.dividerColor,
          ),
          SizedBox(
            height: 2.h,
          ),
          const AppTexts.inter12W600(
            'All Contacts',
            textColor: ColoRRes.black,
          ),
          Obx(() => Expanded(
                child: controller.isContactLoading.value
                    ? Center(
                    child: Image.asset(
                      'assets/images/loader.gif',
                      height: 100,
                      width: 100,
                    ))
                    : ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: controller.contacts.length,
                        itemBuilder: (context, index) {
                          final contact = controller.contacts[index];
                          // Safely handle the case where there are no phone numbers
                          String phoneNumber = 'No Phone Number';
                          if (contact.number != null &&
                              contact.number!.isNotEmpty) {
                            phoneNumber = contact.number ?? 'No Phone Number';
                          }
                          return GestureDetector(
                            onTap: () {
                              // if (controller.selectedFriend.contains(controller.friendList[index].id)) {
                              //   // controller.friendList[index].is_friend=0;
                              //    controller.friendList.refresh();
                              //    controller.selectedFriend.remove(controller.friendList[index].id);
                              // } else {
                              //   controller.selectedFriend.add(controller.friendList[index].id!);
                              // }
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 18.sp),
                              child: Obx(
                                () => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 12.w, // Width of the square
                                          height: 7.h,
                                          clipBehavior: Clip
                                              .antiAlias, // Height of the square
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            shape: BoxShape
                                                .rectangle, // Rectangle for square shape
                                            border: Border.all(
                                                width: 1, color: Colors.white),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                '', // Replace with your image URL
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator()), // Loading indicator
                                            errorWidget: (context, url,
                                                    error) =>
                                                const Center(
                                                    child: Icon(Icons
                                                        .person)), // Error icon
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4.w,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: 45.w,
                                                child: AppTexts.inter14W600(
                                                    controller.contacts[index]
                                                            .name ??
                                                        '',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis)),
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            AppTexts.inter14W400(
                                              phoneNumber,
                                              fontSize: 10,
                                              textColor: ColoRRes.textSubColor,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    if (!(contact.alreadyFriend ?? false))
                                      SizedBox(
                                        height: 5.h,
                                        width: 27
                                            .w, // Adjust the size as necessary
                                        child: CustomButton(
                                          label: (contact.isavailable ?? false)
                                              ? "Add Friend"
                                              : "Invite",
                                          onPressed: () async {
                                            if (contact.isavailable ?? false) {
                                              controller.addFriend(contact.userId!, index);
                                            } else {
                                              const playStoreUrl =
                                                  'https://play.google.com/store/apps/details?id=com.example.yourapp'; // Replace with your app's URL
                                              if (await canLaunch(
                                                  playStoreUrl)) {
                                                await launch(playStoreUrl);
                                              } else {
                                                print(
                                                    'Could not launch $playStoreUrl');
                                              }
                                            }
                                          },
                                        ),
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
