
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common_screens/app_text.dart';
import '../../common_screens/colors.dart';
import '../../controller/chat_controller.dart';
import '../../custom_app_screen/custom_appbar_container.dart';
import '../../custom_app_screen/cutom_card.dart';
import '../../routes/all_routes.dart';
import '../new_group/new_group.dart';
import 'direct_message.dart';
import 'group_message.dart';
import 'join_plan_detail/join_plan_detail.dart';

class DirectAndGroupChat extends StatefulWidget {
  const DirectAndGroupChat({super.key});

  @override
  State<DirectAndGroupChat> createState() => _DirectAndGroupChatState();
}

class _DirectAndGroupChatState extends State<DirectAndGroupChat> with SingleTickerProviderStateMixin{
  ChatController controller=Get.put(ChatController());
  late TabController tabController;
  final tabTitles = ['Direct Message', 'Group Chat'];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabTitles.length, vsync: this);
    tabController.addListener((){
      if(!tabController.indexIsChanging){
        if(tabController.index==1){
          print("index is 1");
         // controller.getGroupAllChat();
        }else{
          print("index is 0");
        }
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoRRes.white,
      appBar: AppBar(
        backgroundColor: ColoRRes.white,
        elevation: 0,
        title: Container(
          alignment: Alignment.center,
          child: const AppTexts.inter16W600(
            'Messages',
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: (){
              Get.to(()=>const NewGroup());
            },
            child: Padding(
                padding: EdgeInsets.only(
                  right: 15.sp,
                  top: 14.sp,
                ),
                child: const CustomChatContainer(
                  assetPath: 'assets/chat/edit.svg',
                )),
          ),
        ],
      ),
      // floatingActionButton: GestureDetector(
      //   child: FloatingActionButton(
      //     heroTag: null,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(100),
      //     ),
      //     onPressed: () {
      //       Get.to(()=>const JoinPlanDetail(from:'normal',type:'',placeId: '',page:'chat'));
      //     },
      //     backgroundColor: ColoRRes.primary,
      //     child: Padding(
      //       padding: EdgeInsets.all(14.sp),
      //       child: SvgPicture.asset(
      //         'assets/chat/flotEdit.svg',
      //         height: 4.h,
      //         width: 4.w,
      //         fit: BoxFit.contain,
      //       ),
      //     ),
      //   ),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                ),
                overlayColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
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
          Expanded(
            child: TabBarView(
              controller: tabController,
              children:  const [
                DirectMessage(),
                GroupMessage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
