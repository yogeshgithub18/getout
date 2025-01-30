import 'package:flutter/material.dart';
import 'package:get_out/common_screens/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../common_screens/app_text.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 7.h,
      child: ElevatedButton(

        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: ColoRRes.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child:  AppTexts.inter18W500(
          label,
        ),
      ),
    );
  }
}
