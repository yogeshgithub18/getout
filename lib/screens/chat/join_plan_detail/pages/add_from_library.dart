import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_out/common_screens/colors.dart';
import 'package:get_out/controller/add_library_controller.dart';
import 'package:get_out/controller/star_controller.dart';
import 'package:get_out/screens/chat/join_plan_detail/pages/subscribe_second.dart';
import 'package:get_out/screens/star/subscribe.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../common_screens/app_text.dart';
import '../../../../custom_app_screen/custom_appbar_container.dart';
import '../../../../custom_app_screen/custom_main_button.dart';
import '../../../../modal/swipe_card_response.dart';

class AddFromLibrary extends StatefulWidget {
  const AddFromLibrary({super.key});

  @override
  State<AddFromLibrary> createState() => _AddFromLibraryState();
}

class _AddFromLibraryState extends State<AddFromLibrary> with SingleTickerProviderStateMixin {
  late TabController tabController;
  final tabTitles = ['Subscribe', 'Love'];
  AddLibraryController controller=Get.put(AddLibraryController());
  @override
  void initState() {
    super.initState();
    controller.getCategory();
    tabController = TabController(length: tabTitles.length, vsync: this);
    tabController.addListener((){
      if (tabController.indexIsChanging) {
        print('Tab changed to: ${tabController.index}');
        controller.selectedIndex.value=tabController.index;
        controller.activities.value=[];
        controller.getCards();
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 25),
        child: CustomButton(
            label: "Continue",
            onPressed: () {
              List <Cards> data=controller.selectedEvents;
              Get.back(result:data);
            }
        ),
      ),

      appBar: AppBar(
        backgroundColor: ColoRRes.white,
        elevation: 0,
        title: const AppTexts.inter16W600('Library'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
              padding:
              EdgeInsets.only(left: 15.sp, top: 12.5.sp, bottom: 8.sp),
              child: const CustomChatContainer(
                assetPath: 'assets/chat/back.svg',
              )),
        ),
      ),
      body:Obx(()=> Column(
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
                        style:const TextStyle(
                          fontFamily: 'Inter',
                        ),
                        textAlign: TextAlign.start,
                      )
                  ),
                ))
                    .toList(),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(controller.interestList.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.selectedFilterIndex.value = index;
                    controller.activities.value=[];
                    controller.getCards();
                  },
                  child: buildContainer(controller.interestList[index].title??'', index),
                );
              }),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                SubscribeSecond(),
                SubscribeSecond(),
              ],
            ),
          ),
        ],
      )
      ),
    );
  }

  Widget buildContainer(String text, int index) {
    return Container(
      margin: EdgeInsets.only(right: 16.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 0.5,
          color: controller.selectedFilterIndex.value == index ? ColoRRes.primary : ColoRRes.textColor,
        ),
        color: controller.selectedFilterIndex.value == index ? ColoRRes.primary : ColoRRes.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.sp, vertical: 13.sp),
        child: AppTexts.plusJakaSan12W500(text,textColor: controller.selectedFilterIndex.value == index ? ColoRRes.white : ColoRRes.textColor,),
      ),
    );
  }
}
