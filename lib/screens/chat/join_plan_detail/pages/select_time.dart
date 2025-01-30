import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common_screens/app_text.dart';
import '../../../../common_screens/colors.dart';
import '../../../../controller/itninerary_controller.dart';

class SelectTime extends StatefulWidget {
  const SelectTime({super.key});

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  ItineraryController controller=Get.find<ItineraryController>();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  String formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm().format(dt);
  }

  Future<void> selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? startTime : endTime,
    );
    if (picked != null && picked != (isStartTime ? startTime : endTime)) {
      setState(() {
        if (isStartTime) {
          startTime=picked;
          controller.startTime.value = formatTime(picked);
          print("-startTime--${controller.startTime.value}");
        } else {
          endTime=picked;
          controller.endTime.value= formatTime(picked);
        }
      });
    }
  }

 @override
  void initState() {
    // TODO: implement initState
   controller.startTime.value = formatTime(startTime);
   controller.endTime.value = formatTime(endTime);
    super.initState();
  }
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
              'Select you Timing',
              textColor: ColoRRes.textColor,
            ),
            SizedBox(height: 1.h),
            const AppTexts.inter14W400(
              'Please enter your name to request a \nprofile creation',
              textColor: ColoRRes.subTextColor,
            ),
            SizedBox(height: 4.h),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    width: 1,
                    color: ColoRRes.black.withOpacity(0.5)
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  // Start time section
                  Expanded(
                    child: GestureDetector(
                      onTap: () => selectTime(context, true),
                      child: Container(
                        padding:  EdgeInsets.all(16.sp),
                        decoration: const BoxDecoration(
                          color: ColoRRes.timeBackColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AppTexts.inter12W500(
                              "Start",
                              textColor: ColoRRes.primary,
                            ),
                            SizedBox(height: 1.h),
                            AppTexts.inter18W600(
                              formatTime(startTime),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 8.1.h,
                    color: ColoRRes.black.withOpacity(0.5),
                  ),
                  // End time section
                  Expanded(
                    child: GestureDetector(
                      onTap: () => selectTime(context, false),
                      child: Container(
                        padding:  EdgeInsets.all(16.sp),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AppTexts.inter12W500(
                              "End",
                              textColor: ColoRRes.primary,
                            ),
                            SizedBox(height: 1.h),
                            AppTexts.inter18W600(
                              formatTime(endTime),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
