import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_out/base_utils/base_overlays.dart';
import 'package:get_out/common_screens/colors.dart';
import 'package:get_out/controller/login_controller.dart';
import 'package:get_out/screens/login/verify_otp.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common_screens/app_text.dart';
import '../../../custom_app_screen/custom_main_button.dart';
import '../../../routes/all_routes.dart';
import 'login.dart';


class Signup extends StatefulWidget {
  const Signup({super.key,});

  @override
  State<Signup> createState() => SignupState();
}

class SignupState extends State<Signup> {
  LoginController loginController=Get.put(LoginController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoRRes.backGroundColor,
      resizeToAvoidBottomInset: true,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset('assets/images/login_card.png'),
          Container(
            height: 18.h,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.5),
                  blurRadius: 15.0,
                  offset: const Offset(0, -4),
                ),
              ],
            ),),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 18.h,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(1),
                    blurRadius: 15.0,
                    offset: const Offset(0,20),
                  ),
                ],
              ),),
          ),
          SingleChildScrollView(
            reverse: true,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: ColoRRes.textColor),
                      borderRadius: BorderRadius.circular(30.sp),
                      color: ColoRRes.white,
                      boxShadow: [
                        BoxShadow(
                          color: ColoRRes.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, -4),
                        ),
                      ],

                    ),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 24.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset( 'assets/images/logo.png' ,height: 66,width: 66,fit: BoxFit.contain,),
                        SizedBox(height: 2.h),
                        const AppTexts.inter16W600(
                          'Get Started',
                          fontSize: 28,
                        ),
                        SizedBox(height: 2.h),
                        AppTexts.inter15W400(
                          'Start your journey towards success with our \nexpert-led programs',
                          textColor: ColoRRes.black.withOpacity(0.5),
                        ),
                        SizedBox(height: 5.h),
                       GestureDetector(
                         onTap: (){
                           Get.to(()=>const Login());
                         },
                         child:
                         Container(
                          height: 9.h,
                          decoration: BoxDecoration(
                            color: ColoRRes.backGroundColor,
                            borderRadius: BorderRadius.circular(15.sp),
                          ),
                          child: AbsorbPointer(
                            absorbing: true,
                            child: IntlPhoneField(
                               readOnly: true,
                              dropdownIconPosition:IconPosition.trailing,
                              textAlignVertical: TextAlignVertical.bottom, // Centers text vertically in the TextField
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Enter your number',
                                hintStyle: TextStyle(
                                  fontSize: 18.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                               // isDense: true, // Reduces the size of padding for better control over alignment
                                contentPadding: EdgeInsets.only(top:20.sp,right:10.sp),
                                alignLabelWithHint: true, // Ensures hint text aligns correctly
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15.sp),
                                ),
                              ),
                              initialCountryCode: 'US', // Set initial country code
                              onChanged: (phone) {
                                print("------->>>${phone.completeNumber}"); // Handle selected phone number with country code
                              },
                              flagsButtonPadding: EdgeInsets.only(left:15.sp,top: 15.sp),
                              flagsButtonMargin: EdgeInsets.only(top: 15.sp),// Adjust spacing
                            ),
                          ),
                                               ),
                       ),
                      SizedBox(height: 1.5.h),
                        CustomButton(
                          label: "Continue with number",
                          onPressed: () {
                            Get.to(()=>const Login());
                          // if(loginController.mobileController.value.text.length==10) {
                          //  // loginController.loginCheck();
                          //     Get.to(()=>const Login());
                          //    }else{
                          //    BaseOverlays().showSnackBar(message: "Enter valid mobile no.");
                          //  }
                          },
                        ),
                        SizedBox(height: 1.5.h),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomIconContainer(
                              image: 'assets/images/google.png',
                            ),
                            CustomIconContainer(
                              image: 'assets/images/apple.png',
                            ),
                            CustomIconContainer(
                              image: 'assets/images/facebook.png',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomIconContainer extends StatelessWidget {
  final String image;

  const CustomIconContainer({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.sp, vertical: 18.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColoRRes.textColor,
      ),
      child: Image.asset(image,),
    );
  }
}
