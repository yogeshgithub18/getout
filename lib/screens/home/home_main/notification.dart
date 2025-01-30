import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../common_screens/app_text.dart';
import '../../../common_screens/colors.dart';
import '../../../custom_app_screen/custom_card_notification.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<String> notificationText = [
    "New Appointment",
    "New Appointment",
    "New Appointment",
    "New Appointment",
    "New Appointment",
    "New Appointment",
    "New Appointment",
    "New Appointment",
    "New Appointment",
    "New Appointment",
  ];
  List<String> notificationSubText = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eium tempor incididunt ut labore et dolore magna aliqua.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eium tempor incididunt ut labore et dolore magna aliqua.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eium tempor incididunt ut labore et dolore magna aliqua.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eium tempor incididunt ut labore et dolore magna aliqua.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eium tempor incididunt ut labore et dolore magna aliqua.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eium tempor incididunt ut labore et dolore magna aliqua.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eium tempor incididunt ut labore et dolore magna aliqua.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eium tempor incididunt ut labore et dolore magna aliqua.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eium tempor incididunt ut labore et dolore magna aliqua.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eium tempor incididunt ut labore et dolore magna aliqua.",
  ];
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
            padding: EdgeInsets.only(
              left: 15.sp,
              top: 14.sp,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: ColoRRes.backGroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(14.sp),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: ColoRRes.textColor,
                  size: 22,
                ),
              ),
            ),
          ),
        ),
        title: Container(
          alignment: Alignment.center,
          child: Padding(
            padding:  EdgeInsets.only(left: 15.sp,top: 10.sp),
            child: const AppTexts.inter16W600(
              'Notification',
            ),
          ),
        ),
        centerTitle: true,
        actions: [
            Container(
              margin: EdgeInsets.only(
                right: 15.sp,
                top: 18.sp,
                bottom: 15.sp
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: ColoRRes.primary
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.sp,),
                child: const Center(child: AppTexts.inter10W500('2 New',textColor: ColoRRes.white,)),
              ),
            )
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 15.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   AppTexts.inter14W500('Today',textColor: ColoRRes.black.withOpacity(0.5),),
                  const AppTexts.inter12W500('Mark all as read',textColor: ColoRRes.textColor,),
                ],
              ),
              SizedBox(height: 2.5.h),
              ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return NotificationListCard(
                    imagePath: 'assets/images/user.png',
                    title: notificationText[index],
                    subtitle: notificationSubText[index],
                    time: '1h',
                  );
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}


