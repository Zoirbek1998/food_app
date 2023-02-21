import 'package:food_app/base/signup_body_model.dart';
import 'package:food_app/data/repository/auth_repo.dart';
import 'package:food_app/models/response_model.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String email, String password) async {
    print('GET TOKEN');
    print(authRepo.getUserToken().toString());
    _isLoading = true;
    update();
    Response response = await authRepo.login(email, password);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("BACKEND TOKEN");

      authRepo.saveUserToken(response.body["token"]);
      print("My token id " + response.body["token"].toString());
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(true, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  bool userLoggedIn() {
    return authRepo.getUserLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedDate();
  }
}
