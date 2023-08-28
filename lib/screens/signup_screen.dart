import 'dart:typed_data';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:police_complaint_web/components/app_buttons.dart';
import 'package:police_complaint_web/constants/app_assets.dart';
import 'package:police_complaint_web/constants/app_colors.dart';
import 'package:police_complaint_web/constants/app_text_style.dart';
import 'package:get/get.dart';
import 'package:police_complaint_web/constants/firebase_references.dart';
import 'package:police_complaint_web/controllers/signup_controller.dart';
import 'package:police_complaint_web/screens/signin_screen.dart';
import 'package:provider/provider.dart';
import '../components/app_textfield.dart';
import '../constants/district_list.dart';
import '../utilites/utils.dart';
import 'dart:io';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final ValueNotifier<bool> _hide = ValueNotifier(true);
  String? selectedDistricts;
  Uint8List? _imageData;

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
    final signUpController = Provider.of<SignupController>(context, listen: false);
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
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Register",
                            style: AppTextStyle.extraLargeTextStyle(),
                          ),
                          const SizedBox(height: 20),
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
                          const SizedBox(height: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Select the Station City",
                                style: AppTextStyle.normalTextStyle(),
                              ),
                              const SizedBox(height: 3),
                              DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint:  Row(
                                    children: [
                                      const Icon(
                                        Icons.list,
                                        size: 20,
                                        color: AppColors.greenColor,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Select your Districts',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(height: 0, color: AppColors.greenColor),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  items: Districts().district_list.map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )).toList(),
                                  value: selectedDistricts,
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedDistricts = value;
                                    });
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: 55,
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(left: 14, right: 14),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: AppColors.greenColor),
                                      color: Colors.grey.withOpacity(0.4),
                                    ),
                                    elevation: 0,
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                    ),
                                    iconSize: 14,
                                    iconEnabledColor: AppColors.greenColor,
                                    iconDisabledColor: AppColors.greenColor,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(color: AppColors.greenColor),
                                      color: AppColors.greenColor,
                                    ),
                                    offset: const Offset(-20, 0),
                                    scrollbarTheme: ScrollbarThemeData(
                                      radius: const Radius.circular(40),
                                      thickness: MaterialStateProperty.all<double>(6),
                                      thumbVisibility: MaterialStateProperty.all<bool>(true),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                    padding: EdgeInsets.only(left: 14, right: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Upload Police Station Picture",
                                style: AppTextStyle.normalTextStyle(),
                              ),
                              const SizedBox(height: 3),
                              _imageData.isNull ? Container(
                                width: 150,
                                height: 140,
                                decoration: BoxDecoration(
                                    color: AppColors.greenColor,
                                    borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                    child: IconButton(icon: Icon(Icons.camera_alt), color: AppColors.whiteColor,onPressed:() => _pickImage(),)
                                ),
                              ) : Container(
                                width: 150,
                                height: 140,
                                decoration: BoxDecoration(
                                    color: AppColors.greenColor,
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: MemoryImage(_imageData!),
                                      fit: BoxFit.cover,
                                    )
                                ),
                                child: Center(
                                    child: IconButton(icon: Icon(Icons.camera_alt), color: AppColors.whiteColor,onPressed:() => _pickImage())
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
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
                          Consumer<SignupController>(
                            builder: (context, value, child) {
                              return AppButtons().normalButton(
                                onPressed: () {
                                  if(_formkey.currentState!.validate()){
                                    if(selectedDistricts!=null){
                                      signUpController.userSignUp(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        district: selectedDistricts,
                                        dataa: _imageData,
                                      );
                                    }else{
                                      Utils.toastMessage("Please select your station city");
                                    }
                                  }
                                },
                                text: "SignUp",
                                loading: value.loading,
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have account?",style: TextStyle(color: AppColors.greenColor),),
                              GestureDetector(
                                onTap: () {
                                  Get.off(SignInScreen());
                                },
                                child: const Text(
                                  " SignIn",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
              ),
            ),
          ),

        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final mediaInfo = await ImagePickerWeb.getImageInfo;
    if (mediaInfo != null) {
      setState(() {
        _imageData = mediaInfo.data;
      });
    }
  }

  // Future<void> _pickImage() async {
  //   final mediaInfo = await ImagePickerWeb.getImageInfo;
  //   if (mediaInfo != null) {
  //     Uint8List? compressedData = await compressImage(mediaInfo.data);
  //     if (compressedData != null) {
  //       setState(() {
  //         _imageData = compressedData;
  //       });
  //     }
  //   }
  // }
  // Future<Uint8List?> compressImage(Uint8List? data) async {
  //   if (data == null) return null;
  //   final compressedData = await FlutterImageCompress.compressWithList(
  //     data,
  //     quality: 70, // You can set the quality between 0 and 100
  //   );
  //   return compressedData;
  // }



}
