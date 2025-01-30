import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common_screens/app_text.dart';
import '../../common_screens/colors.dart';
import '../../custom_app_screen/custom_appbar_container.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
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
              'Privacy Policy',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppTexts.inter18W600(
                'Cancelation policy',
                textColor: ColoRRes.primary,
              ),
              SizedBox(height: 1.5.h,),
              AppTexts.inter14W400(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                textColor: ColoRRes.black.withOpacity(0.5),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 1.5.h,),
              AppTexts.inter14W400(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.',
                textColor: ColoRRes.black.withOpacity(0.5),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 2.h,),
              const AppTexts.inter18W600(
                'Terms & Condition',
                textColor: ColoRRes.primary,
              ),
              SizedBox(height: 1.5.h,),
              AppTexts.inter14W400(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                textColor: ColoRRes.black.withOpacity(0.5),
                maxLines: 5,
              ),
            ],
          ),
        ));
  }
}
