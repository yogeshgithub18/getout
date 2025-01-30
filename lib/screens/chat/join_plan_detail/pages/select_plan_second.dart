import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_out/controller/itninerary_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common_screens/app_text.dart';
import '../../../../common_screens/colors.dart';
import '../../../home/home_main/company.dart';

class SelectPlanSecond extends StatefulWidget {
  const SelectPlanSecond({super.key});

  @override
  State<SelectPlanSecond> createState() => _SelectPlanSecondState();
}

class _SelectPlanSecondState extends State<SelectPlanSecond> {

  ItineraryController controller=Get.find<ItineraryController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 3.h),
        const AppTexts.inter24W600(
          'Select you Plan',
          textColor: ColoRRes.textColor,
        ),
        SizedBox(height: 1.h),
        const AppTexts.inter14W400(
          'Please enter your name to request a \n profile creation',
          textColor: ColoRRes.subTextColor,
        ),
       Obx(()=> Expanded(
          child: ReorderableListView(
            onReorder: (int oldIndex, int newIndex) {
              controller.reorder(oldIndex, newIndex);
            },
            children: [
              for (int index = 0; index < controller.selectedEvents.length; index++)
                ListTile(
                  key: ValueKey(controller.selectedEvents[index]),
                  title: GestureDetector(
                    onTap: (){
                      Get.to(()=>Company(id:controller.selectedEvents[index].placeId!));
                    },
                    child: CafeCard(
                      onTap:(){
                        controller.selectedEvents.removeAt(index);
                        controller.selectedEvents.refresh();
                      },
                      cafeName: controller.selectedEvents[index].name??'',
                      cafeLocation: controller.selectedEvents[index].vicinity??"",
                      time: "${controller.startTime} to ${controller.endTime}",
                      imageUrl:controller.selectedEvents[index].photo??'',
                    ),
                  ),
                ),
              // ListView.builder(
              //   itemCount: controller.selectedEvents.length,
              //   shrinkWrap: true,
              //   physics: const ClampingScrollPhysics(),
              //   itemBuilder: (context, index) {
              //     final cafe = controller.selectedEvents[index];
              //     return GestureDetector(
              //       onTap: (){
              //         Get.to(()=>Company(id:controller.selectedEvents[index].placeId!));
              //       },
              //       child: CafeCard(
              //         onTap:(){
              //           controller.selectedEvents.removeAt(index);
              //           controller.selectedEvents.refresh();
              //         },
              //         cafeName: cafe.name??'',
              //         cafeLocation: cafe.vicinity??"",
              //         time: "${controller.startTime} to ${controller.endTime}",
              //         imageUrl:cafe.photo??'',
              //       ),
              //     );
              //   },
              // )
            ],
          ),
        )
       ),
      ],
    );
  }
}


class CafeCard extends StatelessWidget {
  final String cafeName;
  final String cafeLocation;
  final String time;
  final String imageUrl;
  final Function () onTap;

  const CafeCard({
    super.key,
    required this.cafeName,
    required this.onTap,
    required this.cafeLocation,
    required this.time,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 14.sp),
          padding:  EdgeInsets.all(12.sp),
          decoration: BoxDecoration(
            color: ColoRRes.planColor,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: ColoRRes.primary, width: 0.5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  height: 8.h,
                  width: 15.w,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: Icon(
                      Icons.image,
                      size: 40, // Adjust icon size as needed
                      color: Colors.grey, // Customize icon color
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    "assets/images/noImage.jpg",
                    fit: BoxFit.fill,
                    height: 8.h,
                    width: 15.w,
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTexts.inter15W600(
                      cafeName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textColor: ColoRRes.textColor,
                    ),
                    SizedBox(height: 0.2.h),
                    AppTexts.inter12W400(
                      cafeLocation,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textColor: ColoRRes.subTextColor,
                    ),
                    SizedBox(height: 1.2.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
                      decoration: BoxDecoration(
                        color: ColoRRes.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.access_time_filled,
                            size: 16,
                            color: ColoRRes.primary,
                          ),
                          SizedBox(width: 1.w),
                          AppTexts.inter10W500(
                            time,
                            textColor: ColoRRes.textColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
         Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: onTap,
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(Icons.cancel),
            ),
          ),
        )
      ],
    );
  }
}



