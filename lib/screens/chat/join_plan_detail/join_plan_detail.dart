import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_out/base_utils/base_overlays.dart';
import 'package:get_out/controller/itninerary_controller.dart';
import 'package:get_out/screens/chat/join_plan_detail/pages/event_name.dart';
import 'package:get_out/screens/chat/join_plan_detail/pages/select_location.dart';
import 'package:get_out/screens/chat/join_plan_detail/pages/select_plan_second.dart';
import 'package:get_out/screens/chat/join_plan_detail/pages/select_theme.dart';
import 'package:get_out/screens/chat/join_plan_detail/pages/select_time.dart';
import 'package:get_out/screens/chat/join_plan_detail/pages/select_you_plan.dart';
import 'package:get_out/screens/home/profile_detail_screens/profile_picture.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common_screens/app_text.dart';
import '../../../common_screens/colors.dart';
import '../../../custom_app_screen/custom_back_button.dart';
import '../../../custom_app_screen/custom_main_button.dart';
import '../../../routes/all_routes.dart';
import '../../home/profile_detail_screens/enter_name.dart';
import '../generate_itinerary.dart';


class JoinPlanDetail extends StatefulWidget {
  final String page;
  final String type;
  final String from;
  final String placeId;
  const JoinPlanDetail({super.key,required this.page,required this.from,required this.type,required this.placeId});

  @override
  State<JoinPlanDetail> createState() => _JoinPlanDetailState();
}

class _JoinPlanDetailState extends State<JoinPlanDetail> {
   ItineraryController controller=Get.put(ItineraryController());
  final FocusNode focusNode = FocusNode();
  final FocusNode focusNodeB = FocusNode();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
   final PageController pageController = PageController();
   int currentPage = 0;
   int totalPages =0;
  bool isFocused = false;
  bool isFocusedB = false;

  @override
  void initState() {
    super.initState();
    print("Catt----${widget.type}");
    totalPages =widget.page=='home'?6:5;
    controller.catType.value=widget.type;
    controller.placeId.value=widget.placeId;
    controller.from.value=widget.from;
    focusNode.addListener(() {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    });
    focusNodeB.addListener(() {
      setState(() {
        isFocusedB = focusNodeB.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    focusNodeB.dispose();
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }




   void nextPage() {
     print("currentPage--$currentPage");
     if (currentPage < totalPages - 1) {
       if(widget.page=='home') {
         if (currentPage == 0 && controller.eventController.value.text.isEmpty) {
           BaseOverlays().showSnackBar(message: "Enter event name");
           return;
         }
         if (currentPage == 1 && controller.lat.value.isEmpty) {
           BaseOverlays().showSnackBar(message: "Select location");
           return;
         }
         if (currentPage == 2 && controller.selectedTheme.value.isEmpty) {
           BaseOverlays().showSnackBar(message: "Select theme");
           return;
         }
         if (currentPage == 3 && controller.selectedEvents.isEmpty) {
           BaseOverlays().showSnackBar(
               message: "Please select at least one place");
           return;
         }
         if (currentPage == 4 && controller.selectedEvents.isEmpty) {
           BaseOverlays().showSnackBar(
               message: "Please select at least one place");
           return;
         }
       }else{
         if (currentPage == 0 && controller.eventController.value.text.isEmpty) {
           BaseOverlays().showSnackBar(message: "Enter event name");
           return;
         }
         if (currentPage == 1 && controller.lat.value.isEmpty) {
           BaseOverlays().showSnackBar(message: "Select location");
           return;
         }
         if (currentPage == 2 && controller.selectedEvents.isEmpty) {
           BaseOverlays().showSnackBar(
               message: "Please select at least one place");
           return;
         }
         if (currentPage == 3 && controller.selectedEvents.isEmpty) {
           BaseOverlays().showSnackBar(
               message: "Please select at least one place");
           return;
         }
       }
       pageController.nextPage(
         duration: const Duration(milliseconds: 300),
         curve: Curves.easeInOut,
       );
     } else {
       controller.generateItinerary();
     }
   }
  void previousPage() {
    if (currentPage == 0) {
      Get.back();
    } else if (currentPage > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoRRes.white,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 25),
        child: CustomButton(
          label: "Continue",
          onPressed: () {
              nextPage();
            }
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 28.sp,left: 15.sp,right: 15.sp),
        child: Column(
          children: [
            SizedBox(height: 3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBackButton(
                  onPressed:previousPage,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.sp),
                  child: indicator(),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal:15.sp,vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                            width: 0.5,
                            color:ColoRRes.borderColor
                        )
                    ),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${currentPage + 1}/',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: ColoRRes.textColor,
                            ),
                          ),
                          TextSpan(
                            text: '$totalPages',
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                              color: ColoRRes.subTextColor,
                            ),
                          ),
                        ],
                      ),
                    )
                )
              ],
            ),
            Expanded(
              child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemCount: totalPages,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (widget.page == 'home') {
                      if (index == 0) {
                        return const EventName();
                      } else if (index == 1) {
                        return const SelectLocation();
                      } else if (index == 2) {
                        return const SelectTheme();
                      } else if (index == 3) {
                        return const SelectYouPlan(page:'home');
                      } else if (index == 4) {
                        return const SelectTime();
                      } else if (index == 5) {
                        return const SelectPlanSecond();
                      }
                      return Container();
                    } else {
                      if (index == 0) {
                        return const EventName();
                      } else if (index == 1) {
                        return const SelectLocation();
                      } else if (index == 2) {
                        return const SelectYouPlan(page: 'chat',);
                      } else if (index == 3) {
                        return const SelectTime();
                      } else if (index == 4) {
                        return const SelectPlanSecond();
                      }
                      return Container();
                    }
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget indicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal: 9.sp),
          height: 9.sp,
          width: (MediaQuery.of(context).size.width - 57.sp) / totalPages,
          decoration: BoxDecoration(
            color: index <= currentPage ? ColoRRes.indicatorColor : ColoRRes.inColor,
            borderRadius: BorderRadius.circular(100),
          ),
        );
      }),
    );
  }
}
