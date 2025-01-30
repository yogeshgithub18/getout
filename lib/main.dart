import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_out/routes/all_routes.dart';
import 'package:get_out/screens/home/home_main/bottom_navigation.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_strategy/url_strategy.dart';
final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

void main() {
  setPathUrlStrategy();
  HttpOverrides.global = MyHttpOverrides();
  runApp(
      ResponsiveSizer(
      builder: (context, orientation, screenType) {
      return const MyApp();
    },
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Get Out',
      navigatorObservers: [routeObserver],
      theme: ThemeData(
        useMaterial3: false,
      ),
      initialRoute: AllRoutesClass.getSplashScreenRoute(),
      getPages: AllRoutesClass.routes,
      //home: BottomNavigation(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}