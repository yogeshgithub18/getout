import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_out/common_screens/colors.dart';
import 'package:get_out/controller/base_controller.dart';
import 'package:get_out/screens/star/star.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../controller/chat_controller.dart';
import '../../../controller/profile_controller.dart';
import '../../../modal/otp_response.dart';
import '../../../storage/base_shared_preference.dart';
import '../../../storage/sp_keys.dart';
import '../../chat/direct_and_group_chat.dart';
import '../../profile/profile.dart';
import '../../profile/profile_view.dart';
import '../camera/review.dart';
import 'home.dart';

class BottomNavigation extends StatefulWidget {

  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedIndex = 0;
  File? imageFile;
  final ImagePicker picker = ImagePicker();
  BaseController baseController=Get.put(BaseController());
  @override
  void initState() {
    super.initState();
  }

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }
  Future<void> pickImageFromCamera() async {
    await requestCameraPermission();
    if (await Permission.camera.isGranted) {
      final pickedFile = await picker.pickImage(source: ImageSource.camera,imageQuality:10);
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
        });
        Get.to(()=>Reviews(imageFile: imageFile!));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera permission is required')),
      );
    }
  }

  static final List<Widget> screens = <Widget>[
    const Home(),
    const Star(),
    const DirectAndGroupChat(),
    const Profile(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoRRes.white,
      body: Center(
        child: screens.elementAt(selectedIndex),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 34.sp),
        child: FloatingActionButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          onPressed: () {
            Get.put(ChatController());
            pickImageFromCamera();
          },
          backgroundColor: ColoRRes.primary,
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: SvgPicture.asset(
              'assets/bottomNavigateImg/camera.svg',
              height: 3.5.h,
              width: 3.5.w,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColoRRes.white,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  selectedIndex == 0
                      ? 'assets/bottomNavigateImg/home.svg'
                      : 'assets/bottomNavigateImg/disHome.svg',height: 3.5.h,width: 3.5.w,fit: BoxFit.contain,
                ),
                SizedBox(height: 0.5.h),
                Text('Home', style: getTextStyle(selectedIndex == 0)),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(right: 28.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    selectedIndex == 1
                        ? 'assets/bottomNavigateImg/activeStar.svg'
                        : 'assets/bottomNavigateImg/disStar.svg',height: 3.5.h,width: 3.5.w,fit: BoxFit.contain,
                  ),
                  SizedBox(height: 0.6.h),
                  Text('Star', style: getTextStyle(selectedIndex == 1)),
                ],
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(left: 28.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    selectedIndex == 2
                        ? 'assets/bottomNavigateImg/activeChat.svg'
                        : 'assets/bottomNavigateImg/disChat.svg',height: 3.5.h,width: 3.5.w,fit: BoxFit.contain,
                  ),
                  SizedBox(height: 0.6.h),
                  Text('Chat', style: getTextStyle(selectedIndex == 2)),
                ],
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  ()=> ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: baseController.user.value.profile??"",
                      fit: BoxFit.cover,
                      width: 28,
                      height: 28,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(height: 0.6.h),
                Text('Profile', style: getTextStyle(selectedIndex ==3)),
              ],
            ),
            label: '',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: ColoRRes.primary,
        unselectedItemColor: ColoRRes.subTextColor,
        onTap: onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }

  TextStyle getTextStyle(bool isSelected) {
    return TextStyle(
      fontFamily: 'Poppins',
      fontSize: 12,
      fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
      color: isSelected ? ColoRRes.primary : ColoRRes.subTextColor,
    );
  }
}







