import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_out/common_screens/colors.dart';
import 'package:get_out/controller/star_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common_screens/app_text.dart';
import '../../custom_app_screen/custom_rating_card.dart';
import '../../routes/all_routes.dart';
import '../home/home_main/company.dart';

class Subscribe extends StatefulWidget {
  const Subscribe({super.key});

  @override
  State<Subscribe> createState() => _SubscribeState();
}

class _SubscribeState extends State<Subscribe> {
  StarController controller=Get.find<StarController>();
  int selectedCardIndex = -1;

  void selectCard(int index) {
    Get.to(()=>Company(id:controller.activities[index].placeId!));
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           SizedBox(height: 3.h,),
           Obx(()=> Expanded(
               child: controller.activities.isEmpty?const Center(
                   child: Text("")
               ) :GridView.builder(
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,
                   childAspectRatio: 0.85,
                   mainAxisSpacing: 12.sp,
                   crossAxisSpacing: 12.sp,
                 ),
                 itemCount: controller.activities.length,
                 itemBuilder: (context, index) {
                   return CustomRatingCardCard(
                     imageUrl:controller.activities[index].photo!,
                     title: controller.activities[index].name??'',
                     owner: '',//activities[index]['owner']!,
                     distance:'22',//controller.activities[index].distanceMiles!.toStringAsFixed(2),
                     isSelected: selectedCardIndex == index,
                     onTap: () => selectCard(index),
                     onCloseTap: (){
                       controller.handleEvents(controller.activities[index].placeId!);
                       controller.activities.removeAt(index);
                       controller.activities.refresh();
                     },
                   );
                 },
               )))
        ],
      ),
    );
  }


}


