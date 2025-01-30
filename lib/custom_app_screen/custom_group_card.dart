import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_out/controller/base_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../common_screens/app_text.dart';
import '../common_screens/colors.dart';

class CustomGroupCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final int id;
  final VoidCallback onTap;

  const CustomGroupCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.id,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CachedNetworkImage(
              imageUrl: imagePath,
              fit: BoxFit.cover,
              width: 12.w,
              height: 5.h,
              placeholder: (context, url) => Center(
                child: SizedBox(
                  width: 12.w,
                  height: 5.h,
                  child: const Icon(
                    Icons.image,
                    size: 24, // Adjust icon size as needed
                    color: Colors.grey, // Customize icon color
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                decoration: BoxDecoration(
                  border: Border.all(color: ColoRRes.borderColor),
                  borderRadius: BorderRadius.circular(8.sp),
                ),
                child: Image.asset(
                  "assets/images/noImage.jpg",
                  fit: BoxFit.fill,
                  width: 10.w,
                  height: 5.h,
                ),
              ),
            ),
            SizedBox(width: 4.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 1.h),
                AppTexts. inter16W600(title,textColor: ColoRRes.cardTextColor,), // Title text
                SizedBox(height: 0.8.h), // Adjust as needed
                SizedBox(
                  height: 3.h,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: AppTexts.inter14W400(
                    subtitle, // Subtitle text
                    maxLines: 2,
                    textColor: ColoRRes.textSubColor,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        if(Get.find<BaseController>().user.value.id==id)
         GestureDetector(
           onTap: onTap,
           child: Container(
            decoration: const BoxDecoration(
              color: ColoRRes.white,
              shape: BoxShape.circle
            ),
            child: Padding(
              padding:  EdgeInsets.all(8.sp),
              child: const Icon(
                Icons.close_rounded,
                color: ColoRRes.closeIconColor,
                size: 25,
              ),
            ),
                   ),
         ),
      ],
    );
  }
}
