import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../common_screens/colors.dart';

class CustomChatContainer extends StatelessWidget {
  final String assetPath;
  const CustomChatContainer({
    super.key,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColoRRes.backGroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(14.sp),
        child: SvgPicture.asset(
          assetPath,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}