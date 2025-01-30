import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_out/base_utils/base_overlays.dart';
import 'package:get_out/screens/home/profile_detail_screens/profile_picture.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common_screens/app_text.dart';
import '../../../common_screens/colors.dart';
import '../../../controller/register_main_controller.dart';
import '../../../custom_app_screen/custom_back_button.dart';
import '../../../custom_app_screen/custom_main_button.dart';
import '../../../routes/all_routes.dart';
import 'age_selection.dart';
import 'allow_location.dart';
import 'enter_name.dart';
import 'expand_network.dart';
import 'gender_selection_screen.dart';
import 'interest_selection.dart';

class ProFileCreatePage extends StatefulWidget {
  final String mobile;
  final String code;
  const ProFileCreatePage({super.key,required this.mobile,required this.code});

  @override
  State<ProFileCreatePage> createState() => _ProFileCreatePageState();
}

class _ProFileCreatePageState extends State<ProFileCreatePage> {
  RegisterMainController controller=Get.put(RegisterMainController()) ;
  final FocusNode focusNode = FocusNode();
  final FocusNode focusNodeB = FocusNode();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool isFocused = false;
  bool isFocusedB = false;

  @override
  void initState() {
    super.initState();
    controller.mobileNo.value=widget.mobile;
    controller.code=widget.code;
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


  final PageController pageController = PageController();
  int currentPage = 0;
  final int totalPages = 7;

  void nextPage() {
    if (currentPage < totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  void previousPage() {
    if (currentPage > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    print("current page--$currentPage") ;
    return Scaffold(
      backgroundColor: ColoRRes.white,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: (currentPage == 6)
          ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 25),
            child: CustomButton(
            label: "Continue",
            onPressed: () {
              controller.register();
           },
           ),
          )
          : (currentPage == 5)
          ? const SizedBox.shrink()
          : Padding(
             padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 25),
             child: Column(
             mainAxisSize: MainAxisSize.min,
           children: [
                CustomButton(
                label: currentPage == 3 ? "Allow Location Access" : "Continue",
                onPressed: () async {
                 if (currentPage == 3) {
                  await controller.getLocation();
                   nextPage();
                  } else {
                   if(currentPage==0 && (controller.firstName.value.text.isEmpty || controller.email.value.text.isEmpty)){
                     BaseOverlays().showSnackBar(message: "All fields are mandatory");
                     return;
                   }
                   if(currentPage==4 && controller.interests.length < 2 ){
                     BaseOverlays().showSnackBar(message: "Please select at least two interest");
                     return;
                   }
                   nextPage();
                 }
              },
             ),
             if (currentPage == 3)
                GestureDetector(
                onTap: () async {
                 await Get.toNamed(AllRoutesClass.getMapScreenRoute());
                 nextPage();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 15.sp),
                  width: double.infinity,
                  height: 7.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      width: 1,
                      color: ColoRRes.textColor,
                    ),
                  ),
                  child: const Center(
                    child: AppTexts.inter18W500(
                      'Don\'t Allow Location',
                      textColor: ColoRRes.textColor,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 28.sp,left: 15.sp,right: 15.sp),
        child: Column(
          children: [
            SizedBox(height: 3.h,),
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
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemCount: totalPages,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return  const NameEmailForm();
                  } else if (index == 1) {
                    return const GenderSelectionScreen();
                  } else if(index ==2){
                    return const AgeSelection();
                  } else if(index ==3){
                    return const AllowLocation();
                  }  else if(index==4){
                    return const InterestSelection();
                  } else if(index==5){
                    return ProfilePicture(next: (){
                      nextPage();
                    },);
                  } else if(index==6){
                    return const ExpandNetwork();
                  }
                  return Container();
                },
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
          margin: EdgeInsets.symmetric(horizontal: 6.sp),
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
