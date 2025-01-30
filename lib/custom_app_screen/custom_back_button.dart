import 'package:flutter/material.dart';
import 'package:get_out/common_screens/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomBackButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColoRRes.backGroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back_rounded,color: ColoRRes.textColor,),
        onPressed: onPressed,
      ),
    );
  }
}
