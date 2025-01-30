import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_out/base_utils/base_overlays.dart';
import 'package:get_out/common_screens/colors.dart';
import 'package:get_out/controller/register_main_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common_screens/app_text.dart';

class ProfilePicture extends StatefulWidget {
  final VoidCallback next;
  const ProfilePicture({super.key,required this.next});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  final ImagePicker picker = ImagePicker();
 // File? imageFile;
  RegisterMainController controller=Get.put(RegisterMainController());

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }

  Future<void> pickImage(ImageSource source) async {
    await requestCameraPermission();
    if (await Permission.camera.isGranted) {
      final pickedFile = await picker.pickImage(source:source,imageQuality:50);
      if (pickedFile != null) {
        controller.selectedFile!.value=File(pickedFile.path);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera permission is required')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Obx(()=> Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         SizedBox(height: 20.h),
        Container(
          width: 60.sp,
          height: 60.sp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ColoRRes.indicatorColor,
              width: 4,
            ),
          ),
          child: Container(
            width: 60.sp,
            height: 60.sp,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ColoRRes.white,
                width: 4,
              ),
            ),
            child: CircleAvatar(
              backgroundColor: ColoRRes.primary,
              backgroundImage: controller.selectedFile!.value.path.isNotEmpty ? FileImage(controller.selectedFile!.value) : const AssetImage('assets/images/usp3in1img.png'),
            ),
          ),
        ),
         SizedBox(height: 4.h),
        const AppTexts.inter24W600( 'Profile Picture',
         textColor: ColoRRes.textColor,
        ),
         SizedBox(height: 0.5.h),
        const AppTexts. inter14W400(
          'Snap Your Style Let\'s See That\nProfile Pic!',
          textColor: ColoRRes.subTextLightColor,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Padding (
          padding:  EdgeInsets.symmetric(horizontal:25.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  pickImage(ImageSource.gallery);
                },
                child: Container(
                  height: 12.h,
                     width: 12.w,
                     decoration: const BoxDecoration(
                       color: ColoRRes.primary,
                       shape: BoxShape.circle
                     ),
                    child: Image.asset('assets/images/cameraUpload.png')),
              ),
              Container(
                width: 36.sp,
                height: 36.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                    width: 4,
                  ),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      pickImage(ImageSource.camera);
                    },
                    child: Container(
                      height: 16.h,
                      width: 16.w,
                      decoration:  const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColoRRes.cameraColor
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (controller.selectedFile!.value.path.isNotEmpty) {
                      widget.next();
                  }else{
                    BaseOverlays().showSnackBar(message: "Upload profile picture");
                  }
                },
                child: Container(
                    height: 12.h,
                    width: 12.w,
                    decoration: const BoxDecoration(
                        color: ColoRRes.primary,
                        shape: BoxShape.circle
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset('assets/images/ArrowUp.svg',height: 20,width: 20,),
                    )),
              ),
            ],
          ),
        ),
         SizedBox(height: 3.h),
      ],
    ));
  }
}
