import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/base/custom_loader.dart';
import 'package:food_app/base/show_custom_snakbar.dart';
import 'package:food_app/base/signup_body_model.dart';
import 'package:food_app/controllers/auth_controller.dart';
import 'package:food_app/helper/route_helper.dart';
import 'package:food_app/utils/app_colors.dart';
import 'package:food_app/utils/dimensions.dart';
import 'package:food_app/widgets/app_text_field.dart';
import 'package:food_app/widgets/big_text.dart';

import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      "t.png",
      "f.png",
      "g.png",
    ];

    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String password = passwordController.text.trim();
      String email = emailController.text.trim();
      String phone = phoneController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar("Type in youre name ", title: "Name");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Type in youre phone number ",
            title: "Phone Number");
      } else if (email.isEmpty) {
        showCustomSnackBar("Type in youre email address ",
            title: "Email address");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid email address",
            title: "Email address");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in youre password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can to be less then six characters",
            title: "Password");
      } else {
        showCustomSnackBar("All went well", title: "Perfect");
        SignUpBody signUpBody = SignUpBody(
          name: name,
          email: email,
          password: password,
          phone: phone,
        );
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print("Success registration");
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
            print(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (_authController) {
          return !_authController.isLoading
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.screenHeight * 0.05,
                      ),
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

                      // email
                      AppTextField(
                          textController: emailController,
                          textHint: "Email",
                          icon: Icons.email_outlined),
                      SizedBox(height: Dimensions.height20),
                      // password
                      AppTextField(
                          isObscure: true,
                          textController: passwordController,
                          textHint: "Password",
                          icon: Icons.password_outlined),
                      SizedBox(height: Dimensions.height20),
                      // Name
                      AppTextField(
                          textController: nameController,
                          textHint: "Name",
                          icon: Icons.person_outline),
                      SizedBox(height: Dimensions.height20),
                      // Phone
                      AppTextField(
                          textController: phoneController,
                          textHint: "Phone",
                          icon: Icons.phone_outlined),
                      SizedBox(height: Dimensions.height20),
                      //sign up btn
                      InkWell(
                        onTap: () {
                          _registration(_authController);
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
                              text: "Sign Up",
                              size: Dimensions.font20 + Dimensions.font20 / 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),
                      RichText(
                        text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.back(),
                          text: "Have an account already ?",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20,
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.screenHeight * 0.05),
                      RichText(
                        text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.back(),
                          text: "Sign Up using one of the following methods",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font16,
                          ),
                        ),
                      ),
                      Wrap(
                        children: List.generate(
                            3,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: Dimensions.radius30,
                                    backgroundImage: AssetImage(
                                        "assets/images/" + signUpImages[index]),
                                  ),
                                )),
                      ),
                    ],
                  ),
                )
              : const CustomLoader();
        },
      ),
    );
  }
}
