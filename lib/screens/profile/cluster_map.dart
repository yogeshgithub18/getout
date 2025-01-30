import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_out/controller/base_controller.dart';
import 'package:get_out/controller/profile_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:ui' as ui;
import '../../common_screens/app_text.dart';
import '../../common_screens/colors.dart';
import '../../custom_app_screen/custom_appbar_container.dart';

class ClusterMapScreen extends StatefulWidget {
  const ClusterMapScreen({super.key});

  @override
  _ClusterMapScreenState createState() => _ClusterMapScreenState();
}

class _ClusterMapScreenState extends State<ClusterMapScreen> {
  ProfileController controller = Get.find<ProfileController>();
  late GoogleMapController mapController;

  // User location
  final LatLng _userLocation = LatLng(
    double.parse(Get.find<BaseController>().user.value.lattitute),
    double.parse(Get.find<BaseController>().user.value.longitute),
  );

  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _setMarkers();
  }

  Future<void> _setMarkers() async {
    // User marker in green
    _markers.add(
      Marker(
        markerId: MarkerId('userLocation'),
        position: _userLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(title: 'You'),
      ),
    );

    // Load friends' locations
    await controller.getFriend();
    print("==============>>>${controller.friendList.length}");

    // Add friends' markers in red
    for (int i = 0; i < controller.friendList.length; i++) {
      final markerIcon =controller.friendList[i].friendDetails?.profile !=null? await _getMarkerIconFromUrl(controller.friendList[i].friendDetails!.profile!, 100):BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      _markers.add(
        Marker(
          markerId: MarkerId('friendLocation$i'),
          position: LatLng(
            double.parse(controller.friendList[i].friendDetails!.lattitute!),
            double.parse(controller.friendList[i].friendDetails!.longitute!),
          ),
          icon: markerIcon,
          //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: '${controller.friendList[i].friendDetails!.name}'),
        ),
      );
    }

    // Update state to reflect markers on the map
    setState(() {});

    // Adjust camera to show all markers
    _showAllMarkers();
  }

  Future<BitmapDescriptor> _getMarkerIconFromUrl(String imageUrl, int size) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final Uint8List imageData = response.bodyBytes;
        final ui.Image originalImage = await _loadImage(Uint8List.fromList(imageData));
        final Uint8List circularImageData = await _getCircularImage(originalImage, size);
      //  return BitmapDescriptor.fromBytes(await _resizeImage(circularImageData, size));
        return BitmapDescriptor.fromBytes(circularImageData);
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      print('Error loading marker icon: $e');
      return BitmapDescriptor.defaultMarker;
    }
  }

  Future<ui.Image> _loadImage(Uint8List imageData) async {
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(imageData, (ui.Image img) {
      completer.complete(img);
    });
    return completer.future;
  }

  Future<Uint8List> _resizeImage(Uint8List bytes, int size) async {
    final codec = await instantiateImageCodec(
      bytes,
      targetWidth: size,
      targetHeight: size,
    );
    final frame = await codec.getNextFrame();
    final data = await frame.image.toByteData(format: ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }

  Future<Uint8List> _getCircularImage(ui.Image originalImage, int size) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..isAntiAlias = true;

    final double radius = size / 2;
    final Rect destRect = Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble());

    // Calculate source rectangle for best fit
    final double imageWidth = originalImage.width.toDouble();
    final double imageHeight = originalImage.height.toDouble();
    final double imageAspectRatio = imageWidth / imageHeight;

    final double canvasAspectRatio = 1.0; // Circle is always 1:1 aspect ratio
    Rect srcRect;

    if (imageAspectRatio > canvasAspectRatio) {
      // Image is wider than canvas, crop horizontally
      final double newWidth = imageHeight * canvasAspectRatio;
      final double xOffset = (imageWidth - newWidth) / 2;
      srcRect = Rect.fromLTWH(xOffset, 0, newWidth, imageHeight);
    } else {
      // Image is taller than canvas, crop vertically
      final double newHeight = imageWidth / canvasAspectRatio;
      final double yOffset = (imageHeight - newHeight) / 2;
      srcRect = Rect.fromLTWH(0, yOffset, imageWidth, newHeight);
    }

    // Draw the circular mask and image
    canvas.drawCircle(Offset(radius, radius), radius, paint);
    paint.shader = ImageShader(
      originalImage,
      TileMode.clamp,
      TileMode.clamp,
      Matrix4.identity().storage,
    );
    canvas.drawOval(destRect, paint);

    // Convert to Uint8List
    final ui.Image finalImage = await pictureRecorder.endRecording().toImage(size, size);
    final ByteData? byteData = await finalImage.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }


  void _showAllMarkers() {
    // Define the initial bounds
    LatLngBounds bounds;

    // If there are markers, create bounds that include them all
    if (_markers.isNotEmpty) {
      List<LatLng> positions = _markers.map((marker) => marker.position).toList();
      bounds = _getLatLngBounds(positions);

      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 50), // 50 padding around edges
      );
    }
  }

  // Helper function to get bounds from a list of LatLng positions
  LatLngBounds _getLatLngBounds(List<LatLng> positions) {
    final southwest = LatLng(
      positions.map((pos) => pos.latitude).reduce((a, b) => a < b ? a : b),
      positions.map((pos) => pos.longitude).reduce((a, b) => a < b ? a : b),
    );
    final northeast = LatLng(
      positions.map((pos) => pos.latitude).reduce((a, b) => a > b ? a : b),
      positions.map((pos) => pos.longitude).reduce((a, b) => a > b ? a : b),
    );
    return LatLngBounds(southwest: southwest, northeast: northeast);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: const AppTexts.inter16W600(
            '',
          ),
        ),
        centerTitle: true,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _userLocation,
          zoom: 12.0,
        ),
        markers: _markers,
      ),
    );
  }
}
