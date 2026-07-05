import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'color_manager.dart';
import 'font_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: ColorManager.background,
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: ColorManager.primary,
    ),
    // Main colors
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightPrimary, // ripple effect color
    // Card View theme
    cardTheme: CardThemeData(
      color: ColorManager.surface,
      // ignore: deprecated_member_use
      shadowColor: ColorManager.black.withOpacity(0.5),
      elevation: AppSize.s4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s12.r),
      ),
    ),

    // App bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: ColorManager.background,
      foregroundColor: ColorManager.white,
      titleTextStyle: getMediumStyle(
        color: ColorManager.white,
        fontSize: FontSize.s24,
      ),
    ),

    // Button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary,
    ),

    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getSemiboldStyle(
          color: ColorManager.black,
          fontSize: FontSize.s16,
        ),
        foregroundColor: ColorManager.black, // Text color for button
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12.r),
        ),
      ),
    ),

    // Text theme
    textTheme: TextTheme(
      displayLarge: getSemiboldStyle(
        color: ColorManager.white,
        fontSize: FontSize.s22.sp,
      ),
      displaySmall: getLightStyle(
        color: ColorManager.white,
        fontSize: FontSize.s16.sp,
      ),
      displayMedium: getSemiboldStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s20.sp,
      ),
      headlineLarge: getSemiboldStyle(
        color: ColorManager.white,
        fontSize: FontSize.s18.sp,
      ),
      headlineMedium: getRegularStyle(
        color: ColorManager.white,
        fontSize: FontSize.s16.sp,
      ),
      headlineSmall: getMediumStyle(
        color: ColorManager.white,
        fontSize: FontSize.s14.sp,
      ),
      titleMedium: getMediumStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s16.sp,
      ),
      titleSmall: getRegularStyle(
        color: ColorManager.white,
        fontSize: FontSize.s14.sp,
      ),
      bodyLarge: getRegularStyle(
        color: ColorManager.white,
        fontSize: FontSize.s16.sp,
      ),
      bodyMedium: getRegularStyle(
        color: ColorManager.white,
        fontSize: FontSize.s14.sp,
      ),
      bodySmall: getRegularStyle(
        color: ColorManager.lightGrey,
        fontSize: FontSize.s12.sp,
      ),
      labelSmall: getBoldStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s12.sp,
      ),
    ),

    // Input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      // Content padding
      contentPadding: EdgeInsets.all(AppPadding.p8),
      // Hint Style
      hintStyle: getRegularStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s14,
      ),
      // Label Style
      labelStyle: getRegularStyle(
        color: ColorManager.grey,
        fontSize: FontSize.s16,
      ),
      // Error Style
      errorStyle: getRegularStyle(color: ColorManager.error),

      // Enabled border
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.surface, width: AppSize.s1),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s12.r)),
      ),
      // Focused border
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s12.r)),
      ),
      // Error border
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s12.r)),
      ),
      // Focused error border
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s12.r)),
      ),
      fillColor: ColorManager.surface,
      filled: true,
    ),
  );
}
