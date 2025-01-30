import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_out/controller/register_main_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common_screens/app_text.dart';
import '../../../common_screens/colors.dart';
import '../../../controller/profile_controller.dart';

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({super.key});

  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  RegisterMainController controller=Get.find<RegisterMainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoRRes.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 3.h),
          const AppTexts.inter24W600(
            'Select your Gender',
            textColor: ColoRRes.textColor,
          ),
          SizedBox(height: 1.h),
           const AppTexts.inter14W400(
            'Please enter your name to request a \nprofile creation',
            textColor: ColoRRes.subTextColor,
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              genderOption('assets/images/male.svg', "Male"),
              genderOption('assets/images/female.svg', "Female"),
            ],
          ),
          Center(child: genderOption('assets/images/other.svg', "Other")),
        ],
      ),
    );
  }

  Widget genderOption(String imageSvg, String label) {
    return Obx(()=> GestureDetector(
      onTap: () {
        controller.gender.value=label;
      },
      child: Column(
        children: [
          Container(
            height: 48.sp,
            width: 48.sp,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: controller.gender.value == label ? ColoRRes.primary : ColoRRes.backGroundColor,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 15.sp),
                  child: SvgPicture.asset(
                    imageSvg,
                    color: controller.gender.value == label  ?ColoRRes.white:ColoRRes.textColor,
                    height: 30.sp,
                    width: 30.sp,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  bottom: 3.h,
                  child: AppTexts.inter14W500(
                    label,
                    textColor:  controller.gender.value == label  ?ColoRRes.white:ColoRRes.textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
    );
  }
}
