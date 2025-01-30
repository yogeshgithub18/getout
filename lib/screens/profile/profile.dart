import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_out/screens/home/home_main/notification.dart';
import 'package:get_out/screens/profile/privacy_policy.dart';
import 'package:get_out/screens/profile/profile_view.dart';
import 'package:get_out/screens/profile/setting.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../common_screens/app_text.dart';
import '../../common_screens/colors.dart';
import '../../controller/profile_controller.dart';
import '../chat/generate_itinerary.dart';
import 'add_friend.dart';
import 'add_friend_main.dart';
import 'cluster_map.dart';
import 'help_center.dart';
import 'package:cached_network_image/cached_network_image.dart';
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  ProfileController controller=Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    controller.getProfile();
    controller.getGallery();
    controller.getItieneraryList();
  }

  @override
  void dispose() {
    super.dispose();
  }


@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => const ClusterMapScreen());
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  height: 22.h,
                  child: Image.asset(
                    'assets/home/profileMap.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 15.w),
                    Container(
                      alignment: Alignment.center,
                      child: const AppTexts.inter16W600(
                        'My Profile',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const NotificationScreen());
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: 15.sp,
                          top: 14.sp,
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColoRRes.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(14.sp),
                            child: SvgPicture.asset(
                              'assets/home/notification.svg',
                              height: 2.h,
                              width: 2.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() => Positioned(
                    left: MediaQuery.of(context).size.width / 2 - 50,
                    top: 15.h,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1.5, color: ColoRRes.white),
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[200], // Optional: Background color while loading
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: controller.user.value.profile ?? "", // Replace with your image URL
                            fit: BoxFit.cover,
                            width: 100.0,
                            height: 100.0,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(), // Loading indicator
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error), // Error icon
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
          SizedBox(height: 7.h),
          Obx(() => Center(
                child: AppTexts.inter18W600(
                  controller.user.value.name ?? '',
                  textColor: ColoRRes.textColor,
                ),
              )),
          SizedBox(height: 1.5.h),

          // Left-aligned "Add Memory Journal"
          Padding(
            padding: EdgeInsets.all(15.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                AppTexts.inter14W500(
                  'Add Memory Journal',
                  fontSize: 16,
                ),
              ],
            ),
          ),

          Obx(() => Container(
                margin: EdgeInsets.only(left: 15.sp),
                height: controller.imagesList.isNotEmpty ? 16.h : 5.h,
                child: controller.imagesList.isEmpty
                    ? const Center(
                        child: AppTexts.inter16W600(
                          'No memory found',
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.imagesList.length ?? 0,
                        itemBuilder: (context, index) {
                          return memoryJournalCard(controller.imagesList[index].photo ?? '');
                        },
                      ),
              )),
          SizedBox(height: 1.h),

          // Left-aligned "Itinerary"
          Padding(
            padding: EdgeInsets.all(15.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                AppTexts.inter16W600(
                  'Itinerary',
                ),
              ],
            ),
          ),
          
          Obx(() => Container(
                margin: EdgeInsets.only(left: 15.sp),
                height: controller.itineararyList.isNotEmpty ? 12.h : 5.h,
                child: controller.itineararyList.isEmpty
                    ? const Center(
                        child: AppTexts.inter16W600(
                          'No itinerary found',
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.itineararyList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => GenerateItinerary(from:'normal',id: controller.itineararyList[index].id.toString()));
                            },
                            child: itineraryCard((controller.itineararyList[index].itenaryDetails??[]).isNotEmpty? (controller.itineararyList[index].itenaryDetails?[0].eventsDetails?.photo??''):''),
                          );
                        },
                      ),
              )),
          SizedBox(height: 4.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            child: Column(
              children: [
                actionButton(
                  'assets/profile/addFriend.svg',
                  'Add Friend',
                  () {
                    Get.to(() => AddFriendMain());
                  },
                ),
                SizedBox(height: 2.h),
                actionButton(
                  'assets/profile/profileCircle.svg',
                  'Profile',
                  () async {
                    await Get.to(() => ProfileView());
                    controller.getProfile();
                  },
                ),
                SizedBox(height: 2.h),
                actionButton(
                  'assets/profile/policies.svg',
                  'Policies',
                  () {
                    Get.to(() => const PrivacyPolicy());
                  },
                ),
                SizedBox(height: 2.h),
                actionButton(
                  'assets/profile/setting.svg',
                  'Setting',
                  () {
                    Get.to(() => Setting());
                  },
                ),
                SizedBox(height: 2.h),
                actionButton(
                  'assets/profile/helpCenter.svg',
                  'Help Center',
                  () {
                    Get.to(() => const HelpCenter());
                  },
                ),
                SizedBox(height: 2.h),
                actionButton(
                  'assets/profile/logout.svg',
                  'Logout',
                  () {
                    showLogOutBottomSheet(context);
                  },
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}



  Widget memoryJournalCard(String imageUrl) {
    return Container(
      width: 26.w,
      margin: EdgeInsets.only(
        right: 12.sp,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.sp),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.fill,
          placeholder: (context, url) => const Center(
            child: SizedBox(
                child: Icon(Icons.image,size: 30,)),
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
    );
  }

  Widget itineraryCard(String imageUrl) {
    return Container(
      margin: EdgeInsets.only(
        right: 10.sp,
      ),
      width: 24.w,
      decoration: BoxDecoration(
        color: ColoRRes.itineraryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.sp),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.fill,
          placeholder: (context, url) => const Center(
            child: SizedBox(
                child: Icon(Icons.image,size: 30,)),
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
      )
      // const Center(
      //   child: AppTexts.inter14W500(
      //     'Itinerary',
      //     textColor: ColoRRes.black,
      //   ),
      // ),
    );
  }

  Widget actionButton(String image, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ColoRRes.backGroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 0.5,
            color: ColoRRes.borderColor,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 15.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(image,
                      height: 4.h, width: 4.w, fit: BoxFit.contain,color: ColoRRes.primary,),
                  SizedBox(width: 3.w),
                  AppTexts.inter14W500(label, textColor: ColoRRes.textColor),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColoRRes.white,
                  shape: BoxShape.circle,
                  border: Border.all(width: 1, color: ColoRRes.boldBlacColor),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: const Center(
                    child: Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLogOutBottomSheet(BuildContext context) {
    showModalBottomSheet(
      barrierColor: ColoRRes.black.withOpacity(0.1),
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 1.5.h),
              Container(
                height: 0.5.h,
                width: 25.w,
                decoration: BoxDecoration(
                  color: ColoRRes.noThanksColor,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              SizedBox(height: 2.5.h),
              SvgPicture.asset('assets/profile/logoutbottom.svg'),
              SizedBox(height: 2.5.h),
              const AppTexts.inter24W600(
                'Logout',
                textColor: ColoRRes.deleteColor,
              ),
              SizedBox(height: 2.5.h),
              const AppTexts.inter16W400(
                'Are you sure you want to logout?',
                textAlign: TextAlign.center,
                textColor: ColoRRes.deleteSubColor,
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 5.9.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(
                              color: ColoRRes.textColor,
                              width: 1,
                            ),
                          ),
                          backgroundColor: ColoRRes.white,
                        ),
                        child: const AppTexts.inter16W400(
                          'Cancel',
                          textColor: ColoRRes.textColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 2.5.w),
                  Expanded(
                    child: SizedBox(
                      height: 6.h,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.logout();
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          surfaceTintColor: ColoRRes.deleteBackColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: ColoRRes.primary,
                        ),
                        child: const AppTexts.inter16W400(
                          'Yes, Logout',
                          textColor: ColoRRes.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
            ],
          ),
        );
      },
    );
  }

  }

  Widget profileActionButton(String image, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ColoRRes.backGroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 0.5,
            color: ColoRRes.borderColor,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 15.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(image,
                      height: 4.h, width: 4.w, fit: BoxFit.contain),
                  SizedBox(width: 3.w),
                  AppTexts.inter14W500(label, textColor: ColoRRes.textColor),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColoRRes.white,
                  shape: BoxShape.circle,
                  border: Border.all(width: 1, color: ColoRRes.boldBlacColor),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: const Center(
                    child: Icon(Icons.edit_rounded, size: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
