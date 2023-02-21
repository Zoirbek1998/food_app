import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/controllers/location_controller.dart';
import 'package:food_app/controllers/user_controller.dart';
import 'package:food_app/helper/route_helper.dart';
import 'package:food_app/models/address_model.dart';
import 'package:food_app/page/address/pick_address_map.dart';
import 'package:food_app/utils/app_colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_icon.dart';
import 'package:food_app/widgets/app_text_field.dart';
import 'package:food_app/widgets/big_text.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  late CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(45.51563, -122.677433), zoom: 17);
  late LatLng _initialPosition = LatLng(45.51563, -122.677433);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }

    if (Get.find<LocationController>().addressList.isNotEmpty) {
      if (Get.find<LocationController>().getUserAddressFromLocalStore() == "") {
        Get.find<LocationController>()
            .saveUserAddress(Get.find<LocationController>().addressList.last);
      }

      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
        target: LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"]),
        ),
      );
      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address Page'),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          if (userController.userModel != null &&
              _contactPersonName.text.isEmpty) {
            _contactPersonName.text = "${userController.userModel?.name}";
            _contactPersonNumber.text = "${userController.userModel?.name}";
            if (Get.find<LocationController>().addressList.isNotEmpty) {
              _addressController.text =
                  Get.find<LocationController>().getUserAddress().address;
            }
          }
          return GetBuilder<LocationController>(
            builder: (locationController) {
              _addressController.text =
                  "${locationController.placemark.name ?? ''}"
                  "${locationController.placemark.locality ?? ''}"
                  "${locationController.placemark.postalCode ?? ''}"
                  "${locationController.placemark.country ?? ''}";
              print("address in my view is " + _addressController.text);
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 140,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 2,
                          color: AppColors.mainColor,
                        ),
                      ),
                      child: Stack(
                        children: [
                          GoogleMap(
                            initialCameraPosition: CameraPosition(
                                target: _initialPosition, zoom: 17),
                            onTap: (latlng) {
                              Get.toNamed(RouteHelper.getPickAddressPage(),
                                  arguments: PickAddressMap(
                                    fromAddress: true,
                                    fromSignup: false,
                                    googleMapController: locationController.mapConroller,
                                  ));
                            },
                            zoomControlsEnabled: false,
                            compassEnabled: false,
                            indoorViewEnabled: true,
                            mapToolbarEnabled: false,
                            myLocationEnabled: true,
                            onCameraIdle: () {
                              locationController.updatePosition(
                                  _cameraPosition, true);
                            },
                            onCameraMove: ((position) =>
                                _cameraPosition == position),
                            onMapCreated: (GoogleMapController controller) {
                              locationController.setMapController(controller);
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Dimensions.width20, top: Dimensions.height20),
                      child: SizedBox(
                        height: 50,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                locationController.addressTypeList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  locationController.setAddressTypeIndex(index);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: Dimensions.height10,
                                      horizontal: Dimensions.width20),
                                  margin: EdgeInsets.only(
                                      right: Dimensions.width10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20 / 4),
                                    color: Theme.of(context).cardColor,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[200]!,
                                          spreadRadius: 1,
                                          blurRadius: 5),
                                    ],
                                  ),
                                  child: Icon(
                                      index == 0
                                          ? Icons.home_filled
                                          : index == 1
                                              ? Icons.work
                                              : Icons.location_on,
                                      color: locationController
                                                  .addressTypeIndex ==
                                              index
                                          ? AppColors.mainColor
                                          : Theme.of(context).disabledColor),
                                ),
                              );
                            }),
                      ),
                    ),
                    SizedBox(height: Dimensions.height20),
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.width20),
                      child: BigText(text: 'Delivery Address'),
                    ),
                    SizedBox(height: Dimensions.height20),
                    AppTextField(
                        textController: _addressController,
                        textHint: 'Your address',
                        icon: Icons.map),
                    SizedBox(height: Dimensions.height20),
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.width20),
                      child: BigText(text: 'Contact name'),
                    ),
                    AppTextField(
                        textController: _contactPersonName,
                        textHint: 'Your name',
                        icon: Icons.person_outline),
                    SizedBox(height: Dimensions.height20),
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.width20),
                      child: BigText(text: 'Your number'),
                    ),
                    AppTextField(
                        textController: _contactPersonNumber,
                        textHint: 'Your Phone',
                        icon: Icons.phone_outlined),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: (locationContoller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: Dimensions.height20 * 8,
                padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                decoration: BoxDecoration(
                  color: AppColors.buttonBackgroudColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        AddressModel _addressModel = AddressModel(
                          addressType: locationContoller
                              .addressList[locationContoller.addressTypeIndex],
                          contactPersonName: _contactPersonName.text,
                          contactPersonPhone: _contactPersonNumber.text,
                          address: _addressController.text,
                          latitude:
                              locationContoller.position.latitude.toString(),
                          longitude:
                              locationContoller.position.longitude.toString(),
                        );
                        locationContoller
                            .addAdress(_addressModel)
                            .then((response) {
                          if (response.isSuccess) {
                            // Get.back();
                            Get.toNamed(RouteHelper.getInitial());
                            Get.snackbar("Address", 'Added Successfully');
                          } else {
                            Get.snackbar("Address", "Couldn't save address");
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor,
                        ),
                        child: BigText(
                          text: "Save address",
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
