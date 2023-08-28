import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_style.dart';

class AppButtons{

  normalButton({String? text, VoidCallback? onPressed, bool? loading = false}){
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.greenColor,
        ),
        child: Center(
          child: loading == true ? Container(
            width: 20,
            height: 20,
            child: const CircularProgressIndicator(color: AppColors.whiteColor,),
          ) : Text(text!,style: AppTextStyle.buttonsTextStyle()),
        ),
      ),
    );
  }

  normalButtonWithIcon({String? text, VoidCallback? onPressed, bool? loading = false, IconData? icon}){
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.greenColor,
        ),
        child: Center(
          child: loading == true ? Container(
            width: 20,
            height: 20,
            child: const CircularProgressIndicator(color: AppColors.whiteColor),
          ) : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,color: Colors.white),
              const SizedBox(width: 5),
              Text(text!,style: AppTextStyle.normalTextStyle())
            ],
          ),
        ),
      ),
    );
  }
}