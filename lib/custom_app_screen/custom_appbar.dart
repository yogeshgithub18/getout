// import 'package:flutter/material.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
//
// import '../common_screens/app_text.dart';
// import '../common_screens/colors.dart';
// import 'custom_appbar_container.dart';
//
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final String leadingIconPath;
//   final String actionIconPath;
//   final VoidCallback? onLeadingIconPressed;
//   final VoidCallback? onActionIconPressed;
//
//   const CustomAppBar({
//     super.key,
//     required this.title,
//     required this.leadingIconPath,
//     required this.actionIconPath,
//     this.onLeadingIconPressed,
//     this.onActionIconPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: ColoRRes.white,
//       elevation: 0,
//       leading: Padding(
//         padding: EdgeInsets.only(left: 15.sp, top: 12.5.sp, bottom: 8.sp),
//         child: IconButton(
//           icon: CustomChatContainer(assetPath: leadingIconPath),
//           onPressed: onLeadingIconPressed,
//         ),
//       ),
//       title: Container(
//         alignment: Alignment.center,
//         child: AppTexts.inter16W600(title),
//       ),
//       centerTitle: true,
//       actions: [
//         Padding(
//           padding: EdgeInsets.only(right: 15.sp, top: 14.sp),
//           child: IconButton(
//             icon: CustomChatContainer(assetPath: actionIconPath),
//             onPressed: onActionIconPressed,
//           ),
//         ),
//       ],
//     );
//   }
//
//   @override
//   Size get preferredSize => const Size.fromHeight(56.0); // Adjust height as needed
// }
//
