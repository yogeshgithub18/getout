import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_out/common_screens/colors.dart';
import 'package:get_out/controller/login_controller.dart';
import 'package:get_out/screens/login/verify_otp.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common_screens/app_text.dart';
import '../../../custom_app_screen/custom_back_button.dart';
import '../../../custom_app_screen/custom_main_button.dart';
import '../../../routes/all_routes.dart';
import '../../base_utils/base_overlays.dart';


class Login extends StatefulWidget {
  const Login({super.key,});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  LoginController controller=Get.find<LoginController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoRRes.white,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar:Padding(
        padding:  EdgeInsets.all(15.sp),
        child: CustomButton(
          label: "Continue",
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
                controller.loginCheck();
            }
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 15.sp,top: 25.sp,right: 15.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 3.h),
            CustomBackButton(
              onPressed: () {
                Get.back();
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.h),
                 AppTexts.inter24W600(
                  'Enter You Number',
                  fontSize: 24.sp,
                  textColor: ColoRRes.textColor,
                ),
                SizedBox(height: 1.h),
                const AppTexts. inter14W400(
                  'Provide Your Phone Number to Proceed with \nSecure Login',
                  textColor: ColoRRes.subTextColor,
                ),
                SizedBox(height: 5.h),
                Form(
                  key: _formKey,
                  child: Container(
                    height: 9.h,
                    decoration: BoxDecoration(
                      color: ColoRRes.backGroundColor,
                      borderRadius: BorderRadius.circular(15.sp),
                    ),
                    child: IntlPhoneField(
                      keyboardType: TextInputType.text,
                      controller: controller.mobileController.value,
                      dropdownIconPosition: IconPosition.trailing,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textAlignVertical: TextAlignVertical.bottom,
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
                        isDense: true,
                        contentPadding: EdgeInsets.only(top: 14.sp,left:16.sp,right: 10.sp),
                         alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15.sp),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.number.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      initialCountryCode: 'US',
                      onChanged: (phone) {
                        controller.countryCode.value = phone.countryCode;
                        print("------->>>${phone.countryCode}");
                      },
                      flagsButtonPadding: EdgeInsets.only(left:15.sp,top: 15.sp,),
                      flagsButtonMargin: EdgeInsets.only(top: 15.sp),
                      textAlign: TextAlign.start,  // Ensures text aligns well within the field
                    ),
                  ),
                ),
                SizedBox(height: 1.5.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

