import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowy/presentation/resources/color_manager.dart';
import 'package:glowy/presentation/resources/font_manager.dart';
import 'package:glowy/presentation/resources/strings_manager.dart';
import 'package:glowy/presentation/resources/styles_manager.dart';
import 'package:glowy/presentation/resources/values_manager.dart';

class AboutView extends StatelessWidget {
  final String aboutText;
  const AboutView({super.key, required this.aboutText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: AppBar(
        backgroundColor: ColorManager.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorManager.white, size: 24.0.r),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppStrings.about,
          style: getBoldStyle(color: ColorManager.white, fontSize: FontSize.s22.sp),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 24.0.w,
            vertical: AppPadding.p16.h,
          ),
          child: Text(
            aboutText,
            style: getRegularStyle(
              color: ColorManager.white,
              fontSize: FontSize.s20.sp,
            ).copyWith(height: 1.6),
          ),
        ),
      ),
    );
  }
}
