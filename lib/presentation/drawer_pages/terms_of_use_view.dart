import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowy/presentation/resources/color_manager.dart';
import 'package:glowy/presentation/resources/font_manager.dart';
import 'package:glowy/presentation/resources/strings_manager.dart';
import 'package:glowy/presentation/resources/styles_manager.dart';
import 'package:glowy/presentation/resources/values_manager.dart';

class TermsOfUseView extends StatelessWidget {
  final String termsOfUseText;
  const TermsOfUseView({super.key, required this.termsOfUseText});

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
          AppStrings.termsOfUse,
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
            termsOfUseText,
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
