import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../common_screens/app_text.dart';
import '../common_screens/colors.dart';

class CustomCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String time;
  final int? messageCount;

  const CustomCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.time,
    this.messageCount,
  });

  @override
  CustomCardState createState() => CustomCardState();
}

class CustomCardState extends State<CustomCard> {
  bool isChecked = false;

  void updateMessage(covariant CustomCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.messageCount != oldWidget.messageCount && widget.messageCount != null && widget.messageCount! > 0) {
      setState(() {
        isChecked = false;
      });
    }
  }

  void handleTap() {
    setState(() {
      isChecked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 18.0.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.sp),
                child: CachedNetworkImage(
                  imageUrl: widget.imagePath,
                  fit: BoxFit.cover,
                  width: 14.w,
                  height: 7.h,
                  placeholder: (context, url) => Center(
                    child: SizedBox(
                      width: 14.w,
                      height: 7.h,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.image,
                          size: 30,
                        )
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
                      width: 14.w,
                      height: 7.h,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTexts.inter15W600(widget.title),
                  SizedBox(height: 0.8.h),
                  SizedBox(
                    height: 3.h,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: AppTexts.inter10W300(
                      widget.subtitle,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppTexts.inter14W500(
                widget.time,
                fontSize: 12,
                textColor: ColoRRes.timeColor,
              ),
              SizedBox(height: 0.8.h),
              (widget.messageCount == null || widget.messageCount == 0 || isChecked)
                  ? const Icon(
                Icons.check_rounded,
                color: ColoRRes.checkIconColor,
                size: 25,
              )
                  : Container(
                height: 4.h,
                width: 4.w,
                padding: EdgeInsets.all(2.sp),
                decoration: const BoxDecoration(
                  color: ColoRRes.showMessageColor,
                  shape: BoxShape.circle
                ),
                child: Center(
                  child: AppTexts.poppins12W500(
                    '${widget.messageCount}',
                    textColor: ColoRRes.white,

                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
