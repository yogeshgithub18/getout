import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get_out/base_utils/base_overlays.dart';
import '../../common_screens/app_text.dart';
import '../../common_screens/colors.dart';
import '../../controller/profile_controller.dart';
import '../../custom_app_screen/custom_main_button.dart';
import '../home/home_main/notification.dart';
import 'add_friend.dart';
import 'add_friend_contacts.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

import 'cluster_map.dart';

class AddFriendMain extends StatefulWidget {
  const AddFriendMain({super.key});

  @override
  State<AddFriendMain> createState() => _AddFriendMainState();
}

class _AddFriendMainState extends State<AddFriendMain>  with TickerProviderStateMixin {
  ProfileController controller=Get.put(ProfileController());
  late TabController tabController;
  final tabTitles = ['Friend', 'Contact'];

  @override
  void initState() {
    super.initState();
    controller.selectedFriend.value=[];
    controller.getFriend();
     _requestPermissions();
    tabController = TabController(length: tabTitles.length, vsync: this);
    tabController.addListener((){
      print("--->>${tabController.indexIsChanging}----${tabController.index}");
      if (tabController.indexIsChanging) {
        if(tabController.index==0) {
          controller.getFriend();
        }else{
          _requestPermissions();
        }
      }
    });
  }

   // Request permissions for contacts access
  Future<void> _requestPermissions() async {
     PermissionStatus permission = await Permission.contacts.status;

    if (permission.isGranted) {
      _loadContacts();
    } else if (permission.isDenied) {
      // Request permission if it's denied
      PermissionStatus newPermission = await Permission.contacts.request();

      if (newPermission.isGranted) {
        _loadContacts();
      } else {
        // Show an explanation or fallback if the user denies permission
         BaseOverlays().showSnackBar(message:"Permission to access contacts is required");
      }
    } else if (permission.isPermanentlyDenied) {
      // Show settings if permission is permanently denied
       BaseOverlays().showSnackBar(message:"Please allow permission in app settings");
    }

  }

  // Load contacts from the device
  Future<void> _loadContacts() async {
    try {
      controller.isContactLoading.value=true;
      Iterable<Contact> contacts = await ContactsService.getContacts();
      controller.isContactLoading.value=false;
      List<Map<String,dynamic>> data=[];
      for(int i=0;contacts.toList().length>i;i++){
        Map<String,dynamic> d={
          "name":contacts.toList()[i].displayName,
          "number":(contacts.toList()[i].phones != null && contacts.toList()[i].phones!.isNotEmpty)?(contacts.toList()[i].phones!.first.value):null,
          "email":(contacts.toList()[i].emails != null && contacts.toList()[i].emails!.isNotEmpty)?contacts.toList()[i].emails!.first.value:null,
          "isavailable":null
        };
        data.add(d);
      }
      await controller.syncContacts(data);
    } catch (e) {
         controller.isContactLoading.value=false;
        ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('Failed to load contacts: $e')),
      );
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.to(()=>const ClusterMapScreen());
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    height: 22.h,
                    child: Image.asset(
                      'assets/home/profileMap.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 15.sp,
                            top: 14.sp,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColoRRes.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(14.sp),
                              child: const Icon(
                                Icons.arrow_back_rounded,
                                color: ColoRRes.textColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const AppTexts.inter16W600(
                          'My Profile',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(()=>NotificationScreen());
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: 15.sp,
                            top: 14.sp,
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColoRRes.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(14.sp),
                              child: SvgPicture.asset(
                                'assets/home/notification.svg',
                                height: 2.h,
                                width: 2.w,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(()=> Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 50,
                  top: 15.h,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1.5, color: ColoRRes.white),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[200], // Optional: Background color while loading
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: controller.user.value.profile??"", // Replace with your image URL
                          fit: BoxFit.cover,
                          width: 100.0,
                          height: 100.0,
                          placeholder: (context, url) => const CircularProgressIndicator(), // Loading indicator
                          errorWidget: (context, url, error) => const Icon(Icons.error), // Error icon
                        ),
                      ),
                    ),
                  ),
                )),
              ],
            ),
            SizedBox(height: 7.h),
            Obx(()=> Center(
              child: AppTexts.inter18W600(
                controller.user.value.name??'',
                textColor: ColoRRes.textColor,
              ),
            )),
            SizedBox(height: 1.5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35.sp),
                    color: ColoRRes.backGroundColor,
                  ),
                  child: TabBar(
                    controller: tabController,
                    indicator: BoxDecoration(
                      color: ColoRRes.primary,
                      borderRadius: BorderRadius.circular(35.sp),
                    ),
                    unselectedLabelStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500, fontFamily: 'Inter'),
                    labelStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                    overlayColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.transparent),
                    isScrollable: false,
                    physics: const NeverScrollableScrollPhysics(),
                    indicatorSize: TabBarIndicatorSize.tab,
                    unselectedLabelColor: ColoRRes.textColor,
                    labelColor: ColoRRes.white,
                    tabs: tabTitles
                        .map((title) => Tab(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          title,
                        ),
                      ),
                    ))
                        .toList(),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    AddFriend(),
                    AddFriendContact(),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
