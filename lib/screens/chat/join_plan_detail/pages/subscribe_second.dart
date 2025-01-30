import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_out/controller/chat_controller.dart';
import 'package:get_out/controller/itninerary_controller.dart';
import 'package:get_out/controller/star_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common_screens/colors.dart';
import '../../../../controller/add_library_controller.dart';
import '../../../../controller/base_controller.dart';
import '../../../../custom_app_screen/custom_rating_card.dart';
import '../../../home/home_main/company.dart';
import '../../user_chating.dart';

class SubscribeSecond extends StatefulWidget {
  const SubscribeSecond({super.key});

  @override
  State<SubscribeSecond> createState() => _SubscribeSecondState();
}

class _SubscribeSecondState extends State<SubscribeSecond> {
  AddLibraryController controller = Get.find<AddLibraryController>();
  int selectedCardIndex = -1;
  void selectCard(int index) {
    Get.to(() => Company(id: controller.activities[index].placeId!));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 3.h,
          ),
          Obx(() => Expanded(
                  child: Stack(children: [
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    mainAxisSpacing: 12.sp,
                    crossAxisSpacing: 12.sp,
                  ),
                  itemCount: controller.activities.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.only(right: 2.5.w),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.sp),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16.sp),
                                    child: CachedNetworkImage(
                                      imageUrl: controller.activities[index].photo ?? '',
                                      height: 18.h,
                                      width: 36.w,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Center(
                                        child: Icon(Icons.image,size: 25,),
                                      ),
                                      errorWidget: (context, url, error) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: ColoRRes.borderColor),
                                            borderRadius: BorderRadius.circular(12.sp),
                                          ),
                                          child: Image.asset(
                                            "assets/images/noImage.jpg",
                                            fit: BoxFit.fill,
                                            height: 18.h,
                                            width: 36.w,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    left: 10.sp,
                                    right: 10.sp,
                                    bottom: 10.sp,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              if (controller.selectedEvents.contains(controller.activities[index])) {
                                                controller.selectedEvents.remove(controller.activities[index]);
                                              } else {
                                                controller.selectedEvents.add(controller.activities[index]);
                                              }
                                            },
                                            child: Obx(() => buildIconContainer(
                                              controller
                                                          .selectedEvents
                                                          .contains(controller
                                                          .activities[
                                                              index])
                                                      ? 'assets/home/close.svg'
                                                      : 'assets/home/add.svg',
                                                  ColoRRes.primary,
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ));
                  },
                ),
                // if (selectedCardIndex != -1)
                //   Positioned(
                //     bottom: 18.sp,
                //     left: 0.sp,
                //     right: 0.sp,
                //     child: Row(
                //       children: [
                //         Expanded(
                //           child: GestureDetector(
                //             onTap: () {
                //               Get.toNamed(AllRoutesClass.getOverallRatingRoute());
                //             },
                //             child: Container(
                //               padding: EdgeInsets.symmetric(horizontal: 25.sp, vertical: 16.sp),
                //               decoration: BoxDecoration(
                //                 color: ColoRRes.chatStarColor,
                //                 borderRadius: BorderRadius.circular(15.sp),
                //                 border: Border.all(
                //                   width: 1,
                //                   color: ColoRRes.white,
                //                 ),
                //               ),
                //               child: const Center(child: AppTexts.inter18W500('Write Review')),
                //             ),
                //           ),
                //         ),
                //         SizedBox(width: 12.sp),
                //         Expanded(
                //           child: GestureDetector(
                //             onTap: () {
                //
                //             },
                //             child: Container(
                //               padding: EdgeInsets.symmetric(horizontal: 25.sp, vertical: 16.sp),
                //               decoration: BoxDecoration(
                //                 color: ColoRRes.primary,
                //                 borderRadius: BorderRadius.circular(15.sp),
                //                 border: Border.all(
                //                   width: 1,
                //                   color: ColoRRes.white,
                //                 ),
                //               ),
                //               child: const Center(child: AppTexts.inter18W500('Open')),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
              ])))
        ],
      ),
    );
  }

  Widget buildIconContainer(String assetPath, Color color) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
          border: Border.all(width: 1, color: ColoRRes.white)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.5.sp, vertical: 10.sp),
        child: SvgPicture.asset(
          assetPath,
          height: 2.h,
          // width: 2.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
