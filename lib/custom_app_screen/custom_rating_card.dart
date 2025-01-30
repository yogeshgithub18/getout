import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../common_screens/app_text.dart';
import '../common_screens/colors.dart';

class CustomRatingCardCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String owner;
  final String distance;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onCloseTap;

  const CustomRatingCardCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.owner,
    required this.distance,
    required this.isSelected,
    required this.onTap, 
    required this.onCloseTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //margin: EdgeInsets.only(right: 10.sp,),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
           // color: isSelected ? ColoRRes.primary : ColoRRes.white,
            color: ColoRRes.white,
          ),
          borderRadius: BorderRadius.circular(18.sp),
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.sp),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: 24.h,
                    width: 46.w,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: SizedBox(
                        height: 24.h,
                        width: 46.w,
                        child: const Icon(
                          Icons.image,
                          size: 40, // Adjust icon size as needed
                          color: Colors.grey, // Adjust icon color as needed
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: ColoRRes.borderColor),
                        borderRadius: BorderRadius.circular(12.sp),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.sp),
                        child: Image.asset(
                          "assets/images/noImage.jpg",
                          fit: BoxFit.fill,
                          width: 46.w,
                          height: 24.h,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap:onCloseTap,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 12.sp),
                        decoration: const BoxDecoration(
                            color: ColoRRes.white,
                            shape: BoxShape.circle
                        ),
                        child: Padding(
                          padding:  EdgeInsets.all(8.sp),
                          child: const Icon(Icons.close_rounded,color: ColoRRes.textColor,size: 12,),
                        ),
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.symmetric(horizontal: 12.sp,),
                    //   decoration: BoxDecoration(
                    //     color: ColoRRes.primary,
                    //     borderRadius: BorderRadius.circular(12.sp),
                    //     border: Border.all(
                    //       width: 0.5,
                    //       color: ColoRRes.white
                    //     )
                    //   ),
                    //   child: Padding(
                    //     padding: EdgeInsets.symmetric(vertical:10.sp,horizontal: 12.sp),
                    //     child: Center(
                    //       child: Row(
                    //          crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: [
                    //           const AppTexts.inter12W400(
                    //             'Add',
                    //             textColor: ColoRRes.white,
                    //           ),
                    //           SizedBox(width: 1.5.w,),
                    //           SvgPicture.asset(
                    //             'assets/chat/addStar.svg',
                    //             height: 1.5.h,
                    //             width: 1.5.w,
                    //             fit: BoxFit.contain,
                    //           ),
                    //           SizedBox(width: 1.w),
                    //           AppTexts.inter12W400(
                    //             distance,
                    //             textColor: ColoRRes.white,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Positioned(
                  left: 15.sp,
                  bottom: 10.sp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 44.sp,
                        child: AppTexts.poppins12W500(
                          title,
                          textColor: ColoRRes.white,
                        ),
                      ),
                      SizedBox(
                        width: 44.sp,
                        child: AppTexts.poppins8W300(
                          owner,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}