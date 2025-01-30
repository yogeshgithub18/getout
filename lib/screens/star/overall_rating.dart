
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common_screens/app_text.dart';
import '../../common_screens/colors.dart';
import '../../custom_app_screen/custom_appbar_container.dart';
import '../../custom_app_screen/custom_main_button.dart';


class OverallRating extends StatefulWidget {
  const OverallRating({super.key});

  @override
  State<OverallRating> createState() => _OverallRatingState();
}

class _OverallRatingState extends State<OverallRating> {
  late TextEditingController reviewController;

  String selectedOption = '';
  bool isAnonymous = false;
  bool switchValue1 = false;
  final ImagePicker picker = ImagePicker();

  Future<void> chooseFile(BuildContext context) async {
    final XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (file != null) {
      print('Selected file path: ${file.path}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File selected: ${file.name}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No file selected')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColoRRes.white,
      appBar: AppBar(
        backgroundColor: ColoRRes.white,
        elevation: 0,
        leading: GestureDetector(
            onTap: (){
              Get.back();
            },
          child: Padding(
              padding: EdgeInsets.only(left: 15.sp, top: 12.5.sp, bottom: 8.sp),
              child: const CustomChatContainer(
                assetPath: 'assets/chat/back.svg',
              )),
        ),
        title: Container(
          alignment: Alignment.center,
          child: const AppTexts.inter16W600(
            'Overall Rating',
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
              padding: EdgeInsets.only(
                right: 15.sp,
                top: 14.sp,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: ColoRRes.backGroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(14.sp),
                  child: const Icon(
                    Icons.close_rounded,
                    color: ColoRRes.textColor,
                    size: 22,
                  ),
                ),
              ))
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(15.sp),
        child: CustomButton(
          label: "Submit",
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 1.h,
            ),
            const AppTexts.inter12W500('Review Title'),
            SizedBox(
              height: 1.5.h,
            ),
            Container(
              height: 7.h,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: ColoRRes.backGroundColor,
                ),
                borderRadius: BorderRadius.circular(15.sp),
              ),
              child: TextField(

                cursorColor: ColoRRes.black,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: 'Example: Easy to use',
                  hintStyle: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: ColoRRes.subTextColor,
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 18.sp, horizontal: 18.sp),
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            const AppTexts.inter12W500(
                'Would you recommend this product to a friend?'),
            SizedBox(
              height: 1.5.h,
            ),
            Row(
              children: [
                buildOption('Yes'),
                SizedBox(width: 2.5.h),
                buildOption('No'),
              ],
            ),
            SizedBox(
              height: 4.h,
            ),
            const AppTexts.inter12W500('Give you Review'),
            SizedBox(
              height: 1.5.h,
            ),
            Container(
              height: 12.h,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: ColoRRes.backGroundColor,
                ),
                borderRadius: BorderRadius.circular(15.sp),
              ),
              child: TextField(

                cursorColor: ColoRRes.black,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  hintText: 'Give you Review.....',
                  hintStyle: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: ColoRRes.subTextColor,
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 18.sp, horizontal: 18.sp),
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            DottedBorder(
              color: ColoRRes.black,
              borderType: BorderType.RRect,
              radius: const Radius.circular(10),
              strokeWidth: 0.6,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.sp,vertical: 14.sp),
                decoration: BoxDecoration(
                  color: ColoRRes.selectDocColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [

                    GestureDetector(
                      onTap: (){ chooseFile(context);},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: ColoRRes.primary
                        ),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal:14.sp,vertical: 10.sp),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset('assets/images/cameraUpload.png',),
                              SizedBox(width: 1.w),
                              const AppTexts.inter12W400('Choose a File',textColor: ColoRRes.white,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    const AppTexts.inter12W400(
                      'Upload the front side of your document Support: JPG, PNG',
                      textColor: ColoRRes.docTextColor,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Row(
              children: [
                Transform.scale(
                  scale: 1.2,
                  child: Switch.adaptive(
                    activeColor: ColoRRes.white,
                    trackOutlineColor:
                    MaterialStateColor.resolveWith((states) => Colors.transparent),
                    inactiveTrackColor: ColoRRes.backGroundColor,
                    inactiveThumbColor: ColoRRes.backGroundColor,
                    activeTrackColor: ColoRRes.primary,
                    inactiveThumbImage: const AssetImage(
                        'assets/images/inactivethumb.png'),
                    value: switchValue1,
                    onChanged: (value) {
                      setState(() {
                        switchValue1 = value;
                      });
                    },
                  ),),
                SizedBox(width: 1.w),
                const AppTexts.inter12W400('Make it anonymous'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildOption(String option) {
    bool isSelected = selectedOption == option;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = option;
        });
      },
      child: Row(
        children: [
          Container(
            height: 2.5.h,
            width: 2.5.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 0.5,
                color: isSelected
                    ? ColoRRes.indicatorColor
                    : ColoRRes.radioButtonColor,
              ),
            ),
            child: isSelected
                ? Container(
              height: 2.5.h,
              width: 2.5.h,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: ColoRRes.white),
                      shape: BoxShape.circle,
                      color: ColoRRes.indicatorColor,
                    ),
                  )
                : null,
          ),
          SizedBox(width: 1.h),
          AppTexts.inter10W500(option, textColor: ColoRRes.black),
        ],
      ),
    );
  }
}
