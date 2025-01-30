import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_out/common_screens/colors.dart';
import 'package:get_out/routes/all_routes.dart';
import 'package:get_out/screens/login/signup.dart';
import 'package:get_out/storage/base_shared_preference.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common_screens/app_text.dart';
import '../../../custom_app_screen/custom_main_button.dart';

class UspScreens extends StatefulWidget {
  const UspScreens({super.key});

  @override
  State<UspScreens> createState() => _UspScreensState();
}

class _UspScreensState extends State<UspScreens> {
  final PageController pageController = PageController();
  int currentIndex = 0;

  final List<UspPageModel> pages = [
    UspPageModel(
      imagePath: 'assets/images/usp1.png',
      title: 'Discover Experiences with \n a simple swipe',
      description: 'Curated activities at your fingertips',
    ),
    UspPageModel(
      imagePath: 'assets/images/usp2In1img.png',
      title: 'Plan adventures and chat \n with friends in one',
      description: 'Effortless group planning made simple',
    ),
    UspPageModel(
      imagePath: 'assets/images/usp3in1img.png',
      title: 'Get Tailored suggestion \n Powered with AI',
      description: 'Tailored suggestions just for you',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoRRes.backGroundColor,
      body: Column(
        children: [
          SizedBox(height: 4.h,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical:30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: ColoRRes.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_rounded),
                    onPressed: () {
                      if (currentIndex > 0) {
                        pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    BaseSharedPreference().setBool("isFirst",false);
                    Get.offAll(()=>const Signup());
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: 0.5,
                        color: ColoRRes.borderColor,
                      ),
                    ),
                    child:  const AppTexts.inter15W400('Skip'),
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
              pages[currentIndex].imagePath,
              height: 45.h,
            ),
          SizedBox(height: 5.h,),
          DotsIndicator(currentIndex: currentIndex, totalDots: 3),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return UspImageTextPage(
                  model: pages[index],
                  currentIndex: currentIndex,
                );
              },
            ),
          ),
          SizedBox(height: 3.h),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomButton(
              label: "Continue",
              onPressed: () {
                if (currentIndex < pages.length - 1) {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                } else {
                  BaseSharedPreference().setBool("isFirst",false);
                  Get.offAll(()=>const Signup());
                }
              },
            ),
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }
}

class UspPageModel {
 // final List<String> images; // Change to List of Strings for images
  final String title;
  final String description;
  final String imagePath;


  UspPageModel({
    required this.title,
    required this.description,
    required this.imagePath,

  });
}


class UspImageTextPage extends StatelessWidget {
  final UspPageModel model;
  final int currentIndex;

  const UspImageTextPage({
    super.key,
    required this.model,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // if (currentIndex == 1) // For the second index
          //   Column(
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: model.images.length > 1
          //             ? model.images.sublist(0, 2).map((image) {
          //           return Image.asset(image, height: 25.h);
          //         }).toList()
          //             : [],
          //       ),
          //       SizedBox(height: 2.h),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: model.images.length > 3
          //             ? model.images.sublist(2, 4).map((image) {
          //           return Image.asset(image, height: 25.h);
          //         }).toList()
          //             : [],
          //       ),
          //     ],
          //   )
          // else if (currentIndex == 2) // For the third index
          //   Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: model.images.map((image) {
          //       return Image.asset(image, height: 25.h);
          //     }).toList(),
          //   )
          // else // For the first index
          //SizedBox(height: 5.h),
          AppTexts.inter24W600(model.title, textAlign: TextAlign.center,),
          SizedBox(height: 2.h),
          AppTexts.inter15W400(
            model.description,
            fontSize: 16,
            textColor: ColoRRes.black.withOpacity(0.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}




class DotsIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalDots;

  const DotsIndicator({
    super.key,
    required this.currentIndex,
    required this.totalDots,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalDots, (index) {
        final double opacity = index <= currentIndex ? 1.0 : 0.2; // Adjust opacity based on index
        return Container(
          margin: EdgeInsets.all(1.w),
          width: 10.w,
          height: 0.8.h,
          decoration: BoxDecoration(
            color: ColoRRes.indicatorColor.withOpacity(opacity), // Apply opacity
            borderRadius: BorderRadius.circular(100),
          ),
        );
      }),
    );
  }
}
