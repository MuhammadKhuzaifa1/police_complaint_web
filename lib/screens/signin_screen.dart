import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:police_complaint_web/components/app_buttons.dart';
import 'package:police_complaint_web/constants/app_assets.dart';
import 'package:police_complaint_web/constants/app_colors.dart';
import 'package:police_complaint_web/constants/app_text_style.dart';
import 'package:get/get.dart';
import 'package:police_complaint_web/controllers/signin_controller.dart';
import 'package:police_complaint_web/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import '../components/app_textfield.dart';
import '../utilites/utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final ValueNotifier<bool> _hide = ValueNotifier(true);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("5555555555555555555555555555555555555555555555555");
    final signInController = Provider.of<SignInController>(context, listen: false);
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Image.asset(
              AppAssets.pakistanFlag1,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(50),
              child: Center(
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login",
                        style: AppTextStyle.extraLargeTextStyle(),
                      ),
                      const SizedBox(height: 50),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email",
                            style: AppTextStyle.normalTextStyle(),
                          ),
                          const SizedBox(height: 3),
                          InputTextField(
                            myController: emailController,
                            focusNode: emailFocusNode,
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            obsureText: false,
                            hint: "Enter your email",
                            onFieldSubmittedValue: (value) {
                              Utils.fieldFocus(
                                  context, emailFocusNode, passwordFocusNode);
                            },
                            onValidator: (value) {
                              final bool isValid = EmailValidator.validate(emailController.text);
                              if (value.toString().isNotEmpty) {
                                if (isValid) {
                                  return null;
                                } else {
                                  return "Invalid Email";
                                }
                              } else {
                                return "Enter your email";
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Password",
                            style: AppTextStyle.normalTextStyle(),
                          ),
                          const SizedBox(height: 3),
                          ValueListenableBuilder(
                            valueListenable: _hide,
                            builder: (context, value, child) {
                              return InputTextField(
                                myController: passwordController,
                                focusNode: passwordFocusNode,
                                prefixIcon: Icons.lock_open_outlined,
                                keyboardType: TextInputType.visiblePassword,
                                obsureText: _hide.value,
                                hint: "Enter your Password",
                                suffixIcon:
                                value ? Icons.visibility_off : Icons.visibility,
                                suffixIconOnpressed: () {
                                  _hide.value = !_hide.value;
                                },
                                onFieldSubmittedValue: (value) {},
                                onValidator: (value) {
                                  if (value.toString().isNotEmpty) {
                                    if (value.toString().length >= 8) {
                                      return null;
                                    } else {
                                      return "Password must be grate then 8 characters";
                                    }
                                  } else {
                                    return "Enter your password";
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(color: AppColors.greenColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Consumer<SignInController>(
                        builder: (context, value, child) {
                          return AppButtons().normalButton(
                            onPressed: () {
                              if(_formkey.currentState!.validate()){
                                signInController.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text
                                );
                              }
                            },
                            text: "LOGIN",
                            loading: value.loading,
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?",style: TextStyle(color: AppColors.greenColor),),
                          GestureDetector(
                            onTap: () {Get.to(()=> SignUpScreen());},
                            child: const Text(
                              " SignUp",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}
