import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_out/common_screens/colors.dart';
import 'package:get_out/controller/login_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common_screens/app_text.dart';
import '../../../custom_app_screen/custom_back_button.dart';
import '../../../custom_app_screen/custom_main_button.dart';
import '../../../routes/all_routes.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({super.key,});

  @override
  State<VerifyOtp> createState() => VerifyOtpState();
}

class VerifyOtpState extends State<VerifyOtp> {
  LoginController loginController=Get.find<LoginController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoRRes.white,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(15.sp),
        child: CustomButton(
          label: "Verify",
          onPressed: () {
            if(loginController.otpController.value.text.length==4) {
              loginController.otpVerify();
            }
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 15.sp, top: 25.sp, right: 15.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 3.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBackButton(
                  onPressed: () {
                    Get.back();
                  },
                ),
                SizedBox(height: 5.h),
                AppTexts.inter24W600(
                  'Verification Code',
                  fontSize: 24.sp,
                  textColor: ColoRRes.textColor,
                ),
                SizedBox(height: 1.h),
                const AppTexts.inter14W400(
                  'The OTP code was sent to your phone.\nPlease enter the code',
                  textColor: ColoRRes.subTextColor,
                ),
                SizedBox(height: 5.h),
                PinCodeTextField(
                  controller: loginController.otpController.value,
                  autoDisposeControllers: false,
                  textStyle: const TextStyle(
                    color: ColoRRes.textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                  length: 4,
                  autoFocus: true,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  cursorColor: ColoRRes.textColor,
                  animationType: AnimationType.fade,
                  autovalidateMode: loginController.otpController.value.text.length == 5 ? AutovalidateMode.always : AutovalidateMode.disabled,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    inactiveColor: ColoRRes.textColor,
                    fieldWidth: 14.w,
                    fieldHeight: 7.h,
                    activeBorderWidth: 0.5,
                    selectedBorderWidth: 0.5,
                    inactiveBorderWidth: 0.5,
                    disabledColor: ColoRRes.textColor,
                    activeColor: ColoRRes.textColor,
                    selectedFillColor: ColoRRes.backGroundColor,
                    inactiveFillColor:
                    ColoRRes.backGroundColor,
                    selectedColor:
                    ColoRRes.textColor,
                    activeFillColor:
                    ColoRRes.backGroundColor,
                    errorBorderColor: Colors.red,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onCompleted: (v) {
                    debugPrint("Completed");
                  },
                  validator: (otp) {
                    return null;
                  },
                  onChanged: (value) {
                    debugPrint(value);
                  },
                  beforeTextPaste: (text) {
                    return true;
                  },
                  appContext: context,
                ),

              ],
            ),
            SizedBox(height: 6.h),
            const AppTexts.inter14W400(
              'Didn\'t receive OTP?',
              textColor: ColoRRes.subTextLightColor,
            ),
            SizedBox(height: 1.h),
            GestureDetector(
              onTap: (){
                loginController.otpController.value.text='';
                loginController.resendCode();
              },
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: ColoRRes.indicatorColor,
                      width: 1,
                    ),
                  ),
                ),
                child: const AppTexts.inter14W400(
                  'Resend code',
                  textColor:ColoRRes.indicatorColor,
                ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
