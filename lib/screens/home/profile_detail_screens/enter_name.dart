import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_out/controller/profile_controller.dart';
import 'package:get_out/controller/register_main_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common_screens/app_text.dart';
import '../../../common_screens/colors.dart';

class NameEmailForm extends StatelessWidget {
  final FocusNode? focusNodeB;
  final FocusNode? focusNode;
  final bool? isFocusedB;
  final bool? isFocused;

  const NameEmailForm({
    super.key,
    this.focusNodeB,
    this.focusNode,
    this.isFocusedB,
    this.isFocused,
  });

  @override
  Widget build(BuildContext context) {
    RegisterMainController controller=Get.find<RegisterMainController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 3.h),
            const AppTexts.inter24W600(
              'Enter your name',
              textColor: ColoRRes.textColor,
            ),
            SizedBox(height: 1.h),
            const AppTexts.inter14W400(
              'Please enter your name to request a \nprofile creation',
              textColor: ColoRRes.subTextColor,
            ),
            SizedBox(height: 5.h),
            TextField(
              controller: controller.firstName.value,
              focusNode: focusNodeB,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
              cursorColor: ColoRRes.black,
              decoration: InputDecoration(
                labelText: (isFocusedB ?? false) || (controller.firstName.value.text.isNotEmpty ?? false)
                    ? 'Full Name'
                    : 'Enter Full name',
                labelStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: (isFocusedB ?? false) ? 14 : 16,
                  fontWeight: (isFocusedB ?? false) ? FontWeight.w500 : FontWeight.w400,
                  color: (isFocusedB ?? false)
                      ? ColoRRes.textColor
                      : ColoRRes.subTextColor,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(19.sp),
                  borderSide: const BorderSide(
                    width: 0.5,
                    color: ColoRRes.subBorderColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(19.sp),
                  borderSide: const BorderSide(color: ColoRRes.textColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(19.sp),
                  borderSide: const BorderSide(
                    width: 0.5,
                    color: ColoRRes.subBorderColor,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 18.sp,
                  horizontal: 25.sp,
                ),
              ),
            ),
            SizedBox(height: 2.5.h),
            TextField(
              controller: controller.email.value,
              focusNode: focusNode,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                fontSize: 18.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
              cursorColor: ColoRRes.black,
              decoration: InputDecoration(
                labelText: (isFocused ?? false) || (controller.email.value.text.isNotEmpty ?? false)
                    ? 'Your Mail'
                    : 'Enter your mail',
                labelStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: (isFocused ?? false) ? 14 : 16,
                  fontWeight: (isFocused ?? false) ? FontWeight.w500 : FontWeight.w400,
                  color: (isFocused ?? false)
                      ? ColoRRes.textColor
                      : ColoRRes.subTextColor,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(19.sp),
                  borderSide: const BorderSide(
                    width: 0.5,
                    color: ColoRRes.subBorderColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(19.sp),
                  borderSide: const BorderSide(color: ColoRRes.textColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(19.sp),
                  borderSide: const BorderSide(
                    width: 0.5,
                    color: ColoRRes.subBorderColor,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 18.sp,
                  horizontal: 25.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
