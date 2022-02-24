// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_color.dart';

class Helpers {

  IconThemeData getIconTheme(bool darkMode) {
   if (darkMode == true) {
     return IconThemeData(color: AppColors.white);
   }
   else {
     return IconThemeData(color: Colors.grey[700]);
   }
  }

  Color getBackgroundColor(bool darkMode) {
    if (darkMode == true) {
      return AppColors.darkModeBackground;
    }
    else {
      return AppColors.white;
    }
  }
}