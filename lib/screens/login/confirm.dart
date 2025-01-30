import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:get_out/routes/all_routes.dart';
import '../../../common_screens/colors.dart';
import '../home/home_main/bottom_navigation.dart';
import '../home/profile_detail_screens/profile_create_page.dart';

class Confirm extends StatelessWidget {
   final bool isNew;
   final String mobile;
   final String code;
   const Confirm({super.key,required this.isNew,required this.mobile,required this.code});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(milliseconds: 500), () {
      if(isNew){
         Get.offAll(()=> ProFileCreatePage(mobile:mobile, code:code,));
      }else{
        Get.offAll( ()=> const BottomNavigation());
      }
    });
    return Scaffold(
      backgroundColor: ColoRRes.primary,
      body: Center(
        child: FadeTransition(
          opacity: const AlwaysStoppedAnimation(1.0),
          child: SvgPicture.asset('assets/images/confirm.svg'),
        ),
      ),
    );
  }
}

class ConfirmSecond extends StatelessWidget {
  const ConfirmSecond({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(milliseconds: 300), () {
      Get.to( ()=> const BottomNavigation());
    });
    return Scaffold(
      backgroundColor: ColoRRes.primary,
      body: Center(
        child: FadeTransition(
          opacity: const AlwaysStoppedAnimation(1.0),
          child: SvgPicture.asset('assets/images/confirm.svg'),
        ),
      ),
    );
  }
}

class GroupConfirm extends StatelessWidget {
  const GroupConfirm({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(milliseconds: 300), () {

    });
    return Scaffold(
      backgroundColor: ColoRRes.primary,
      body: Center(
        child: FadeTransition(
          opacity: const AlwaysStoppedAnimation(1.0),
          child: SvgPicture.asset('assets/images/confirm.svg'),
        ),
      ),
    );
  }
}