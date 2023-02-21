import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/base/show_custom_snakbar.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/helper/route_helper.dart';
import 'package:food_app/page/auth/sign_up_page.dart';
import 'package:food_app/utils/app_colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_text_field.dart';
import 'package:food_app/widgets/big_text.dart';

import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();

      if (phone.isEmpty) {
        showCustomSnackBar("Type in youre phone number ",
            title: "Phone Number");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in youre password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can to be less then six characters",
            title: "Password");
      } else {
        showCustomSnackBar("All went well", title: "Perfect");

        authController.login(phone, password).then((status) {
          if (status.isSuccess) {
            print("Success login");
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (authController) {
            return !authController.isLoading
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        //app logo
                        Container(
                          height: Dimensions.screenHeight * 0.25,
                          child: const Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 80,
                              backgroundImage:
                                  AssetImage("assets/images/logo part 1.png"),
                            ),
                          ),
                        ),

                        //welcome
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            bottom: Dimensions.height10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello",
                                style: TextStyle(
                                  fontSize: Dimensions.font20 * 3 +
                                      Dimensions.font20 / 2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  // recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                                  // text: "Have an account already ?",
                                  text: "Sign Into your account",
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: Dimensions.font20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        AppTextField(
                            textController: phoneController,
                            textHint: "Phone",
                            icon: Icons.phone_outlined),
                        SizedBox(height: Dimensions.height20),
                        // password
                        AppTextField(
                            isObscure: true,
                            textController: passwordController,
                            textHint: "Password",
                            icon: Icons.password_outlined),
                        SizedBox(height: Dimensions.height20),
                        Row(
                          children: [
                            Expanded(child: Container()),
                            RichText(
                              text: TextSpan(
                                // recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                                text: "Have an account already ?",
                                // text: "Sign Into your account",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.width20,
                            )
                          ],
                        ),
                        SizedBox(height: Dimensions.screenHeight * 0.05),

                        //sign in btn
                        GestureDetector(
                          onTap: () {
                            _login(authController);
                          },
                          child: Container(
                            height: Dimensions.screenHeight / 14,
                            width: Dimensions.screenWidth / 1.5,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                              color: AppColors.mainColor,
                            ),
                            child: Center(
                              child: BigText(
                                text: "Sign In",
                                size: Dimensions.font20 + Dimensions.font20 / 2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: Dimensions.screenHeight * 0.05),

                        RichText(
                          text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.back(),
                              text: "Don\'t an account? ",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font20,
                              ),
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Get.to(() => SignUpPage(),
                                        transition: Transition.fade),
                                  text: "Create",
                                  style: TextStyle(
                                      color: AppColors.mainBackColor,
                                      fontSize: Dimensions.font20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  )
                : const CustomLoader();
          },
        ));
  }
}
