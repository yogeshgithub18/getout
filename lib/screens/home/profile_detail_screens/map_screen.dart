import 'package:location/location.dart' as l;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_out/common_screens/colors.dart';
import 'package:get_out/controller/register_main_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../common_screens/app_text.dart';
import '../../../custom_app_screen/custom_main_button.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final String apiKey = 'AIzaSyDAV99_3xf9mxeEXdyKppZicwW5pggdVgc';
  RegisterMainController controller=Get.find<RegisterMainController>();

  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  static const LatLng _initialPosition =LatLng(37.77608993377768, -122.42246700282115);// San Francisco
  LatLng _selectedPosition = _initialPosition;
  GoogleMapController? _mapController;
  Marker? _selectedMarker;
  l.Location location = l.Location();
  @override
  void initState() {
    controller.searchController.value.clear();
    _markers.add(
      Marker(
        markerId: const MarkerId('center_marker'),
        position: _selectedPosition,
        infoWindow: const InfoWindow(
          title: 'Jaipur',
          snippet: 'An interesting city',
        ),
        icon: BitmapDescriptor.defaultMarker, // Default marker icon
      ),
    );
    controller.searchController.value.addListener(() {
      controller.showSuffixIcon.value = controller.searchController.value.text.isNotEmpty;
      controller.fetchSuggestions(controller.searchController.value.text);
    });
    super.initState();
  }

  void clearSearch() {
    controller.showSuffixIcon.value=false;
    controller.filteredLocations.clear();
    controller.searchController.value.clear();
  }

  @override
  void dispose() {
    //controller.searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double containerHeight = controller.filteredLocations.isNotEmpty
        ? (controller.filteredLocations.length * 50.sp).clamp(0, 70.sp)
        : 0;
    return Scaffold(
      backgroundColor: ColoRRes.white,
        body:Obx(()=> Stack(
          children: [
            Positioned.fill(
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: _initialPosition,
                  zoom: 13.0,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                },
                markers: _selectedMarker != null ? {_selectedMarker!} : {},
                onTap: (LatLng position) {
                  _onMapTapped(position);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 20.sp),
              child: Column(
                children: [
                  Stack(
                    children: [
                      if (controller.filteredLocations.isNotEmpty && controller.searchController.value.text.isNotEmpty) ...[
                        Container(
                          margin: EdgeInsets.only(top: 30.sp),
                          height: containerHeight,
                          padding: EdgeInsets.symmetric(vertical: 15.sp),
                          decoration: BoxDecoration(
                            color: ColoRRes.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(18.sp),
                              topRight: Radius.circular(18.sp),
                              bottomLeft: Radius.circular(15.sp),
                              bottomRight: Radius.circular(15.sp),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.filteredLocations.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Row(
                                  children: [
                                    SvgPicture.asset('assets/images/searchListIcon.svg'),
                                    SizedBox(width: 4.w),
                                    AppTexts.inter14W400(
                                      controller.filteredLocations[index]['description']!,
                                      textColor: ColoRRes.searchTextFieldColor,
                                    ),
                                  ],
                                ),
                                onTap: () async {
                                  // Retrieve the latitude and longitude for the selected place.
                                  final latLng = await controller.getPlaceLatLng(controller.filteredLocations[index]['place_id']!);
                                  if (latLng != null) {
                                    // Update the selected position and add a marker at that location.
                                    _selectedPosition = LatLng(latLng['lat']!, latLng['lng']!);
                                    setState(() {
                                      // Set the marker on the map at the selected position.
                                      _selectedMarker = Marker(
                                        markerId: const MarkerId('selected-location'),
                                        position: _selectedPosition,
                                        infoWindow: InfoWindow(
                                          title: controller.filteredLocations[index]['description'],
                                        ),
                                      );

                                      // Update the search controller's text with the selected location's name.
                                      controller.searchController.value.text = controller.filteredLocations[index]['description']!;
                                      controller.showSuffixIcon.value = true;
                                      controller.filteredLocations.value=[];
                                    });

                                    // Move the camera to the selected location.
                                    _mapController?.animateCamera(
                                      CameraUpdate.newLatLng(_selectedPosition),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ],
                      Padding(
                        padding: EdgeInsets.only(top: 30.sp),
                        child: Container(
                          height: 7.h,
                          decoration: BoxDecoration(
                            color: ColoRRes.textFieldColor,
                            borderRadius: BorderRadius.circular(100.sp),
                            border: Border.all(
                              width: 0.5,
                              color: ColoRRes.primary.withOpacity(0.5),
                            ),
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
                                padding: EdgeInsets.only(left: 18.sp, right: 16.sp),
                                child: SvgPicture.asset('assets/images/search.svg'),
                              ),
                              suffixIcon: controller.showSuffixIcon.value
                                  ? Padding(
                                padding: EdgeInsets.only(right: 18.sp),
                                child: GestureDetector(
                                  onTap: clearSearch,
                                  child: SvgPicture.asset(
                                    'assets/images/searchCencel.svg',
                                  ),
                                ),
                              )
                                  : null,
                              hintText: 'Search your location',
                              hintStyle: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                color: ColoRRes.subTextColor,
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 18.sp, horizontal: 15.sp),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CustomButton(
                    label: "Continue",
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        ));
  }

  // Method to handle map tap and add a marker
  Future<void> _onMapTapped(LatLng position) async {
    setState(() {
      _selectedPosition = position;
      controller.lat.value=position.latitude.toString();
      controller.lng.value=position.longitude.toString();
      _selectedMarker = Marker(
        markerId: const MarkerId('selected-location'),
        position: _selectedPosition,
      );
    });
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        controller.searchController.value.text = '${place.street}, ${place.locality}, ${place.country}';
      }
    } catch (e) {
      controller.searchController.value.text = 'Unable to get location name';
    }
  }
}
