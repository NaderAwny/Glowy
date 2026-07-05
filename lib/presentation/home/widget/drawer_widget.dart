import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glowy/domain/model/get_drawer_model.dart';
import 'package:glowy/presentation/common/state_randrer/state_randrer_impl.dart';
import 'package:glowy/presentation/home/get_drawer_data_cubit/get_drawer_data_cubit.dart';
import 'package:glowy/presentation/home/get_drawer_data_cubit/get_drawer_data_state.dart';
import 'package:glowy/presentation/resources/assets_manager.dart';
import 'package:glowy/presentation/resources/color_manager.dart';
import 'package:glowy/presentation/resources/icons_manager.dart';
import 'package:glowy/presentation/resources/routes_manager.dart';
import 'package:glowy/presentation/resources/strings_manager.dart';
import 'package:glowy/presentation/resources/values_manager.dart';
import 'package:glowy/presentation/drawer_pages/about_view.dart';
import 'package:glowy/presentation/drawer_pages/privacy_policy_view.dart';
import 'package:glowy/presentation/drawer_pages/terms_of_use_view.dart';

class DrawerWidget extends StatelessWidget {
  final String appId;
  const DrawerWidget({super.key, required this.appId});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorManager.background,
      child: BlocBuilder<GetDrawerDataCubit, GetDrawerDataState>(
        builder: (context, state) {
          final drawerData = state.data;
          final mainWidget =
              state.flowState?.getScreenWidget(
                context,
                _getContentWidget(context, drawerData),
                () {
                  context.read<GetDrawerDataCubit>().getDrawerData(appId);
                },
              ) ??
              _getContentWidget(context, drawerData);

          return mainWidget;
        },
      ),
    );
  }

  Widget _getContentWidget(BuildContext context, DrawerAppObject? drawerData) {
    final app = drawerData?.data.apps;

    return Padding(
      padding: EdgeInsets.only(top: AppPadding.p20),
      child: ListView(
        children: [
          _titleDrawer(context, app?.name),
          SizedBox(height: AppSize.s14.h),
          itemDrawer(context, AppStrings.home, IconAssets.home, () {
            Navigator.pushNamed(context, Routes.homeRoute);
          }),
          itemDrawer(context, AppStrings.favorites, IconAssets.favorites, () {
            Navigator.pushNamed(context, Routes.favoriteRoute);
          }),
          itemDrawer(
            context,
            AppStrings.myDownloads,
            IconAssets.downloads,
            () {},
          ),
          divider(),
          itemDrawer(context, AppStrings.about, IconAssets.about, () {
            final text = app?.about ?? "";
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AboutView(aboutText: text),
              ),
            );
          }),
          itemDrawer(context, AppStrings.privacyPolicy, IconAssets.privacy, () {
            final text = app?.privacyPolicy ?? "";
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PrivacyPolicyView(privacyPolicyText: text),
              ),
            );
          }),
          itemDrawer(context, AppStrings.termsOfUse, IconAssets.terms, () {
            final text = app?.termsOfUse ?? "";
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TermsOfUseView(termsOfUseText: text),
              ),
            );
          }),
          divider(),
          itemDrawer(context, AppStrings.rateApp, IconAssets.rate, () {}),
          itemDrawer(context, AppStrings.shareApp, IconAssets.share, () {}),
          itemDrawer(
            context,
            AppStrings.sendFeedback,
            IconAssets.feedback,
            () {},
          ),
        ],
      ),
    );
  }

  Widget _titleDrawer(BuildContext context, String? appName) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.p12,
        vertical: AppPadding.p8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            ImageAssets.appLogoSvg,
            width: AppSize.s80.w,
            height: AppSize.s80.h,
          ),
          Text(
            appName ?? AppStrings.titledrawer,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }

  Widget itemDrawer(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.p12,
        vertical: AppPadding.p14,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: ColorManager.white),
            SizedBox(width: AppSize.s10.w),
            Text(title, style: Theme.of(context).textTheme.displaySmall),
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.p12,
        vertical: AppPadding.p8,
      ),
      child: Divider(color: ColorManager.white),
    );
  }
}
