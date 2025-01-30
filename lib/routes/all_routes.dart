
import 'package:get/get.dart';
import '../screens/chat/join_plan_detail/join_plan_detail.dart';
import '../screens/chat/open_profile.dart';
import '../screens/home/home_main/bottom_navigation.dart';
import '../screens/home/home_main/home.dart';
import '../screens/home/profile_detail_screens/enter_name.dart';
import '../screens/home/profile_detail_screens/map_screen.dart';
import '../screens/home/profile_detail_screens/profile_create_page.dart';
import '../screens/login/confirm.dart';
import '../screens/login/login.dart';
import '../screens/login/signup.dart';
import '../screens/login/verify_otp.dart';
import '../screens/star/overall_rating.dart';
import '../usp/splash_screen.dart';
import '../usp/usp_first.dart';


class AllRoutesClass{

  static String splashScreen = "/";
  static String home = "/home";
  static String uspScreens = "/uspScreens";
  static String login = "/login";
  static String verifyOtp = "/verifyOtp";
  static String confirm = "/confirm";
  static String nameEmailForm = "/nameEmailForm";
  static String proFileMainPage = "/proFileMainPage";
  static String confirmSecond = "/confirmSecond";
  static String bottomNavigation = "/bottomNavigation";
  static String mapScreen = "/mapScreen";
  static String signup = "/signup";
  static String openProfile = "/openProfile";
  static String overallRating = "/overallRating";
  static String groupConfirm = "/groupConfirm";
  static String joinPlanDetail = "/joinPlanDetail";





  static String getSplashScreenRoute() => splashScreen;
  static String getHomeRoute() => home;
  static String getUspScreensRoute() => uspScreens;
  static String getLoginRoute() => login;
  static String getVerifyOtpRoute() => verifyOtp;
  static String getConfirmRoute() => confirm;
  static String getConfirmSecondRoute() => confirmSecond;
  static String getNameEmailFormRoute() => nameEmailForm;
  static String getProFileMainPageRoute() => proFileMainPage;
  static String getBottomNavigationRoute() => bottomNavigation;
  static String getMapScreenRoute() => mapScreen;
  static String getSignupRoute() => signup;
  static String getOpenProfileRoute() => openProfile;
  static String getOverallRatingRoute() => overallRating;
  static String getGroupConfirmRoute() => groupConfirm;
  static String getJoinPlanDetailRoute() => joinPlanDetail;




  static  List<GetPage> routes =[
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: home, page: () =>  const Home()),
    GetPage(name: signup, page: () =>  const Signup()),
    GetPage(name: uspScreens, page: () =>  const UspScreens()),
    GetPage(name: login, page: () =>  const Login()),
    GetPage(name: verifyOtp, page: () =>  const VerifyOtp()),
    GetPage(name: nameEmailForm, page: () =>  const NameEmailForm()),
    GetPage(name: confirmSecond, page: () =>  const ConfirmSecond()),
    GetPage(name: bottomNavigation, page: () =>  const BottomNavigation()),
    GetPage(name: mapScreen, page: () =>  const MapScreen()),
    GetPage(name: overallRating, page: () =>  const OverallRating()),
    GetPage(name: groupConfirm, page: () => const GroupConfirm()),
  ];

}