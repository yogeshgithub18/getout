import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../controller/base_controller.dart';
import 'colors.dart';

class ViewImage extends StatefulWidget {
  final List<String> images;
  final String placeId;
  const ViewImage({super.key,required this.images,required this.placeId});

  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  BaseController controller=Get.find<BaseController>();
  final PageController _pageController = PageController();
  int currentPage = 0;
  @override
  void dispose() {


    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
        children: [
          PageView.builder(
          controller: _pageController,
          itemCount: controller.cardsDetails.value.multipleImages?.length,
          onPageChanged: (int page) {
            setState(() {
              currentPage = page;
            });
          },
          itemBuilder: (context, index) {
            return  ClipRRect(
              borderRadius: BorderRadius.circular(1.sp),
              child: Image.network(
                widget.images[index],
                  height:Get.height-kToolbarHeight,fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },errorBuilder: (context,stack,child){
                return  Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: ColoRRes.borderColor),
                      borderRadius: BorderRadius.circular(12.sp)
                  ),
                  child: Image.asset(
                    "assets/images/noImage.jpg",fit: BoxFit.cover, height: 18.h,
                    width: 36.w,
                  ),
                );
              },),
            );
          },
        ),
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal:15.sp),
              child: Row(
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
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColoRRes.white,
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
                  GestureDetector(
                    onTap: () {
                      //Get.to(()=>NotificationScreen());
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
                            'assets/chat/share.svg',
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
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      controller.handleEvents(controller.cardsDetails.value.placeId!,"fav");
                    },
                    child: Container(
                                    height: 50.0, // Set the desired height
                                    width: 50.0,  // Set the desired width
                                    decoration: const BoxDecoration(
                    color: Colors.red, // Background color for the container
                    shape: BoxShape.circle, // Makes the container circular
                                    ),
                                    child: const Center(
                    child: Icon(
                      Icons.favorite, // Heart icon
                      color: Colors.white, // Icon color
                      size: 24.0, // Icon size
                    ),
                                    ),
                                  ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal:10.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(widget.images.length, (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          margin: EdgeInsets.symmetric(horizontal: 6.sp),
                          height: 9.sp,
                          width: (MediaQuery.of(context).size.width -50.sp) / 4,
                          decoration: BoxDecoration(
                            color: index <= currentPage ? ColoRRes.indicatorColor : ColoRRes.inColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        );
                      }),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.handleEvents(controller.cardsDetails.value.placeId!,"star");
                    },
                    child: Container(
                      height: 50.0, // Set the desired height
                      width: 50.0,  // Set the desired width
                      decoration: const BoxDecoration(
                        color: Colors.red, // Background color for the container
                        shape: BoxShape.circle, // Makes the container circular
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.star, // Heart icon
                          color: Colors.white, // Icon color
                          size: 24.0, // Icon size
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
       ],
      ),),
    );
  }
}
