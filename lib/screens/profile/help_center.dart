import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_out/controller/profile_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common_screens/app_text.dart';
import '../../common_screens/colors.dart';
import '../../custom_app_screen/custom_appbar_container.dart';
import '../../custom_app_screen/custom_main_button.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  TextEditingController helpSearchController = TextEditingController();
  int selectedIndex = 0;
  List<bool> expansionStates = [false, false];
  final List<String> helpList = ['All', 'Services', 'General', 'Account',];
  List<bool> isSelected = [true, false, false, false];
  ProfileController controller=Get.find<ProfileController>();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController?.addListener(() async {
      if (!(_tabController!.indexIsChanging)) {
       if(_tabController!.index==0){
         controller.getFaq();
       }else{
         controller.email.value.text='';
         controller. firstName.value.text='';
         controller. query.value.text='';
       }
      }
    });
    controller.getFaq();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoRRes.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: ColoRRes.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(left: 15.sp, top: 12.5.sp, bottom: 8.sp),
            child: const CustomChatContainer(
              assetPath: 'assets/chat/back.svg',
            ),
          ),
        ),
        title: Container(
          alignment: Alignment.center,
          child: const AppTexts.inter16W600('Help Center'),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.only(
                right: 15.sp,
                top: 14.sp,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColoRRes.backGroundColor,
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            child: Container(
              margin: EdgeInsets.only(top: 20.sp),
              height: 6.h,
              decoration: BoxDecoration(
                color: ColoRRes.backGroundColor,
                borderRadius: BorderRadius.circular(35.sp),
              ),
              child: TextField(
                controller: helpSearchController,
                cursorColor: ColoRRes.black,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 16.sp, right: 18.sp),
                    child: SvgPicture.asset('assets/images/search.svg'),
                  ),
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    color: ColoRRes.textSubColor,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 19.sp, horizontal: 15.sp),
                ),
              ),
            ),
          ),
          SizedBox(height: 1.5.h,),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: ColoRRes.primary.withOpacity(0.5), width: 0.5),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: ColoRRes.primary,
              unselectedLabelColor: ColoRRes.black.withOpacity(0.5),
              indicator: UnderlineTabIndicator(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                borderSide: const BorderSide(width: 4, color: ColoRRes.primary),
                insets: EdgeInsets.symmetric(horizontal: 54.sp),
              ),
              labelStyle: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              tabs: const [
                Tab(text: 'FAQ'),
                Tab(text: 'Contact Us'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                faqTab(),
                contactUsForm()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget faqTab() {
    return Padding(
      padding: EdgeInsets.all(15.sp),
      child: Column(
        children: [
          SizedBox(height: 1.h),
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: List.generate(helpList.length, (index) {
          //       return GestureDetector(
          //         onTap: () {
          //           setState(() {
          //             selectedIndex = index;
          //           });
          //         },
          //         child: helpContainer(helpList[index], index),
          //       );
          //     }),
          //   ),
          // ),
          // SizedBox(height: 3.h,),
         Obx(()=> Expanded(
            child: ListView.builder(
              itemCount: controller.faqList.length,
              itemBuilder: (context, index) {
                final faq = controller.faqList[index];
                return buildFAQItem(faq.question??"", faq.answer??"", index);
              },
            ),
          ),),
        ],
      ),
    );
  }

  Widget helpContainer(String text, int index) {
    return Container(
      margin: EdgeInsets.only(right: 16.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: selectedIndex == index ? ColoRRes.primary : ColoRRes.primary.withOpacity(0.1),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 12.sp),
        child: AppTexts.inter18W500(
          text,
          textColor: selectedIndex == index ? ColoRRes.white : ColoRRes.primary,
        ),
      ),
    );
  }

  Widget buildFAQItem(String question, String answer, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.sp),
      child: ExpansionTile(
        backgroundColor: ColoRRes.expansionBackColor,
        collapsedBackgroundColor: ColoRRes.expansionBackColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: ColoRRes.expansionColor.withOpacity(0.1),
            width: 1.0,
          ),
        ),
        trailing: expansionStates[index]
            ? const Icon(Icons.keyboard_arrow_up_rounded, size: 30, color: ColoRRes.primary)
            : const Icon(Icons.keyboard_arrow_down_rounded, size: 30, color: ColoRRes.primary),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: ColoRRes.expansionColor.withOpacity(0.1),
            width: 1.0,
          ),
        ),
        collapsedIconColor: ColoRRes.primary,
        iconColor: ColoRRes.primary,
        title: AppTexts.inter16W600(question),
        onExpansionChanged: (expanded) {
          setState(() {
            expansionStates[index] = expanded;
          });
        },
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            child: Container(
              height: 0.1.h,
              width: double.infinity,
              color: ColoRRes.primary.withOpacity(0.5),
            ),
          ),
          SizedBox(height: 1.5.h,),
          Padding(
            padding: EdgeInsets.only(bottom: 16.sp, left: 15.sp, right: 15.sp),
            child: AppTexts.inter15W400(
              answer,
              textColor: ColoRRes.black.withOpacity(0.5),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Widget contactUsForm(){
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:5.w),
      child: Column(
        children: [
          SizedBox(height: 5.h),
          TextField(
            controller: controller.firstName.value,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
            cursorColor: ColoRRes.black,
            decoration: InputDecoration(
              labelText:  'Enter Full name',
              labelStyle: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight:  FontWeight.w400,
                color:  ColoRRes.subTextColor,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(19.sp),
                borderSide: const BorderSide(
                  width: 0.5,
                  color: ColoRRes.subBorderColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(19.sp),
                borderSide: const BorderSide(color: ColoRRes.textColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(19.sp),
                borderSide: const BorderSide(
                  width: 0.5,
                  color: ColoRRes.subBorderColor,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 18.sp,
                horizontal: 25.sp,
              ),
            ),
          ),
          SizedBox(height: 2.5.h),
          TextField(
            controller: controller.email.value,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
            cursorColor: ColoRRes.black,
            decoration: InputDecoration(
              labelText: 'Enter your mail',
              labelStyle: const TextStyle(
                fontFamily: 'Inter',
                fontSize:  16,
                fontWeight:  FontWeight.w400,
                color: ColoRRes.subTextColor,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(19.sp),
                borderSide: const BorderSide(
                  width: 0.5,
                  color: ColoRRes.subBorderColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(19.sp),
                borderSide: const BorderSide(color: ColoRRes.textColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(19.sp),
                borderSide: const BorderSide(
                  width: 0.5,
                  color: ColoRRes.subBorderColor,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 18.sp,
                horizontal: 25.sp,
              ),
            ),
          ),
          SizedBox(height: 2.5.h),
          TextFormField(
            controller: controller.query.value,
            maxLines: 5,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              fontSize: 18.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
            cursorColor: ColoRRes.black,
            decoration: InputDecoration(
              labelText: 'Write your query',
              labelStyle: const TextStyle(
                fontFamily: 'Inter',
                fontSize:  16,
                fontWeight:  FontWeight.w400,
                color: ColoRRes.subTextColor,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(19.sp),
                borderSide: const BorderSide(
                  width: 0.5,
                  color: ColoRRes.subBorderColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(19.sp),
                borderSide: const BorderSide(color: ColoRRes.textColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(19.sp),
                borderSide: const BorderSide(
                  width: 0.5,
                  color: ColoRRes.subBorderColor,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 18.sp,
                horizontal: 25.sp,
              ),
            ),
          ),
          SizedBox(height:15.h ,),
         Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 25),
        child: CustomButton(
          label: "Submit",
          onPressed: () {
            controller.submitQuery();
          },
          ),
         )

        ],
      ),
    );
  }


  Widget contactUsButton(String image, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: ColoRRes.expansionBackColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
                width: 0.5,
                color: ColoRRes.contactBorColor.withOpacity(0.1)
            )
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 15.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(image, height: 4.h, width: 4.w, fit: BoxFit.scaleDown),
                  SizedBox(width: 3.w),
                  AppTexts.inter14W500(label, textColor: ColoRRes.textColor),
                ],
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 20,color: ColoRRes.primary,),
            ],
          ),
        ),
      ),
    );
  }

  Widget contactUsForm2(){
    final List<Map<String, dynamic>> contactItems = [
      {
        'iconPath': 'assets/profile/headphone.svg',
        'label': 'Customer Service',
        'onTap': () {
        },
      },
      {
        'iconPath': 'assets/profile/whatsapp.svg',
        'label': 'WhatsApp',
        'onTap': () {

        },
      },
      {
        'iconPath': 'assets/profile/global.svg',
        'label': 'Website',
        'onTap': () {
        },
      },
      {
        'iconPath': 'assets/profile/facebook.svg',
        'label': 'Facebook',
        'onTap': () {
        },
      },
      {
        'iconPath': 'assets/profile/twitter.svg',
        'label': 'Twitter',
        'onTap': () {
        },
      },
      {
        'iconPath': 'assets/profile/instagram.svg',
        'label': 'Instagram',
        'onTap': () {

        },
      },
      {
        'iconPath': 'assets/profile/linked.svg',
        'label': 'Linkedin',
        'onTap': () {

        },
      },
      {
        'iconPath': 'assets/profile/youtube.svg',
        'label': 'Youtube',
        'onTap': () {

        },
      },
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.sp,vertical: 20.sp),
      child: Expanded(
        child: ListView.builder(
          itemCount: contactItems.length,
          itemBuilder: (context, index) {
            final action = contactItems[index];
            return Column(
              children: [
                contactUsButton(
                    action['iconPath'],
                    action['label'],
                    action['onTap']
                ),
                if (index < contactItems.length - 1)
                  SizedBox(height: 2.h),
              ],
            );
          },
        ),
      ),);
  }
}

