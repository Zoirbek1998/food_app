import 'package:food_app/data/api/api_client.dart';
import 'package:food_app/models/address_model.dart';
import 'package:food_app/utils/app_constants.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  LocationRepo({required this.apiClient, required this.sharedPreferences});

// locationni yangilash uchun
  Future<Response> getAddressfromGeocade(LatLng latLng) async {
    return await apiClient.getData("${AppConstants.GEOCODE_URI}"
        "?lat=${latLng.latitude}&lng=${latLng.longitude}");
  }

  //Foydalanuvchi manzilini olish
  String getUserAddress() {
    return sharedPreferences.getString(AppConstants.USER_ADDRESS) ?? '';
  }

  // bazaga address qo'shish
  Future<Response> addAddress(AddressModel addressModel) async {
    return await apiClient.postData(
        AppConstants.ADD_USER_ADDRESS, addressModel.toJson());
  }

  //Barcha manzilni oling
  Future<Response> getAllAddress() async {
    return await apiClient.getData(AppConstants.ADDRESS_LIST_URI);
  }

  //foydalanuvchi manzilini saqlash
  Future<bool> saveUserAddress(String address) async {
    apiClient.updateHeader(sharedPreferences.getString(AppConstants.TOKEN)!);

    return await sharedPreferences.setString(
        AppConstants.USER_ADDRESS, address);
  }
}
