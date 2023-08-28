import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyle{

  static normalTextStyle(){
    return const TextStyle(
      color: AppColors.greenColor,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
  }

  static buttonsTextStyle(){
    return const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );
  }

  static largeTextStyle(){
    return const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 30,
    );
  }

 static extraLargeTextStyle(){
    return const TextStyle(
      color: AppColors.greenColor,
      fontWeight: FontWeight.bold,
      height: 1.2,
      fontSize: 35,
    );
  }
}