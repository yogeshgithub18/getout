import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:get_out/common_screens/app_text.dart';
import 'package:get_out/controller/add_journal_controller.dart';
import 'package:get_out/screens/home/camera/share.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get_out/common_screens/colors.dart';

import '../../../custom_app_screen/custom_main_button.dart';

class Reviews extends StatefulWidget {
  final File? imageFile;

  const Reviews({super.key, this.imageFile});

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  AddJournalController controller = Get.put(AddJournalController());
  final ImagePicker picker = ImagePicker();

  List<String> review=["Had a swipe worthy moment", 
"This got me going from bored to ecstatic",
"Loved the vibe and ambience",
"10/10 would totally hype this up", 
"When your squad goes all out for"];

  @override
  void initState() {
    super.initState();
    controller.captionController.value.text="Had a swipe worthy moment";
    controller.selectedFile?.value = widget.imageFile!;
  }

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }

  Future<void> pickImageFromCamera() async {
    await requestCameraPermission();
    if (await Permission.camera.isGranted) {
      final pickedFile =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 10);
      if (pickedFile != null) {
        controller.selectedFile?.value = File(pickedFile.path);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera permission is required')),
      );
    }
  }

  TextEditingController sendController = TextEditingController();

  void showPopup() {
   // controller.getHomeDataAPI("refresh");
   controller.getCards();
    controller.searchController.value.text = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(
              color: ColoRRes.textColor,
              width: 1.5,
            ),
          ),
          content: SizedBox(
            width: 80.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
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
                    Container(
                      alignment: Alignment.center,
                      child: const AppTexts.inter16W600('Library'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColoRRes.textColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.sp),
                          child: SvgPicture.asset(
                            'assets/home/close.svg',
                            height: 2.h,
                            width: 2.w,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: ColoRRes.backGroundColor,
                    borderRadius: BorderRadius.circular(35.sp),
                  ),
                  child: TextField(
                    controller: controller.searchController.value,
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
                      // suffixIcon: Padding(
                      //   padding: EdgeInsets.only(right: 10.sp),
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       // Handle search action here
                      //     },
                      //     child: Container(
                      //       padding: EdgeInsets.all(14.sp),
                      //       decoration: const BoxDecoration(
                      //           color: ColoRRes.textColor, shape: BoxShape.circle),
                      //       child: SvgPicture.asset(
                      //         'assets/chat/searchSetting.svg',
                      //         fit: BoxFit.contain,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      hintText: 'Search',
                      hintStyle: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        color: ColoRRes.textSubColor,
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 19.sp, horizontal: 15.sp),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                SizedBox(
                  height: 22.h, // Set height for the list
                  child: Obx(() {
                    // if (controller.cards.isEmpty) {
                    //   if (controller.loading.value) {
                    //     return const Center(
                    //         child: Padding(
                    //       padding: EdgeInsets.all(8),
                    //       child: CircularProgressIndicator(),
                    //     ));
                    //   } else if (controller.error.value) {
                    //     return const Center(
                    //         child: Text("Error in fetching list"));
                    //   } else {
                    //     return const Center(child: Text("No data found"));
                    //   }
                    // }
                    return ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: controller.cards.length,
                      itemBuilder: (context, index) {
                        // bool isSelectedReview = controller.selectedReview.contains(controller.cards[index].placeId);
                        // if (!controller.isLastPage.value &&
                        //     index ==
                        //         controller.cards.length -
                        //             controller.nextPageTrigger.value) {
                        //   controller.getHomeDataAPI("load");
                        // }
                        // if (index == controller.cards.length) {
                        //   if (controller.error.value) {
                        //     return const Center(
                        //         child: Text("Error in fetching list"));
                        //   } else {
                        //     return const Center(
                        //         child: Padding(
                        //       padding: EdgeInsets.all(8),
                        //       child: CircularProgressIndicator(),
                        //     ));
                        //   }
                        // }
                        return GestureDetector(
                          onTap: () {
                            controller.selectedReview.value=controller.cards[index].placeId;
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 16.sp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.network(
                                      controller.cards[index].photo ??'',
                                      height: 8.h,
                                      width: 10.w,
                                    ),
                                    SizedBox(width: 4.w),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            width: 42.w,
                                            child: AppTexts.inter14W600(
                                              controller.cards[index].name ??
                                                  "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                        SizedBox(height: 0.5.h),
                                        SizedBox(
                                          width: 40.w,
                                          child: AppTexts.inter14W400(
                                            controller.cards[index].vicinity ??
                                                "",
                                            maxLines: 2,
                                            fontSize: 10,
                                            textColor: ColoRRes.textSubColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Obx(() => (controller.selectedReview.value==controller.cards[index].placeId)
                                    ? Container(
                                        height: 7.h,
                                        width: 7.w,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: ColoRRes.primary),
                                        child: const Center(
                                            child: Icon(Icons.check_rounded,
                                                color: ColoRRes.white,
                                                size: 20)),
                                      )
                                    : Container(
                                        height: 7.h,
                                        width: 7.w,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                width: 1,
                                                color: ColoRRes.borderColor)),
                                      ))
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.sp),
                  child: CustomButton(
                    label: "Send",
                    onPressed: () {
                      controller.addJournal(type: "review");
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  int selectedIndex =0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColoRRes.white,
      body: ListView(
        children: [
      
          Obx(() => Stack(alignment: Alignment.bottomCenter, children: [
                Container(
                  padding: EdgeInsets.all(15.sp),
                  width: double.infinity,
                  height: Get.height-20.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child:
                        controller.selectedFile?.value.path.isNotEmpty != null
                            ? Image.file(
                                controller.selectedFile!.value,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              )
                            : Image.asset(
                                'assets/images/usp3in1img.png',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                      // setState(() {
                      //   imageFile = null;
                      // });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 20.sp, top: 20.sp),
                      decoration: const BoxDecoration(
                          color: ColoRRes.white, shape: BoxShape.circle),
                      child: Padding(
                        padding: EdgeInsets.all(10.sp),
                        child: const Icon(Icons.close_rounded),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h,),
                SizedBox(
                  height: 40.h,
                  child: ListView.builder(
                    itemCount: review.length,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                            controller.captionController.value.text=review[index];
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 25, right: 25, bottom: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            height: 50,
                            decoration: BoxDecoration(
                              color: selectedIndex == index
                                  ? ColoRRes.primary
                                  : ColoRRes.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  AppTexts.inter15W500(
                                  review[index],
                                  textColor:selectedIndex == index ?ColoRRes.white:ColoRRes.black,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration:  BoxDecoration(
                                    color: selectedIndex == index ?ColoRRes.white:ColoRRes.black,
                                    shape: BoxShape.circle,
                                  ),
                                  child:  Icon(
                                    Icons.arrow_forward_rounded,
                                    color: selectedIndex == index ?ColoRRes.primary:ColoRRes.white,
                                  ),
                                ),
                              ],
                            ),
                          ));
                    },
                  ),
                ),
              ])),
          SizedBox(
            height: 1.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showPopup();
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: ColoRRes.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.sp),
                          child: SvgPicture.asset(
                            'assets/images/edit.svg',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    const AppTexts.poppins12W400(
                      'Review',
                      textColor: ColoRRes.subTextColor,
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    pickImageFromCamera();
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12.sp),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: ColoRRes.primary),
                    child: Padding(
                      padding: EdgeInsets.all(18.sp),
                      child: SvgPicture.asset(
                        'assets/bottomNavigateImg/camera.svg',
                        height: 4.h,
                        width: 4.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async{
                        String imageUrl= await controller.fileUpload();
                         Get.off(() =>  Share(image:imageUrl));
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: ColoRRes.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.sp),
                          child: SvgPicture.asset(
                            'assets/images/ArrowUp.svg',
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    const AppTexts.poppins12W400(
                      'Send to',
                      textColor: ColoRRes.subTextColor,
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
