import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_out/common_screens/app_text.dart';
import 'package:get_out/controller/home_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../common_screens/colors.dart';
import '../../../custom_app_screen/custom_main_button.dart';



class HomeSearch extends StatefulWidget {
  const HomeSearch({super.key});

  @override
  State<HomeSearch> createState() => _HomeSearchState();
}

class _HomeSearchState extends State<HomeSearch> {
  HomeController controller=Get.find<HomeController>();

  @override
  void initState() {
    // TODO: implement initState
    // controller.selectedInterests.value=[];
    controller.searchKeywordController.value.text='';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoRRes.white,
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.all(15.sp),
        child: CustomButton(
          label: "Save",
          onPressed: () {
            Get.back(result: true);
          },
        ),
      ),
      body: Obx(()=>Padding(
        padding:  EdgeInsets.all(15.sp),
        child: Column(
          children: [
            SizedBox(height: 3.h),
            Container(
              margin: EdgeInsets.only(top: 24.sp),
              height: 6.h,
              decoration: BoxDecoration(
                color: ColoRRes.backGroundColor,
                borderRadius: BorderRadius.circular(35.sp),
              ),
              child: TextField(
                controller: controller.searchKeywordController.value,
                cursorColor: ColoRRes.black,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 16.sp, right: 16.sp),
                    child: SvgPicture.asset('assets/images/search.svg'),
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 10.sp),
                    child: GestureDetector(
                      onTap: () {
                      },
                      child: Container(
                        padding: EdgeInsets.all(14.sp),
                        decoration: const BoxDecoration(
                            color: ColoRRes.primary, shape: BoxShape.circle),
                        child: SvgPicture.asset(
                          'assets/chat/searchSetting.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    color: ColoRRes.textSubColor,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 19.sp, horizontal: 15.sp),
                ),
              ),
            ),
            SizedBox(height: 3.h),
            Container(
              width: double.infinity,
              height: 1,
              color: ColoRRes.dividerColor,
            ),
            SizedBox(height: 2.5.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppTexts.inter18W600('Radius', fontSize: 20,),
                    Obx(()=>SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 6,
                        thumbColor: ColoRRes.sliderColor,
                        activeTrackColor: ColoRRes.primary,
                      ),
                      child: Slider(
                        value:double.parse(controller.rangeSliderValue.value)/1000,
                        min: 1.00,
                        max: 60.00,
                        divisions:10,
                        inactiveColor: ColoRRes.backGroundColor,
                        label: '${(double.parse(controller.rangeSliderValue.value)/1000).toInt()} mile',
                        onChanged: (values) {
                          print(">>>>>>${values.toInt()}");
                          controller.rangeSliderValue.value=(values.toInt()*1000).toString();
                        },
                      ),
                    )),
                    SizedBox(height: 3.h),
                    const AppTexts.inter18W600('Interest', fontSize: 20,),
                    SizedBox(height: 1.5.h),
                    Wrap(
                      spacing: 18,
                      runSpacing: 6,
                      children: controller.interestList.map((interest) {
                        bool isSelected = controller.selectedInterests.contains(interest.id!);
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
                            setState(() {
                              if (selected) {
                                controller.selectedInterests.add(interest.id!);
                              } else {
                                controller.selectedInterests.remove(interest.id!);
                              }
                            });
                          },
                          selectedColor: ColoRRes.primary,
                          backgroundColor: ColoRRes.white,
                          showCheckmark: false,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
      ),
    );
  }
}
