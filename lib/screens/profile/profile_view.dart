import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_out/screens/home/home_main/notification.dart';
import 'package:get_out/screens/profile/privacy_policy.dart';
import 'package:get_out/screens/profile/setting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../common_screens/app_text.dart';
import '../../common_screens/colors.dart';
import '../../controller/profile_controller.dart';
import '../../custom_app_screen/custom_main_button.dart';
import 'add_friend.dart';
import 'cluster_map.dart';
import 'help_center.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  ProfileViewState createState() => ProfileViewState();
}

class ProfileViewState extends State<ProfileView> with TickerProviderStateMixin {
  ProfileController controller=Get.put(ProfileController());
  final ImagePicker picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    setProfile();

  }
  setProfile()async{
    controller.isEdit.value=false;
    controller.selectedFile.value=File("");
   await controller.getProfile();
   controller.uEmail.value.text=controller.user.value.email??'';
   controller.uMobile.value.text=controller.user.value.mobile??'';
   controller.uAge.value.text=controller.user.value.howOld??'';
   controller.uGender.value.text=controller.user.value.gender??'';
  }

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }
  Future<void> pickImage(ImageSource source) async {
    await requestCameraPermission();
    if (await Permission.camera.isGranted) {
      final pickedFile = await picker.pickImage(source:source,imageQuality:50);
      if (pickedFile != null) {
        controller.selectedFile.value=File(pickedFile.path);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera permission is required')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Obx(()=> Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.to(()=>const ClusterMapScreen());
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
                      GestureDetector(
                        onTap: () {
                           Get.back();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 15.sp,
                            top: 14.sp,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColoRRes.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(14.sp),
                              child: const Icon(
                                Icons.arrow_back_rounded,
                                color: ColoRRes.textColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const AppTexts.inter16W600(
                          'My Profile',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(()=>NotificationScreen());
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
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 50,
                  top: 15.h,
                  child: InkWell(
                    onTap: (){
                      print("hello");
                      controller.isEdit.value=true;
                      pickImage(ImageSource.gallery);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1.5, color: ColoRRes.white),
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[200], // Optional: Background color while loading
                        child: ClipOval(
                          child: controller.selectedFile.value.path.isNotEmpty
                              ? ClipRRect(
                              borderRadius: BorderRadius.circular(150),
                              child: Image.file(
                                controller.selectedFile.value,
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              )) :CachedNetworkImage(
                            imageUrl: controller.user.value.profile??"", // Replace with your image URL
                            fit: BoxFit.cover,
                            width: 100.0,
                            height: 100.0,
                            placeholder: (context, url) => CircularProgressIndicator(), // Loading indicator
                            errorWidget: (context, url, error) => Icon(Icons.error), // Error icon
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 + 24,
                  top: 24.h,
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColoRRes.white,
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: ColoRRes.boldBlacColor),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.sp),
                      child: const Icon(
                        Icons.mode_edit_outline_rounded,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Center(
              child: AppTexts.inter18W600(
                controller.user.value.name??'',
                textColor: ColoRRes.textColor,
              ),
            ),
            SizedBox(height: 1.5.h),
            Padding(
                padding: EdgeInsets.all(15.sp),
                child: Column(
                  children: [
                    controller.isEdit.value? Container(
                      height: 7.h,
                      decoration: BoxDecoration(
                        color: ColoRRes.backGroundColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          width: 0.5,
                          color: ColoRRes.borderColor,
                        ),
                      ),
                      child: TextField(
                        controller: controller.uEmail.value,
                        cursorColor: ColoRRes.black,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: 'Inter',
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 16.sp, right: 16.sp),
                            child: SvgPicture.asset('assets/profile/mail.svg',height: 4.h, width: 4.w,),
                          ),
                          hintText: 'Email',
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
                    ):
                    profileActionButton(
                      'assets/profile/mail.svg',
                       controller.user.value.email??"",
                          () {
                          controller.isEdit.value=true;
                          },
                    ),
                    SizedBox(height: 2.h),
                    controller.isEdit.value? Container(
                      height: 7.h,
                      decoration: BoxDecoration(
                        color: ColoRRes.backGroundColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          width: 0.5,
                          color: ColoRRes.borderColor,
                        ),
                      ),
                      child: TextField(
                        controller: controller.uMobile.value,
                        cursorColor: ColoRRes.black,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 16.sp, right: 16.sp),
                            child: SvgPicture.asset('assets/profile/call.svg',height: 4.h, width: 4.w,),
                          ),
                          hintText: 'Mobile no',
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
                    ):
                    profileActionButton(
                      'assets/profile/call.svg',
                      "${controller.user.value.countryCode} ${controller.user.value.mobile}",
                          () {
                            controller.isEdit.value=true;
                          },
                    ),
                    SizedBox(height: 2.h),
                    controller.isEdit.value? Container(
                      height: 7.h,
                      decoration: BoxDecoration(
                        color: ColoRRes.backGroundColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          width: 0.5,
                          color: ColoRRes.borderColor,
                        ),
                      ),
                      child: TextField(
                        controller: controller.uAge.value,
                        cursorColor: ColoRRes.black,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 16.sp, right: 16.sp),
                            child: SvgPicture.asset('assets/profile/age.svg',height: 4.h, width: 4.w,),
                          ),
                          hintText: 'Age',
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
                    ):
                    profileActionButton(
                      'assets/profile/age.svg',
                      "${controller.user.value.howOld} years old",
                          () {
                            controller.isEdit.value=true;
                          },
                    ),
                    SizedBox(height: 2.h),
                    controller.isEdit.value? Container(
                      height: 7.h,
                      decoration: BoxDecoration(
                        color: ColoRRes.backGroundColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          width: 0.5,
                          color: ColoRRes.borderColor,
                        ),
                      ),
                      child: TextField(
                        controller: controller.uGender.value,
                        cursorColor: ColoRRes.black,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 16.sp, right: 16.sp),
                            child: SvgPicture.asset('assets/profile/gender.svg',height: 4.h, width: 4.w,),
                          ),
                          hintText: 'Gender',
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
                    ):
                    profileActionButton(
                      'assets/profile/gender.svg',
                      controller.user.value.gender,
                          () {
                            controller.isEdit.value=true;
                          },
                    ),
                  ],
                ),
              ),
            SizedBox(height: 5.5.h),
            Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 25),
          child: CustomButton(
            label: "Submit",
            onPressed: () {
              if(controller.isEdit.value) {
                controller.editProfile();
              }
            },
           ),
          ),
          ],
        ),
      )),
    );
  }

  Widget profileActionButton(String image, String label, VoidCallback onTap) {
    return Container(
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
            GestureDetector(
              onTap: onTap,
              child: Container(
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
            ),
          ],
        ),
      ),
    );
  }
}
