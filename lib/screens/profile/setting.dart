import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_out/controller/profile_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common_screens/app_text.dart';
import '../../common_screens/colors.dart';
import '../../custom_app_screen/custom_appbar_container.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  ProfileController controller=Get.find<ProfileController>();

  void showDeleteAccountBottomSheet(BuildContext context) {
    showModalBottomSheet(
      barrierColor: ColoRRes.black.withOpacity(0.1),
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal:20.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 1.5.h),
              Container(
                height: 0.5.h,
                width: 25.w,
                decoration: BoxDecoration(
                  color: ColoRRes.noThanksColor,
                  borderRadius: BorderRadius.circular(100)
                ),
               
              ),
              SizedBox(height: 2.5.h),
              SvgPicture.asset('assets/profile/warning.svg'),
              SizedBox(height: 2.5.h),
              const AppTexts.inter24W600(
                'Delete account?',
                textColor: ColoRRes.deleteColor,
              ),
              SizedBox(height: 2.5.h),
              const AppTexts.inter16W400(
                'If you delete your account, you will not be able to \nlog in again. Are you sure you want to continue \ndeleting your account?',
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
                            side: BorderSide(
                              color: ColoRRes.black.withOpacity(0.5),
                              width: 1, // Border width
                            ),
                          ),
                          backgroundColor: ColoRRes.white,
                        ),
                        child: AppTexts.inter16W400(
                          'No, thanks',
                          textColor: ColoRRes.noThanksColor.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 2.5.w,),
                  Expanded(
                    child: SizedBox(
                      height: 6.h,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.deleteAccount();
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          surfaceTintColor: ColoRRes.deleteBackColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: ColoRRes.deleteBackColor,
                        ),
                        child: const AppTexts.inter16W400(
                          'Delete',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColoRRes.white,
        appBar: AppBar(
          backgroundColor: ColoRRes.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
                padding:
                    EdgeInsets.only(left: 15.sp, top: 12.5.sp, bottom: 8.sp),
                child: const CustomChatContainer(
                  assetPath: 'assets/chat/back.svg',
                )),
          ),
          title: Container(
            alignment: Alignment.center,
            child: const AppTexts.inter16W600(
              'Setting',
            ),
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
                onTap: () {},
                child: Padding(
                    padding: EdgeInsets.only(
                      right: 15.sp,
                      top: 14.sp,
                    ),
                    child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColoRRes.backGroundColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(14.sp),
                          child: SvgPicture.asset(
                            'assets/home/notification.svg',
                            height: 2.h,
                            width: 2.w,
                            fit: BoxFit.contain,
                          ),
                        ))))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showDeleteAccountBottomSheet(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: ColoRRes.backGroundColor,
                      borderRadius: BorderRadius.circular(16),
                      border:
                          Border.all(width: 0.5, color: ColoRRes.borderColor)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 18.sp, vertical: 15.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/profile/delete.svg',
                                height: 4.h, width: 4.w, fit: BoxFit.contain),
                            SizedBox(width: 3.w),
                            const AppTexts.inter14W500('Delete Account',
                                textColor: ColoRRes.textColor),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: ColoRRes.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 1, color: ColoRRes.boldBlacColor),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10.sp),
                            child: const Center(
                              child: Icon(Icons.arrow_forward_ios_rounded,
                                  size: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
