import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../common_screens/app_text.dart';
import '../common_screens/colors.dart';

class CustomCardSecond extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String time;
  final VoidCallback onTap;

  const CustomCardSecond({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 18.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.sp),
                  child: Image.network(
                    imagePath,fit: BoxFit.cover, width: 14.w, height:7.h,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: SizedBox(
                          width: 14.w, height:7.h,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        ),
                      );
                    },errorBuilder: (context,stack,child){
                    return  Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: ColoRRes.borderColor),
                          borderRadius: BorderRadius.circular(8.sp)
                      ),
                      child: Image.asset(
                        "assets/images/noImage.jpg",fit: BoxFit.fill,width: 14.w, height:7.h,
                      ),
                    );
                  },),
                ),
                SizedBox(width: 4.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTexts.inter15W600(title),
                    SizedBox(height: 1.h),
                    SizedBox(
                      height: 3.h,
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: AppTexts.inter10W300(
                        subtitle,
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
                  time,
                  fontSize: 12,
                  textColor: ColoRRes.timeColor,
                ),
                SizedBox(height: 1.5.h),
                SvgPicture.asset('assets/chat/doubleClick.svg'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
