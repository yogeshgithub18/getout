import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_out/base_utils/base_overlays.dart';
import 'package:get_out/controller/chat_controller.dart';
import 'package:image_picker/image_picker.dart';
import '../../common_screens/colors.dart';
import '../../common_screens/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../routes/all_routes.dart';
import '../home/home_main/bottom_navigation.dart';

class NewGroup extends StatefulWidget {
  const NewGroup({super.key});

  @override
  State<NewGroup> createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {
  ChatController controller=Get.find<ChatController>();
  final FocusNode focusNode = FocusNode();
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery,imageQuality:50);
    if (image != null) {
      controller.selectedImage?.value = File(image.path);
    }
  }
  void showImagePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          contentPadding: const EdgeInsets.all(22),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppTexts.inter18W600('Upload and attach files',textColor: ColoRRes.popTextColor,),
              SizedBox(height: 0.5.h,),
              const AppTexts.inter12W400('Upload and attach files to project.',textColor: ColoRRes.textSubColor,),
              SizedBox(height: 2.5.h,),
              DottedBorder(
                color: ColoRRes.black,
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                strokeWidth: 0.6,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16.sp,vertical: 14.sp),
                  decoration: BoxDecoration(
                    color: ColoRRes.selectDocColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Image.asset('assets/images/cameraUpload.png',color: ColoRRes.textColor,),
                      SizedBox(height: 1.5.h),
                      const Text(
                        'Upload the front side of your document Support: JPG, PNG',
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w400,
                          color: ColoRRes.docTextColor
                        ),
                      ),
                      SizedBox(height: 1.5.h),
                      GestureDetector(
                        onTap: (){
                          pickImage();
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: ColoRRes.primary
                          ),
                          child: Padding(
                            padding:  EdgeInsets.symmetric(horizontal:12.sp,vertical: 8.sp),
                            child:
                            const AppTexts.inter12W400('Choose a File',textColor: ColoRRes.white,),

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2.5.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(
                            width: 0.5,
                            color: ColoRRes.borderColor
                          )
                        ),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 15.sp,vertical: 16.sp),
                          child: const Center(child: AppTexts.inter16W600('Cancel')),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 2.h,),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        pickImage();
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: ColoRRes.primary
                        ),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 15.sp,vertical: 16.sp),
                          child: const Center(child: AppTexts.inter16W600('Attach Files',textColor: ColoRRes.white,)),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(()=> Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColoRRes.white,
      appBar: AppBar(
        backgroundColor: ColoRRes.white,
        elevation: 0,
        leading: GestureDetector(
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
                color: ColoRRes.backGroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(14.sp),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: ColoRRes.textColor,
                  size: 22,
                ),
              ),
            ),
          ),
        ),
        title: Container(
          alignment: Alignment.center,
          child: const AppTexts.inter16W600(
            'New Group',
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () async {
              if(controller.selectedGroup.length>1){
                await controller.createChatGroup();
                Get.toNamed(AllRoutesClass.getGroupConfirmRoute());
                Future.delayed(const Duration(milliseconds: 500),(){
                  Get.offAll( ()=> const BottomNavigation());
                });
              }else{
                BaseOverlays().showSnackBar(message: "Group should be have three friends");
                return;
              }
            },
            child: Padding(
              padding: EdgeInsets.only(
                right: 15.sp,
                top: 14.sp,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: ColoRRes.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(14.sp),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    color: ColoRRes.white,
                    size: 22,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.5.h),
            TextField(
              controller: controller.groupNameController.value,
              focusNode: focusNode,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
              cursorColor: ColoRRes.black,
              decoration: InputDecoration(
                labelText: (isFocused || controller.groupNameController.value.text.isNotEmpty)
                    ? 'First Name'
                    : 'Group Name',
                labelStyle: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: isFocused ? 14.sp : 16.sp,
                  fontWeight: isFocused ? FontWeight.w500 : FontWeight.w400,
                  color: isFocused ? ColoRRes.textColor : ColoRRes.subTextColor,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.sp),
                  borderSide: const BorderSide(
                    width: 0.5,
                    color: ColoRRes.subBorderColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.sp),
                  borderSide: const BorderSide(color: ColoRRes.textColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.sp),
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
              onChanged: (text) {
                setState(() {});
              },
            ),
            SizedBox(height: 2.h,),
            GestureDetector(
              onTap: () => showImagePopup(context),
              child: controller.selectedImage!.value.path.isEmpty
                  ? Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: ColoRRes.imgBorColor,
                    border: Border.all(
                        width: 0.5,
                        color: ColoRRes.borderColor
                    )
                ),
                child: Padding(
                  padding:  EdgeInsets.all(24.sp),
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/chat/gallery.svg'),
                      SizedBox(height: 1.5.h,),
                      const AppTexts.inter12W400('Upload Group \nPhoto',textAlign: TextAlign.center,),
                    ],
                  ),
                ),
              )
                  : Container(
                height: 14.h,
                width: 30.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    controller.selectedImage!.value,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            SizedBox(height: 2.h,),
            Container(
              height: 1,
              width: double.infinity,
              color: ColoRRes.backGroundColor,
            ),
            SizedBox(
              height: 2.h,
            ),
        SizedBox(
          height: 10.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.selectedGroup.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 6.w),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        ClipOval(
                          child:  Image.network(
                            controller.selectedGroup[index].friendDetails?.profile??"",fit: BoxFit.cover, width: 16.w, height:7.5.h,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: SizedBox(
                                  width: 16.w, height:7.5.h,
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
                                "assets/images/noImage.jpg",fit: BoxFit.fill, width: 16.w, height:7.5.h,
                              ),
                            );
                          },),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              color: ColoRRes.closeColor, shape: BoxShape.circle),
                          child: Padding(
                            padding: EdgeInsets.all(6.sp),
                            child: const Icon(
                              Icons.close_rounded,
                              size: 12,
                              color: ColoRRes.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                     AppTexts.inter10W500(
                      controller.selectedGroup[index].friendDetails?.name??"",
                      textColor: ColoRRes.black,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(
              height: 2.h,
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: ColoRRes.backGroundColor,
            ),
            SizedBox(
              height: 2.h,
            ),
            const AppTexts.inter12W600(
              'All Members',
              textColor: ColoRRes.black,
            ),
            SizedBox(
              height: 2.h,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.friendList.length,
                itemBuilder: (context, index) {
                  bool isSelected = controller.selectedGroup.contains(controller.friendList[index]);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          controller.selectedGroup.remove(controller.friendList[index]);
                        } else {
                          controller.selectedGroup.add(controller.friendList[index]);
                        }
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
                          isSelected
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


