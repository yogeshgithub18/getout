import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_out/backend/base_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../common_screens/app_text.dart';
import '../../common_screens/colors.dart';
import '../../controller/itinerary_details_controller.dart';
import '../../custom_app_screen/custom_appbar_container.dart';
import '../../custom_app_screen/custom_main_button.dart';
import '../home/home_main/bottom_navigation.dart';
import '../home/home_main/company.dart';

class GenerateItinerary extends StatefulWidget {
  final String id;
  final String from;
  const GenerateItinerary({super.key,required this.id,required this.from});

  @override
  State<GenerateItinerary> createState() => _GenerateItineraryState();
}

class _GenerateItineraryState extends State<GenerateItinerary> {
  late FlutterLocalNotificationsPlugin _notificationsPlugin;
  ItineraryDetailsController controller=Get.put(ItineraryDetailsController());
  @override
  void initState() {
    // TODO: implement initState
    controller.getItineraryDetails(widget.id,widget.from);
    requestNotificationPermission();
    _initializeNotifications();
    super.initState();
  }

  Future<void> requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  void _initializeNotifications() {
    _notificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@drawable/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    _notificationsPlugin.initialize(settings);
  }

  Future<void> _downloadPDF(String url, String fileName) async {
    try {
      // Locate the Downloads directory
      Directory? downloadsDirectory;
      if (Platform.isAndroid) {
        downloadsDirectory = Directory('/storage/emulated/0/Download');
      } else if (Platform.isIOS) {
        downloadsDirectory = await getApplicationDocumentsDirectory();
      }

      if (downloadsDirectory != null) {
        String savePath = '${downloadsDirectory.path}/$fileName';
         await BaseAPI().download(url, savePath).then((onValue){
           print("on valuee--->$onValue");
           _showNotification("Download Complete", "$fileName has been saved to your Downloads folder.");
         });
        // // Download the file
        // Dio dio = Dio();
        // await dio.download(url, savePath);

        // Show a notificatio
      } else {
        _showNotification("Download Failed", "Unable to locate the Downloads directory.");
      }
    } catch (e) {
      print("error--$e");
      _showNotification("Download Error", "Failed to download file: $e");
    }
  }

  Future<void> _showNotification(String title, String body) async {
    try {
      const AndroidNotificationDetails androidDetails =
      AndroidNotificationDetails('download_channel', 'Downloads',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false);

      const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

      await _notificationsPlugin.show(0, title, body, platformDetails);
    }catch(e){
      print("error--$e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoRRes.white,
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
              )),
        ),
        title: Container(
          alignment: Alignment.center,
          child: const AppTexts.inter16W600(
            'Itinerary',
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: (){

            },
            child: Padding(
                padding: EdgeInsets.only(
                  right: 15.sp,
                  top: 14.sp,
                ),
                child: const CustomChatContainer(
                  assetPath: 'assets/chat/share.svg',
                )),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 25),
        child: CustomButton(label: "Download", onPressed: () async{
         String  url =await controller.getItineraryPdfLink(widget.id);
         print("url print$url");
         if(url.isNotEmpty){
           int epochTime = DateTime.now().millisecondsSinceEpoch;
           String fileName="$epochTime-itinerary.pdf";
           print("url fileName$fileName");
           _downloadPDF(url,fileName);
         }
        }),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 18.sp, bottom: 5.sp),
            child: Container(
              decoration: BoxDecoration(
                color: ColoRRes.timeBackColor,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  width: 1,
                  color: ColoRRes.textColor.withOpacity(0.4),
                ),
              ),
              child: Obx(() => Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0.sp),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 67.h, // Set a maximum height
                      minHeight: 20.h, // Set a minimum height
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.steps.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => Company(id: controller.steps[index].placeId!));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomStepItem(
                              stepData: controller.steps[index],
                              isLast: index == controller.steps.length - 1,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomStepItem extends StatelessWidget {
  final StepData stepData;
  final bool isLast;

  const CustomStepItem({
    super.key,
    required this.stepData,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
    //  mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Time on the left side
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            stepData.time??"",
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ),
        const SizedBox(width: 10),
        // Dashed Line & Pin Icon
        Column(
          children: [
            // Pin Icon
            const Icon(
              Icons.adjust,
              color: Colors.orange,
              size: 24,
            ),
            // Dashed Line if it's not the last step
            if (!isLast)
              CustomPaint(
                painter: DashedLinePainter(),
                child: const SizedBox(
                  height: 40,
                ),
              ),
          ],
        ),
        const SizedBox(width: 10),
        // Destination Name on the right side
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stepData.name??"",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  stepData.destination??"",
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Custom Painter to draw a dashed line
class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    double dashWidth = 4, dashSpace = 4, startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
