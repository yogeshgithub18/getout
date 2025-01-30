import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_out/common_screens/colors.dart';
import 'package:get_out/controller/add_journal_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common_screens/app_text.dart';
import '../../../controller/chat_controller.dart';
import '../../../custom_app_screen/custom_main_button.dart';
import '../../chat/user_chating.dart';

class Share extends StatefulWidget {
  final String image;
  const Share({super.key,required this.image});

  @override
  State<Share> createState() => _ShareState();
}

class _ShareState extends State<Share> {
   AddJournalController controller=Get.find<AddJournalController>();
  TextEditingController sendController = TextEditingController();
  Set<int> selectedIndices = {};
  Set<int> selectedGroup = {};

  @override
  void initState() {
    // TODO: implement initState
    controller.getFriend();
    controller.getGroup();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoRRes.white,
      bottomNavigationBar:  Padding(
        padding:  EdgeInsets.all( 15.sp),
        child: CustomButton(
          label:   "Send",
          onPressed: () {
            if(controller.chatType.value=='single'){
              Future.delayed(const Duration(seconds:1),(){
                Get.off(()=>UserChating(imageUrl:widget.image,chatType:controller.chatType.value,userName:controller.selectedUser.value.name??"",receiveId:controller.selectedUser.value.recivedID.toString(),profileImage:controller.selectedUser.value.image??"",roomId:controller.selectedUser.value.roomId.toString(),));
              });
            }else{
              Future.delayed(const Duration(seconds:1),(){
                Get.off(()=>UserChating(imageUrl:widget.image,chatType:controller.chatType.value,userName:controller.selectedUser.value.name??"",receiveId:controller.selectedUser.value.recivedID.toString(),profileImage:controller.selectedUser.value.image??"",roomId:controller.selectedUser.value.roomId.toString(),));
              });
            }
          },
        ),
      ),
      body: Obx(()=>Padding(
        padding:  EdgeInsets.all(15.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 25.sp),
              height: 6.h,
              decoration: BoxDecoration(
                color: ColoRRes.backGroundColor,
                borderRadius: BorderRadius.circular(35.sp),
              ),
              child: TextField(
                controller: sendController,
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
            SizedBox(height: 2.h,),
            GestureDetector(
              onTap: (){
                controller.addJournal(type:"add");
              },
              child: Container(
                 width: 44.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColoRRes.primary
                ),
                child: Padding(
                  padding:  EdgeInsets.all(12.sp),
                  child:  Row(
                    children: [
                      const Icon(Icons.add,color: ColoRRes.white,),
                      SizedBox(width: 2.w,),
                      const AppTexts.inter15W400('Add Memory Journal',textColor:ColoRRes.white,)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h,),
            Container(
              width: double.infinity,
              height: 0.1.h,
              color: ColoRRes.dividerColor,
            ),
            SizedBox(height: 2.h,),
            const AppTexts.inter12W600(
                'All Group'
            ),
            SizedBox(
              height: 20.h,
              child: ListView.builder(
                physics: const ScrollPhysics(),
                itemCount: controller.groupList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      controller.chatType.value='group';
                      controller.selectedId.value=controller.groupList[index].id!;
                      controller.selectedUser.value=User(id:controller.groupList[index].id,recivedID:controller.groupList[index].group?.id,name: controller.groupList[index].group?.groupName,image: controller.groupList[index].group?.groupImage,roomId:controller.groupList[index].id);
                      setState(() {

                      });
                    },
                    child: Container(
                      margin:  EdgeInsets.only(bottom: 18.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.sp),
                                child: Image.network(
                                  controller.groupList[index].group?.groupImage??"",fit: BoxFit.cover, width: 14.w, height:7.h,
                                  loadingBuilder: (BuildContext context, Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: SizedBox(
                                        width: 14.w, height:7.h,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null
                                                ? loadingProgress.cumulativeBytesLoaded /
                                                loadingProgress.expectedTotalBytes!
                                                : null,
                                          ),
                                        ),
                                      ),
                                    );
                                  },errorBuilder: (context,stack,child){
                                  return  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: ColoRRes.borderColor),
                                        borderRadius: BorderRadius.circular(8.sp)
                                    ),
                                    child: Image.asset(
                                      "assets/images/noImage.jpg",fit: BoxFit.fill,width: 14.w, height:7.h,
                                    ),
                                  );
                                },),
                              ),
                              SizedBox(width: 4.w,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTexts.inter14W600(controller.groupList[index].groupName??''),
                                ],
                              ),
                            ],
                          ),
                          controller.groupList[index].id==controller.selectedId.value ?Container(
                            height: 7.h,
                            width: 7.w,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColoRRes.primary
                            ),
                            child: const Center(child: Icon(Icons.check_rounded,color: ColoRRes.white,size: 20,)),
                          ):Container(
                            height: 7.h,
                            width: 7.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 1,
                                    color: ColoRRes.borderColor
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 2.h,),
            Container(
              width: double.infinity,
              height: 0.1.h,
              color: ColoRRes.dividerColor,
            ),
            SizedBox(height: 2.h,),
            const AppTexts.inter12W600(
                'All Friends'
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.friendList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      controller.chatType.value='single';
                      controller.selectedId.value=controller.friendList[index].id!;
                      controller.selectedUser.value=User(id:controller.friendList[index].id,recivedID:controller.friendList[index].friendDetails?.id,name: controller.friendList[index].friendDetails?.name,image:controller.friendList[index].friendDetails?.profile??"",roomId:controller.friendList[index].roomDetails?.id);
                      setState(() {

                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 18.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.sp),
                                child: Image.network(
                                  controller.friendList[index].friendDetails?.profile??"",fit: BoxFit.cover, width: 14.w, height:7.h,
                                  loadingBuilder: (BuildContext context, Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: SizedBox(
                                        width: 14.w, height:7.h,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null
                                                ? loadingProgress.cumulativeBytesLoaded /
                                                loadingProgress.expectedTotalBytes!
                                                : null,
                                          ),
                                        ),
                                      ),
                                    );
                                  },errorBuilder: (context,stack,child){
                                  return  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: ColoRRes.borderColor),
                                        borderRadius: BorderRadius.circular(8.sp)
                                    ),
                                    child: Image.asset(
                                      "assets/images/noImage.jpg",fit: BoxFit.fill,width: 14.w, height:7.h,
                                    ),
                                  );
                                },),
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTexts.inter14W600(controller.friendList[index].friendDetails?.name??""),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  AppTexts.inter14W400(
                                    controller.friendList[index].friendDetails?.mobile??"",
                                    fontSize: 10,
                                    textColor: ColoRRes.textSubColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          controller.friendList[index].id==controller.selectedId.value
                              ? Container(
                            height: 7.h,
                            width: 7.w,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColoRRes.primary),
                            child: const Center(
                                child: Icon(
                                  Icons.check_rounded,
                                  color: ColoRRes.white,
                                  size: 20,
                                )),
                          )
                              : Container(
                            height: 7.h,
                            width: 7.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 1,
                                    color: ColoRRes.borderColor)),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class User{
  int? id;
  int? recivedID;
  String ?name;
  String ?image;
  int? roomId;
  User({ this.id, this.recivedID, this.name, this.roomId,this.image});
}