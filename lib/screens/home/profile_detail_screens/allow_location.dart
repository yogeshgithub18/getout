import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common_screens/app_text.dart';
import '../../../common_screens/colors.dart';

class AllowLocation extends StatefulWidget {
  const AllowLocation({super.key});

  @override
  State<AllowLocation> createState() => _AllowLocationState();
}

class _AllowLocationState extends State<AllowLocation> {

  GoogleMapController? mapController;
  LatLng? _center;
  Positioned? _currentPosition;

  @override
  void initState() {
    super.initState();
   // _getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoRRes.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 3.h),
          const AppTexts.inter24W600(
            'What is Your Location?',
            textColor: ColoRRes.textColor,
          ),
          SizedBox(height: 1.h),
          const AppTexts.inter14W400(
            'We need to know your location in order to \nsuggest Profile Creating.',
            textColor: ColoRRes.subTextColor,
          ),
          SizedBox(height: 10.h),
          Center(child: SvgPicture.asset('assets/images/allowLocation.svg'))
        ],
      ),
    );
  }
}
