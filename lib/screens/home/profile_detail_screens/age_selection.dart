import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_out/controller/register_main_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common_screens/app_text.dart';
import '../../../common_screens/colors.dart';
import '../../../controller/profile_controller.dart';

class AgeSelection extends StatefulWidget {
  const AgeSelection({super.key});

  @override
  State<AgeSelection> createState() => _AgeSelectionState();
}

class _AgeSelectionState extends State<AgeSelection> {
  RegisterMainController controller=Get.find<RegisterMainController>();
  final FixedExtentScrollController scrollController = FixedExtentScrollController(initialItem: 25);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoRRes.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 3.h),
          const AppTexts.inter24W600(
            'How Old Are You?',
            textColor: ColoRRes.textColor,
          ),
          SizedBox(height: 1.h),
          const AppTexts.inter14W400(
            'Please enter your name to request a \nprofile creation',
            textColor: ColoRRes.subTextColor,
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 40.h,
            child: Stack(
              children: [
                Obx(()=>CupertinoPicker(
                  itemExtent: 60.0,
                  useMagnifier: true,
                  magnification: 1.0,
                  scrollController: scrollController,
                  looping: true,
                  selectionOverlay: Container(),
                  onSelectedItemChanged: (int index) {
                    controller.age.value = index;
                  },
                  children: List<Widget>.generate(100, (int index){
                    return Center(
                      child: AppTexts.inter14W400(
                        index.toString(),
                        fontSize: 50,
                        textColor: index ==  controller.age.value
                            ? ColoRRes.primary
                            : ColoRRes.textColor,
                      ),
                    );
                  }),
                ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 18.w,
                        height: 2,
                        color: ColoRRes.primary

                      ),
                      SizedBox(height: 6.h),
                      Container(
                        width: 18.w,
                        height: 2,
                          color: ColoRRes.primary
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )


        ],
      ),
    );
  }
}
