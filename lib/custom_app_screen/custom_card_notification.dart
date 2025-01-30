import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../common_screens/app_text.dart';
import '../../common_screens/colors.dart';

class NotificationListCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String time;


  const NotificationListCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.time,

  });

  @override
  NotificationListCardState createState() => NotificationListCardState();
}

class NotificationListCardState extends State<NotificationListCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(bottom: 18.0.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipOval(child: Image.asset(widget.imagePath)),
                SizedBox(width: 4.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTexts.inter14W600(widget.title),
                    SizedBox(height: 0.8.h),
                    SizedBox(
                      height: 4.h,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: AppTexts.inter12W400(
                        widget.subtitle,
                        maxLines: 3,
                        textAlign: TextAlign.left,
                        textColor: ColoRRes.black.withOpacity(0.5),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            AppTexts.inter14W500(
              widget.time,
              fontSize: 12,
              textColor: ColoRRes.timeColor,
            ),
          ],
        ),
      ),
    );
  }
}
