import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFieldSubmittedValue;
  final FormFieldValidator onValidator;

  final TextInputType keyboardType;
  final String hint;
  final bool obsureText;
  final bool enable, autoFocus;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? suffixIconOnpressed;

  const InputTextField({
    super.key,
    required this.myController,
    required this.focusNode,
    required this.onFieldSubmittedValue,
    required this.keyboardType,
    required this.obsureText,
    required this.hint,
    this.enable = true,
    required this.onValidator,
    this.autoFocus = false,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconOnpressed
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8,top: 3),
      child: TextFormField(
        controller: myController,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmittedValue,
        validator: onValidator,
        keyboardType: keyboardType,
        obscureText: obsureText,
        enabled: enable,
        cursorColor: AppColors.greenColor,
        style: const TextStyle(color: AppColors.greenColor),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.withOpacity(0.4),
          prefixIcon: Icon(prefixIcon!,color: AppColors.greenColor),
          suffixIcon: IconButton(
            icon: Icon(suffixIcon, color: AppColors.greenColor),
            onPressed: suffixIconOnpressed
          ),
          hintText: hint,
          contentPadding: const EdgeInsets.all(20),
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(height: 0, color: AppColors.greenColor),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.greenColor,
              )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greenColor),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greenColor),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greenColor),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
        ),
      ),
    );
  }
}
