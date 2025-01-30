import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_out/routes/all_routes.dart';
import 'package:get_out/storage/base_shared_preference.dart';
import 'package:get_out/usp/usp_first.dart';
import '../common_screens/colors.dart';
import '../screens/home/home_main/bottom_navigation.dart';
import '../screens/login/login.dart';
import '../screens/login/signup.dart';
import '../storage/sp_keys.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds:2), () async {
      bool isFirst=await BaseSharedPreference().getBool("isFirst")??true;
      if(isFirst){
        Get.offAll(()=>const UspScreens());
      }else{
        if (await BaseSharedPreference().getBool(SpKeys().isLoggedIn) ?? false) {
          Get.offAll( ()=> const BottomNavigation());
         } else {
          Get.offAll( const Signup());
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xffFFF1E0 ),
      body: Center(
        child: SvgPicture.asset('assets/images/splash1.svg'),
      ),
    );
  }
}
