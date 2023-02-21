import 'package:flutter/material.dart';
import 'package:food_app/controllers/location_controller.dart';
import 'package:food_app/utils/api_key_elemet.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController googleMapController;

  const PickAddressMap({
    super.key,
    required this.fromSignup,
    required this.fromAddress,
    required this.googleMapController,
  });

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    super.initState();

    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = LatLng(41.279933, 69.271805);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(
            double.parse(Get.find<LocationController>()
                .getAddress[ApiKeyElement.latitude]),
            double.parse(Get.find<LocationController>()
                .getAddress[ApiKeyElement.longitude]));
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        body: SafeArea(
            child: Center(
          child: SizedBox(
            width: double.maxFinite,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: _initialPosition, zoom: 17),
                  zoomControlsEnabled: false,
                  onCameraMove: (CameraPosition cameraPosition) {
                    _cameraPosition = cameraPosition;
                  },
                  onCameraIdle: () {
                    Get.find<LocationController>()
                        .updatePosition(_cameraPosition, false);
                  },
                ),
                Center(
                  child: !locationController.loading
                      ? Image.asset(
                          "assets/images/user_marker.png",
                          height: 50,
                          width: 50,
                        )
                      : Lottie.asset('assets/lotti/cricle.json'),
                ),
              ],
            ),
          ),
        )),
      );
    });
  }
}
