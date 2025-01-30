import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_out/controller/register_main_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common_screens/app_text.dart';
import '../../../common_screens/colors.dart';

class InterestSelection extends StatefulWidget {
  const InterestSelection({super.key});

  @override
  State<InterestSelection> createState() => _InterestSelectionState();
}

class _InterestSelectionState extends State<InterestSelection> {
  RegisterMainController controller=Get.find<RegisterMainController>();

  @override
  void initState() {
    // TODO: implement initState
    controller.getCategory();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoRRes.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 3.h),
          const AppTexts.inter24W600(
            'Select your Interest',
            textColor: ColoRRes.textColor,
          ),
          SizedBox(height: 1.h),
          const AppTexts.inter14W400(
            'Choose Your Interests to Tailor \nYour Experience"',
            textColor: ColoRRes.subTextColor,
          ),
          SizedBox(height: 4.h),

        Obx(()=>  Expanded(
            child: Wrap(
              spacing: 18,
              runSpacing: 6,
              children: controller.interestList.map((interest) {
                bool isSelected = controller.interests.contains(interest.id);
                return ChoiceChip(
                  labelStyle:   TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontFamily: 'Plus Jakarta Sans',
                    color: isSelected ? Colors.white : ColoRRes.textColor,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color:isSelected ?  ColoRRes.primary:ColoRRes.textColor.withOpacity(0.3)
                    ),
                  ),
                  label: Text(interest.title??''),
                  selected: isSelected,
                  onSelected: (selected) {
                      if (selected) {
                        controller.interests.add(interest.id!);
                      } else {
                        controller.interests.remove(interest.id);
                      }
                  },
                  selectedColor: ColoRRes.primary,
                  backgroundColor: ColoRRes.white,
                  showCheckmark: false,
                );
              }).toList(),
            ),
          )),
        ],
      ),
    );
  }
}
