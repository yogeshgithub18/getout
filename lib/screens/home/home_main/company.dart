import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_out/controller/base_controller.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:video_player/video_player.dart';
import '../../../common_screens/app_text.dart';
import '../../../common_screens/colors.dart';
import '../../../common_screens/view_image.dart';
import '../../../common_screens/view_image_single.dart';
import '../../../custom_app_screen/custom_appbar_container.dart';
import '../../../custom_app_screen/custom_main_button.dart';


class Company extends StatefulWidget {
  final String id;
  const Company({super.key,required this.id});

  @override
  State<Company> createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  BaseController controller=Get.find<BaseController>();
  final PageController _pageController = PageController();
  int currentPage = 0;
  final int totalPages = 5; // Number of items in the carousel
  @override
  void initState() {
    // TODO: implement initState
    controller.getDetails(widget.id);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoRRes.white,
      appBar: AppBar(
        backgroundColor: ColoRRes.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
          child: Padding(
              padding: EdgeInsets.only(left: 15.sp, top: 12.5.sp, bottom: 8.sp),
              child: const CustomChatContainer(
                assetPath: 'assets/chat/back.svg',
              )),
        ),
        title: Container(
          alignment: Alignment.center,
          child: const AppTexts.inter16W600(
            'Details',
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
                assetPath: 'assets/chat/share.svg',
              )),
        ],
      ),
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.all(15.sp),
        child: CustomButton(
          label: "Add to Library",
          onPressed: () {
            controller.handleEvents(controller.cardsDetails.value.placeId!,"fav");
          },
        ),
      ),
      body:Obx(()=> SafeArea(
        child: controller.cardsDetails.value.id==null?Center(
            child: Image.asset(
              'assets/images/loader.gif',
              height: 100,
              width: 100,
            )):
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(15.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                SizedBox(
                  height: 300,
                  child:controller.cardsDetails.value.multipleImages!.isEmpty?const Center(
                      child: Text("No image found")
                  ):PageView.builder(
                    controller: _pageController,
                    itemCount: controller.cardsDetails.value.multipleImages?.length,
                    onPageChanged: (int page) {
                      setState(() {
                        currentPage = page;
                      });
                    },
                    itemBuilder: (context, index) {
                      String url=controller.cardsDetails.value.multipleImages?[index]??'';
                      print("urll---$url");
                      if(url.endsWith(".mp4") || url.endsWith(".mov")){
                        return VideoWidget(videoUrl: url);
                        // return VideoWidget(videoUrl:
                        // "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
                        // );
                      }else{
                        return  ClipRRect(
                          borderRadius: BorderRadius.circular(15.sp),
                          child: GestureDetector(
                            onTap: (){
                              if((controller.cardsDetails.value.multipleImages??[]).isNotEmpty) {
                                Get.to(()=>ViewImage(images:controller.cardsDetails.value.multipleImages??[], placeId: widget.id,));
                              }
                            },
                            child: Image.network(
                              controller.cardsDetails.value.multipleImages![index],
                              width: 100.w,
                              height: 30.h,
                              fit: BoxFit.cover,
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
                                  "assets/images/noImage.jpg",fit: BoxFit.fill, height: 18.h,
                                  width: 36.w,
                                ),
                              );
                            },),
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // Rectangular Indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate((controller.cardsDetails.value.multipleImages??[]).length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: EdgeInsets.symmetric(horizontal: 6.sp),
                      height: 9.sp,
                      width: (MediaQuery.of(context).size.width - 35.sp) / 4,
                      decoration: BoxDecoration(
                        color: index <= currentPage ? ColoRRes.indicatorColor : ColoRRes.inColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 2.h),
                AppTexts.inter24W600(
                  controller.cardsDetails.value.name??'',
                  textColor: ColoRRes.textColor,
                ),
                SizedBox(height: 2.5.h),
                Row(
                  children: [
                    SvgPicture.asset('assets/home/location.svg'),
                    SizedBox(width: 2.w),
                    SizedBox(
                        width: MediaQuery.sizeOf(context).width*0.8,
                        child: AppTexts.inter12W400(controller.cardsDetails.value.vicinity??'',textColor: ColoRRes.subColor,)),
                  ],
                ),
                SizedBox(height: 1.5.h),
                Row(
                  children: [
                    const Icon(Icons.access_time_filled_rounded,size:16,color:ColoRRes.subColor ,),
                    SizedBox(width: 2.w),
                    const AppTexts.inter12W400("10:00 AM to 8:00 PM",textColor: ColoRRes.subColor,),
                  ],
                ),
                SizedBox(height: 3.5.h),
                const AppTexts.inter16W600("Description",textColor: ColoRRes.descriptionColor,),
                SizedBox(height: 1.h),
                 AppTexts.inter10W300(
                  controller.cardsDetails.value.description??'',
                  textColor: ColoRRes.descriptionColor,
                  fontSize: 12,
                ),
                SizedBox(height: 3.5.h),
                const AppTexts.inter14W600("Tags",textColor: ColoRRes.descriptionColor,),
                SizedBox(height: 1.h),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 1,
                  children: (controller.cardsDetails.value.types.toString().split(',')).map((tagItem){
                    String formattedTag = tagItem.replaceAll('_', ' ')
                        .split(' ')
                        .map((word) => word[0].toUpperCase() + word.substring(1))
                        .join(' ');
                    return tag(formattedTag, ColoRRes.border1Color);
                  }).toList(),
                ),
                SizedBox(height: 1.h),
                const AppTexts.inter14W600("Review",textColor: ColoRRes.descriptionColor,),
                SizedBox(height: 1.h),
                GridView.count(
                  childAspectRatio: .75,
                  shrinkWrap: true,
                  crossAxisCount: 3, // 3 containers per row
                  crossAxisSpacing: 5.0, // Space between columns
                  mainAxisSpacing: 5.0,  // Space between rows
                  padding: const EdgeInsets.all(2.0),
                  children: List.generate((controller.cardsDetails.value.reviewData??[]).length,(index) { // Change 9 to the total number of items
                    return GestureDetector(
                      onTap:(){
                         Get.to(()=>ViewImageSingle(images:controller.cardsDetails.value.reviewData?[index].photo??"",text:controller.cardsDetails.value.reviewData?[index].caption??''));
                          
                      },
                      child:        
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.sp),
                          child: Image.network(
                            controller.cardsDetails.value.reviewData?[index].photo??"",
                            height: 23.h,
                            width: 28.w,
                            fit: BoxFit.cover,
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
                            return  Image.asset(
                              "assets/images/noImage.jpg",fit: BoxFit.fill, width:100.w, height:100.h,
                            );
                          },),
                        ),
                        Positioned(
                            bottom:10,
                            child :
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width:24.w,
                                child: AppTexts.inter14W600(
                                  controller.cardsDetails.value.reviewData?[index].caption??'',
                                  textColor: ColoRRes.white,),
                              ),
                            )),
                      ],
                     )
                    );
                    
                  }),
                )
              ],
            ),
          ),
        ),
      ),
     )
    );
  }

  Widget tag(String label,Color borderColor) {
    return Chip(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor,width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      label: AppTexts.inter10W500(label,textColor: ColoRRes.white,),
      backgroundColor: ColoRRes.descriptionColor,
      padding:  EdgeInsets.symmetric(horizontal: 10.sp, vertical: 4.sp),
    );
  }
  Widget indicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal: 6.sp),
          height: 9.sp,
          width: (MediaQuery.of(context).size.width - 57.sp) / 4,
          decoration: BoxDecoration(
            color: index <= currentPage ? ColoRRes.indicatorColor : ColoRRes.inColor,
            borderRadius: BorderRadius.circular(100),
          ),
        );
      }),
    );
  }
}

class VideoWidget extends StatefulWidget {
  final String videoUrl;

  const VideoWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        Center(
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause(); // Pause the video
                } else {
                  _controller.play(); // Play the video
                }
              });
            },
            child: Icon(
              _controller.value.isPlaying
                  ? Icons.pause_circle_filled_sharp // Show pause icon when playing
                  : Icons.play_circle_filled_sharp, // Show play icon when paused
              size: 50,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ),
      ],
    );
  }
}
