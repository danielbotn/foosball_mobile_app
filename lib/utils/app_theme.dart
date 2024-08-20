import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_color.dart';

class AppTheme {
  get darkTheme => ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: AppBarTheme(
          color: AppColors.textBlack,
          systemOverlayStyle: SystemUiOverlayStyle.light, // Use this instead of brightness
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: AppColors.textGrey),
          labelStyle: TextStyle(color: AppColors.white),
        ),
        brightness: Brightness.dark,
        canvasColor: AppColors.textBlack,
        colorScheme: ColorScheme.dark(
          primary: AppColors.darkPink,
          onPrimary: Colors.white,
          secondary: AppColors.darkPink,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      );

  get lightTheme => ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: AppBarTheme(
          color: AppColors.grey2,
          systemOverlayStyle: SystemUiOverlayStyle.dark, // Use this instead of brightness
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: AppColors.textGrey),
          labelStyle: TextStyle(color: AppColors.white),
        ),
        brightness: Brightness.light,
        canvasColor: AppColors.white,
        colorScheme: ColorScheme.light(
          primary: AppColors.grey2,
          onPrimary: Colors.black,
          secondary: AppColors.grey2,
        ),
        iconTheme: IconThemeData(color: Colors.black),
      );
}
