import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_out/controller/itninerary_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common_screens/app_text.dart';
import '../../../../common_screens/colors.dart';

class EventName extends StatefulWidget {
  const EventName({super.key});

  @override
  State<EventName> createState() => _EventNameState();
}

class _EventNameState extends State<EventName> {
  ItineraryController controller=Get.find<ItineraryController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 3.h),
            const AppTexts.inter24W600(
              'Event Name',
              textColor: ColoRRes.textColor,
            ),
            SizedBox(height: 1.h),
            const AppTexts.inter14W400(
              'Please enter your name to request a \nprofile creation',
              textColor: ColoRRes.subTextColor,
            ),
            SizedBox(height: 5.h),
            Container(
              height: 7.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.sp),
                border: Border.all(
                  width: 0.5,
                  color: ColoRRes.borderColor
                )
              ),
              child: TextField(
                controller: controller.eventController.value,
                cursorColor: ColoRRes.black,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    color: ColoRRes.textColor
                ),
                decoration: InputDecoration(
                  hintText: 'Enter event name',
                  hintStyle: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: ColoRRes.subTextColor,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 18.sp, horizontal: 20.sp),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
