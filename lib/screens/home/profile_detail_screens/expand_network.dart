import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_out/common_screens/colors.dart';
import 'package:get_out/controller/register_main_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common_screens/app_text.dart';

class ExpandNetwork extends StatefulWidget {
  const ExpandNetwork({super.key});

  @override
  State<ExpandNetwork> createState() => _ExpandNetworkState();
}

class _ExpandNetworkState extends State<ExpandNetwork> {

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
    "@jenny",
    "@savannah",
    "@jenny",
    "@savannah",
    "@brooklyn",
    "@jenny",
    "@brooklyn",
  ];

  Set<int> selectedIndices = {};
  RegisterMainController controller=Get.find<RegisterMainController>();

  @override
  void initState() {
    // TODO: implement initState
    controller.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoRRes.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 3.5.h,),
          const AppTexts.inter18W600(
          'Expand Network (all)'
          ),
          Obx(()=> Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: controller.friendList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (controller.selectedFriend.contains(controller.friendList[index].id)) {
                       controller.selectedFriend.remove(controller.friendList[index].id);
                    } else {
                      controller.selectedFriend.add(controller.friendList[index].id!);
                    }
                  },
                  child: Container(
                    margin:  EdgeInsets.only(bottom: 18.sp),
                    child: Obx(()=> Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width:14.w, // Width of the square
                              height:7.h,
                              clipBehavior: Clip.antiAlias,// Height of the square
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                shape: BoxShape.rectangle, // Rectangle for square shape
                                border: Border.all(width: 1, color: Colors.white),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:controller.friendList[index].profile??'', // Replace with your image URL
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Center(
                                    child: Image.asset(
                                      'assets/images/loader.gif',
                                      height: 100,
                                      width: 100,
                                    )), // Loading indicator
                                errorWidget: (context, url, error) => Center(child: Icon(Icons.error)), // Error icon
                              ),
                            ),
                            SizedBox(width: 4.w,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppTexts.inter14W600(controller.friendList[index].name??''),
                                SizedBox(height: 0.5.h,),
                                AppTexts.inter14W400(controller.friendList[index].mobile??'',fontSize: 10,textColor: ColoRRes.textSubColor,),
                              ],
                            ),
                          ],
                        ),
                     controller.selectedFriend.contains(controller.friendList[index].id)?Container(
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
                    )),
                  ),
                );
              },
            ),
          )),
        ],
      ),
    );
  }
}
