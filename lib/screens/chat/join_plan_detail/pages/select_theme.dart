import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_out/controller/itninerary_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common_screens/app_text.dart';
import '../../../../common_screens/colors.dart';

class SelectTheme extends StatefulWidget {
  const SelectTheme({super.key});

  @override
  State<SelectTheme> createState() => _SelectThemeState();
}

class _SelectThemeState extends State<SelectTheme> {
  ItineraryController controller=Get.find<ItineraryController>();
  @override
  void initState() {
    // TODO: implement initState
    controller.getTheme();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 3.h),
          const AppTexts.inter24W600(
            'Select your theme',
            textColor: ColoRRes.textColor,
          ),
          SizedBox(height: 1.h),
          const AppTexts.inter14W400(
            'Please enter your name to request a \nprofile creation',
            textColor: ColoRRes.subTextColor,
          ),
          SizedBox(height: 3.h),
         Obx(()=> Expanded(
            child: GridView.count(
              childAspectRatio: .75,
              crossAxisCount: 3, // 3 containers per row
              crossAxisSpacing: 5.0, // Space between columns
              mainAxisSpacing: 5.0,  // Space between rows
              padding: const EdgeInsets.all(5.0),
              children: List.generate(controller.interestList.length, (index) { // Change 9 to the total number of items
                return PlanCard(
                  name: controller.interestList[index].name??'',
                  id:controller.interestList[index].id.toString(),
                  imageUrl:controller.interestList[index].photo??"",
                  onTap: () {
                     controller.selectedTheme.value=controller.interestList[index].id.toString();
                  },
                );
              }),
            ),
          )
         ),
        ],
      ),
    );
  }
}



class PlanCard extends StatefulWidget {
  final String imageUrl;
  final String id;
  final String name;
  final VoidCallback onTap;

  const PlanCard({
    super.key,
    required this.imageUrl,
    required this.id,
    required this.name,
    required this.onTap,
  });

  @override
  State<PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends State<PlanCard> {
  ItineraryController controller=Get.find<ItineraryController>();
  @override
  Widget build(BuildContext context) {
    return Obx(()=> GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width:2,color:controller.selectedTheme.value== widget.id?ColoRRes.primary:Colors.white),
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.sp),
                    child:
                    CachedNetworkImage(
                      imageUrl: widget.imageUrl,
                      height: 23.h,
                      width: 28.w,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: Icon(Icons.image,size: 25,),
                      ),
                      errorWidget: (context, url, error) {
                        return Image.asset(
                          "assets/images/noImage.jpg",
                          fit: BoxFit.fill,
                          width: 100.w,
                          height: 100.h,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    left: 10.sp,
                    right: 10.sp,
                    bottom: 10.sp,
                    child:Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ColoRRes.white,
                          border: Border.all(width: 1, color: ColoRRes.borderColor)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal:1.5.sp, vertical: 10.sp),
                        child: AppTexts.inter24W600(
                          widget.name,
                          fontSize: 14,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          textColor: ColoRRes.textColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}