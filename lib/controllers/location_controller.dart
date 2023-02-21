import 'dart:convert';

import 'package:food_app/data/repository/location_repo.dart';
import 'package:food_app/models/address_model.dart';
import 'package:food_app/models/response_model.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;

  LocationController({required this.locationRepo});

  bool _loading = false;
  late Position _position;
  late Position _pickPosition;

  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();

  Placemark get placemark => _placemark;
  Placemark get pickPlacemark => _pickPlacemark;

  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;

  late List<AddressModel> _allAddressList = [];
  List<AddressModel> get allAddress => _addressList;

  List<String> _addressTypeList = ["home", "office", "others"];
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  late GoogleMapController _mapController;
  GoogleMapController get mapConroller => _mapController;

  bool _updateAddressData = true;
  bool _changeAddress = true;

  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;

  }

  // locationni yangilash uchun
  void updatePosition(CameraPosition position, bool fromAdress) async {
    if (_updateAddressData) {
      _loading = true;
      update();

      try {
        if (fromAdress) {
          _position = Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            heading: 1,
            accuracy: 1,
            altitude: 1,
            speedAccuracy: 1,
            speed: 1,
          );
        } else {
          _pickPosition = Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            heading: 1,
            accuracy: 1,
            altitude: 1,
            speedAccuracy: 1,
            speed: 1,
          );
        }

        // lakatsiyani yangilash
        if (_changeAddress) {
          String _address = await getAddressfromGeocade(
            LatLng(position.target.latitude, position.target.longitude),
          );

          fromAdress
              ? _placemark = Placemark(name: _address)
              : _pickPlacemark = Placemark(name: _address);

          // print(_placemark);
        } else {}
      } catch (e) {
        print(e);
      }
      _loading = false;
      update();
    }
  }

  Future<String> getAddressfromGeocade(LatLng latLng) async {
    String _address = "Unknown Location Found";
    Response response = await locationRepo.getAddressfromGeocade(latLng);

    if (response.body["status"] == 'OK') {
      _address = response.body["results"][0]["formatted_address"].toString();
      print('printing address $_address');
    } else {
      print("Error getting the google api");
    }
    update();
    return _address;
  }

  //Foydalanuvchi manzilini olish
  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    _getAddress = jsonDecode(locationRepo.getUserAddress());

    try {
      _addressModel =
          AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    } catch (e) {
      print(e);
    }

    return _addressModel;
  }

  //Manzil turi indeksini o'rnating
  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  //bazaga Address qo'shish
  Future<ResponseModel> addAdress(AddressModel addressModel) async {
    _loading = true;
    update();

    Response response = await locationRepo.addAddress(addressModel);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      await getAddressList();
      String message = response.body('message');
      responseModel = ResponseModel(true, message);
      await saveUserAddress(addressModel);
    } else {
      print("could't save the address");
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }


  Future<void> getAddressList() async {
    Response response = await locationRepo.getAllAddress();

    if (response.statusCode == 200) {
      _addressList = [];
      _allAddressList = [];
      response.body.forEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    } else {
      _addressList = [];
      _allAddressList = [];
    }
    update();
  }

  //foydalanuvchi manzilini saqlash
  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }

  void clearAddressList() {
    _addressList = [];
    _allAddressList = [];
    update();
  }

  String getUserAddressFromLocalStore() {
    return locationRepo.getUserAddress();
  }
}
