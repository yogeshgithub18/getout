import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_out/common_screens/colors.dart';
import 'package:get_out/controller/home_controller.dart';
import 'package:get_out/modal/register_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:location/location.dart' as l;
import '../../../../common_screens/app_text.dart';
import '../../../../custom_app_screen/custom_main_button.dart';
import '../../../base_utils/base_overlays.dart';
import '../../../controller/base_controller.dart';
import '../../../storage/base_shared_preference.dart';
import '../../../storage/sp_keys.dart';

class HomeMapScreen extends StatefulWidget {
  const HomeMapScreen({super.key});

  @override
  State<HomeMapScreen> createState() => _HomeMapScreenState();
}

class _HomeMapScreenState extends State<HomeMapScreen> {
  HomeController controller=Get.find<HomeController>();
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  static const LatLng _initialPosition = LatLng(37.77608993377768, -122.42246700282115); // San Francisco
  LatLng _selectedPosition = _initialPosition;
  GoogleMapController? _mapController;
  Marker? _selectedMarker;
  l.Location location = l.Location();
  @override
  void initState() {
    controller.searchController.value.text='';
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
    controller.searchController.value.addListener(() async {
        controller.showSuffixIcon.value = controller.searchController.value.text.isNotEmpty;
        print("jbjhbjdddc");
       await controller.fetchSuggestions(controller.searchController.value.text);
    });
    super.initState();
    // Automatically fetch and set user’s current location
    goToCurrentLocation();
  }

  void clearSearch() {
    controller.filteredLocations.value=[];
    controller.searchController.value.text='';
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  RangeValues currentRangeValues = const RangeValues(1, 12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColoRRes.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 42.sp),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ColoRRes.textColor, width: 1),
        ),
        child: FloatingActionButton(
          onPressed: () {
            goToCurrentLocation();
          },
          backgroundColor: ColoRRes.white.withOpacity(0.8),
          child: SvgPicture.asset('assets/home/autof.svg'),
        ),
      ),
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
                   Obx(()=>  (controller.filteredLocations.isNotEmpty && controller.searchController.value.text.isNotEmpty)?
                      Container(
                        margin: EdgeInsets.only(top: 30.sp),
                        height: controller.filteredLocations.isNotEmpty ? (controller.filteredLocations.length * 50.sp).clamp(0, 70.sp):0,
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
                                  controller.lat=_selectedPosition.latitude.toString();
                                  controller.lng=_selectedPosition.longitude.toString();
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
                      ):const SizedBox.shrink()),
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
                    controller.updateLatlng();
                    //continueButton();
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
      controller.lat=position.latitude.toString();
      controller.lng=position.longitude.toString();
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

  Future<void> goToCurrentLocation() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        Get.snackbar('Location Services Disabled', 'Please enable location services');
        return;
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        Get.snackbar('Location Permission Denied', 'Please allow location access');
        return;
      }
    }

    BaseOverlays().showLoader();
    final LocationData currentLocation = await location.getLocation();
    BaseOverlays().dismissOverlay(showLoader: true);

    LatLng selectedLatLng = LatLng(currentLocation.latitude!, currentLocation.longitude!);
    controller.lat = currentLocation.latitude.toString();
    controller.lng = currentLocation.longitude.toString();

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

  Future<void> continueButton()async {
    Map<String,dynamic> data = await BaseSharedPreference().getJson(SpKeys().user);
    UserData user= UserData.fromJson(data);
    user.lattitute=controller.lat;
    user.longitute=controller.lng;
    Get.find<BaseController>().user.value.lattitute=user.lattitute;
    Get.find<BaseController>().user.value.longitute=user.longitute;
    BaseSharedPreference().setJson(SpKeys().user,user.toJson());
    Get.back();
  }

}



