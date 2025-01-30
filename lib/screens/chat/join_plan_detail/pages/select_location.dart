import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_out/base_utils/base_overlays.dart';
import 'package:location/location.dart' as l;
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_out/controller/itninerary_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common_screens/app_text.dart';
import '../../../../common_screens/colors.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({super.key});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  ItineraryController controller = Get.find<ItineraryController>();

  // Initial position for the map
  static const LatLng _initialPosition =
      LatLng(37.77608993377768, -122.42246700282115); // San Francisco
  LatLng _selectedPosition = _initialPosition;
  GoogleMapController? _mapController;
  Marker? _selectedMarker;
  final Set<Marker> _markers = {};
  l.Location location = l.Location();

  @override
  void initState() {
    controller.searchController.value.text = '';
    _markers.add(
      Marker(
        markerId: const MarkerId('center_marker'),
        position: _selectedPosition,
        icon: BitmapDescriptor.defaultMarker, // Default marker icon
      ),
    );
    controller.searchController.value.addListener(() async {
      controller.showSuffixIcon.value =
          controller.searchController.value.text.isNotEmpty;
      print("jbjhbjdddc");
      await controller.fetchSuggestions(controller.searchController.value.text);
    });
    super.initState();
    // Automatically fetch and set user’s current location
    goToCurrentLocation();
  }

  void clearSearch() {
    controller.filteredLocations.value = [];
    controller.searchController.value.text = '';
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  // Marker? _selectedMarker;
  // String _locationName = 'Tap on the map to get location';

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        Stack(
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
                    Obx(() => (controller.filteredLocations.isNotEmpty && controller.searchController.value.text.isNotEmpty)
                        ? Container(
                            margin: EdgeInsets.only(top: 10.sp),
                            height: controller.filteredLocations.isNotEmpty ? (controller.filteredLocations.length * 50.sp)
                                    .clamp(0, 70.sp)
                                : 0,
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
                                      SvgPicture.asset(
                                          'assets/images/searchListIcon.svg'),
                                      SizedBox(width: 4.w),
                                      AppTexts.inter14W400(
                                        controller.filteredLocations[index]
                                            ['description']!,
                                        textColor:
                                            ColoRRes.searchTextFieldColor,
                                      ),
                                    ],
                                  ),
                                  onTap: () async {
                                    // Retrieve the latitude and longitude for the selected place.
                                    final latLng =
                                        await controller.getPlaceLatLng(
                                            controller.filteredLocations[index]
                                                ['place_id']!);
                                    if (latLng != null) {
                                      // Update the selected position and add a marker at that location.
                                      _selectedPosition = LatLng(
                                          latLng['lat']!, latLng['lng']!);
                                      controller.lat.value =
                                          _selectedPosition.latitude.toString();
                                      controller.lng.value = _selectedPosition
                                          .longitude
                                          .toString();
                                      setState(() {
                                        // Set the marker on the map at the selected position.
                                        _selectedMarker = Marker(
                                          markerId: const MarkerId(
                                              'selected-location'),
                                          position: _selectedPosition,
                                          infoWindow: InfoWindow(
                                            title: controller
                                                    .filteredLocations[index]
                                                ['description'],
                                          ),
                                        );

                                        // Update the search controller's text with the selected location's name.
                                        controller.searchController.value.text =
                                            controller.filteredLocations[index]
                                                ['description']!;
                                        controller.showSuffixIcon.value = true;
                                        controller.filteredLocations.value = [];
                                      });

                                      // Move the camera to the selected location.
                                      _mapController?.animateCamera(
                                        CameraUpdate.newLatLng(
                                            _selectedPosition),
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                          )
                        : const SizedBox.shrink()),
                      Padding(
                      padding: EdgeInsets.only(top: 5.sp),
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
                              padding:
                                  EdgeInsets.only(left: 18.sp, right: 16.sp),
                              child:
                                  SvgPicture.asset('assets/images/search.svg'),
                            ),
                            suffixIcon:Obx((){
                              return controller.showSuffixIcon.value
                                ? Padding(
                                    padding: EdgeInsets.only(right: 18.sp),
                                    child: GestureDetector(
                                      onTap: clearSearch,
                                      child: SvgPicture.asset(
                                        'assets/images/searchCencel.svg',
                                      ),
                                    ),
                                  )
                                :SizedBox();
                            }),
                            hintText: 'Search your location',
                            hintStyle: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              color: ColoRRes.subTextColor,
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 18.sp, horizontal: 15.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              height: 6.h,
              width: 13.w,
              decoration: BoxDecoration(
                  color: ColoRRes.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(30.sp),
                  border: Border.all(width: 0.5, color: ColoRRes.borderColor)),
              child: GestureDetector(
                onTap: () {
                  goToCurrentLocation();
                },
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SvgPicture.asset('assets/home/autof.svg'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           SizedBox(height: 3.h),
  //           const AppTexts.inter24W600(
  //             'Select Your Location',
  //             textColor: ColoRRes.textColor,
  //           ),
  //           SizedBox(height: 1.h),
  //           const AppTexts.inter14W400(
  //             'Please enter your name to request a \nprofile creation',
  //             textColor: ColoRRes.subTextColor,
  //           ),
  //           SizedBox(height: 5.h),
  //           Stack(
  //             fit:StackFit.loose,
  //             children: [
  //               Container(
  //                 height: 50.h,
  //                 decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(15.sp),
  //                     border: Border.all(
  //                         width: 0.5,
  //                         color: ColoRRes.borderColor
  //                     )
  //                 ),
  //                 child:GoogleMap(
  //                   initialCameraPosition: const CameraPosition(
  //                     target: _initialPosition,
  //                     zoom: 14.0,
  //                   ),
  //                   onMapCreated: (GoogleMapController controller) {
  //                     _mapController = controller;
  //                   },
  //                   markers: _selectedMarker != null ? {_selectedMarker!} : {},
  //                   onTap: (LatLng position) {
  //                     _onMapTapped(position);
  //                   },
  //                 ),
  //               ),
  //               Positioned(
  //                 bottom: 10,
  //                 child: Container(
  //                   height: 7.h,
  //                   width:92.w,
  //                   decoration: BoxDecoration(
  //                     color:ColoRRes.black,
  //                       borderRadius: BorderRadius.circular(30.sp),
  //                       border: Border.all(
  //                           width: 0.5,
  //                           color: ColoRRes.borderColor
  //                       )
  //                   ),
  //                   child:Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Row(
  //                         children: [
  //                           Padding(
  //                             padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                             child: SvgPicture.asset('assets/images/allowLocation.svg',height:5.h,width: 3.w,),
  //                           ),
  //                            SizedBox(
  //                              width: 62.w,
  //                              child: AppTexts.inter14W400(
  //                               _locationName,
  //                               maxLines: 2,
  //                               overflow: TextOverflow.ellipsis,
  //                               textColor: ColoRRes.subTextColor,
  //                                                          ),
  //                            ),
  //                         ],
  //                       ),
  //                       GestureDetector(
  //                         onTap: (){
  //                           getCurrentLocation();
  //                         },
  //                         child: Padding(
  //                           padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //                           child: SvgPicture.asset('assets/images/gps.svg',height: 5.h,),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  // Method to handle map tap and add a marker
  Future<void> _onMapTapped(LatLng position) async {
    setState(() {
      _selectedPosition = position;
      controller.lat.value = position.latitude.toString();
      controller.lng.value = position.longitude.toString();
      _selectedMarker = Marker(
        markerId: const MarkerId('selected-location'),
        position: _selectedPosition,
      );
    });
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        controller.searchController.value.text =
            '${place.street}, ${place.locality}, ${place.country}';
      }
    } catch (e) {
      controller.searchController.value.text = 'Unable to get location name';
    }
  }

  Future<void> goToCurrentLocation() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        Get.snackbar(
            'Location Services Disabled', 'Please enable location services');
        return;
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        Get.snackbar(
            'Location Permission Denied', 'Please allow location access');
        return;
      }
    }

    BaseOverlays().showLoader();
    final LocationData currentLocation = await location.getLocation();
    BaseOverlays().dismissOverlay(showLoader: true);

    LatLng selectedLatLng =
        LatLng(currentLocation.latitude!, currentLocation.longitude!);
    //controller.lat = currentLocation.latitude.toString();
    // controller.lng = currentLocation.longitude.toString();

    String locationName = 'Unable to get location name';
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        currentLocation.latitude!,
        currentLocation.longitude!,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        locationName = '${place.street}, ${place.locality}, ${place.country}';
      }
    } catch (e) {
      debugPrint("Failed to get location name: $e");
    }

    setState(() {
      _selectedPosition = selectedLatLng;
      controller.searchController.value.text = locationName;
      _selectedMarker = Marker(
        markerId: const MarkerId('current-location'),
        position: _selectedPosition,
        infoWindow: const InfoWindow(
          title: 'Your Current Location',
        ),
      );
    });

    _mapController?.animateCamera(
      CameraUpdate.newLatLng(_selectedPosition),
    );
  }
}
