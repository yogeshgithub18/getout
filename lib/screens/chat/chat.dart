import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_out/controller/chat_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../common_screens/app_text.dart';
import '../../common_screens/colors.dart';
import '../../custom_app_screen/custom_appbar_container.dart';
import '../../custom_app_screen/custom_card_second.dart';
import '../../custom_app_screen/cutom_card.dart';
class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  TextEditingController searchChatController = TextEditingController();
  List<String> itemsFirst = [
    "Jenny Wilson",
    "Savannah Nguyen",
    "Jenny Wilson",
    "Savannah Nguyen",
    "Brooklyn Simmons",
    "Jenny Wilson",
    "Brooklyn Simmons",
  ];
  List<String> itemsSecond = [
    "Lorem ipsum dolor sit amet, consectetur adipiscin Lorem ipsum tur adipiscing ",
    "Lorem ipsum dolor sit amet, consectetur adipiscin Lorem ipsum tur adipiscing ",
    "Lorem ipsum dolor sit amet, consectetur adipiscin Lorem ipsum tur adipiscing ",
    "Lorem ipsum dolor sit amet, consectetur adipiscin Lorem ipsum tur adipiscing ",
    "Lorem ipsum dolor sit amet, consectetur adipiscin Lorem ipsum tur adipiscing ",
    "Lorem ipsum dolor sit amet, consectetur adipiscin Lorem ipsum tur adipiscing ",
    "Lorem ipsum dolor sit amet, consectetur adipiscin Lorem ipsum tur adipiscing ",
  ];
  List<String> groupFirst = [
    "Group 1",
    "Group 2",
  ];
  List<String> groupSecond = [
    "Lorem ipsum dolor sit amet, consectetur adipiscin Lorem ipsum tur adipiscing ",
    "Lorem ipsum dolor sit amet, consectetur adipiscin Lorem ipsum tur adipiscing ",
  ];

  Set<int> selectedIndices = {};



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoRRes.white,
      appBar: AppBar(
        backgroundColor: ColoRRes.white,
        elevation: 0,
        leading: Padding(
            padding: EdgeInsets.only(left: 15.sp, top: 12.5.sp, bottom: 8.sp),
            child: const CustomChatContainer(
              assetPath: 'assets/chat/back.svg',
            )),
        title: Container(
          alignment: Alignment.center,
          child: const AppTexts.inter16W600(
            'Messages',
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
              padding: EdgeInsets.only(
                right: 15.sp,
                top: 14.sp,
              ),
              child: const CustomChatContainer(
                assetPath: 'assets/chat/edit.svg',
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        onPressed: () {},
        backgroundColor: ColoRRes.primary,
        child: Padding(
          padding: EdgeInsets.all(14.sp),
          child: SvgPicture.asset(
            'assets/chat/flotEdit.svg',
            height: 4.h,
            width: 4.w,
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                controller: searchChatController,
                cursorColor: ColoRRes.black,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 16.sp, right: 16.sp),
                    child: SvgPicture.asset('assets/images/search.svg'),
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 10.sp),
                    child: GestureDetector(
                      onTap: () {
                      },
                      child: Container(
                        padding: EdgeInsets.all(14.sp),
                        decoration: const BoxDecoration(
                            color: ColoRRes.textColor, shape: BoxShape.circle),
                        child: SvgPicture.asset(
                          'assets/chat/searchSetting.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
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
          SizedBox(height: 2.5.h),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppTexts.inter12W600('New Group'),
                    SizedBox(height: 1.5.h),
                    ListView.builder(
                      itemCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CustomCard(
                          imagePath: 'assets/images/user.png',
                          title: groupFirst[index],
                          subtitle: groupSecond[index],
                          time: '2:30 PM', messageCount: null,
                         
                        );
                      },
                    ),
                    const AppTexts.inter12W600('Add New Friends'),
                    SizedBox(height: 1.5.h),
                    SizedBox(
                      height: 18.5.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return const FriendCard();
                        },
                      ),
                    ),
                    const AppTexts.inter12W600('All Message'),
                    SizedBox(height: 1.5.h),
                    ListView.builder(
                      itemCount: 7,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CustomCardSecond(
                          imagePath: 'assets/images/user.png',
                          title: itemsFirst[index],
                          subtitle: itemsSecond[index],
                          time: '2:30 PM',
                          onTap: () {
                            setState(() {
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FriendCard extends StatelessWidget {
  const FriendCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16.sp),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.sp),
                child: Image.asset(
                  'assets/chat/addUser.png',
                  height: 16.h,
                  width: 28.w,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.sp,vertical: 10.sp),
                decoration: const BoxDecoration(
                  color: ColoRRes.textColor,
                  shape: BoxShape.circle
                ),
                child: Padding(
                  padding:  EdgeInsets.all(12.sp),
                  child: Center(
                    child: SvgPicture.asset(
                           'assets/bottomNavigateImg/disChat.svg',height: 1.5.h,width: 1.5.w,fit: BoxFit.contain,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
               // Space between image and button
              Positioned(
                bottom: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.sp,vertical: 10.sp),
                  child: SizedBox(
                    height: 22.sp,
                    child: ElevatedButton(
                      onPressed: () {
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 22.2.sp),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.sp),
                        ),
                      ),
                      child: const AppTexts.inter14W500(
                        'Add Friend',
                        fontSize: 10,
                        textColor: ColoRRes.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),

        ],
      ),
    );
  }
}
