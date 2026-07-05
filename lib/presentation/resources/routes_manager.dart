import 'package:flutter/material.dart';
import 'package:glowy/presentation/favorites/favorites_page.dart';
import 'package:glowy/presentation/home/home_page.dart';
import 'package:glowy/presentation/resources/strings_manager.dart';
import 'package:glowy/presentation/splash/splash_page.dart';
import 'package:glowy/presentation/wallpaper_detail/wallpaper_detail.dart';

class Routes {
  static const String splashRoute = "/";
  static const String homeRoute = "/home";
  static const String wallpaperDetailsRoute = "/wallpaper_details";
  static const String favoriteRoute = "/favorite";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.wallpaperDetailsRoute:
        return MaterialPageRoute(builder: (_) => const WallpaperDetailScreen());
      case Routes.favoriteRoute:
        return MaterialPageRoute(builder: (_) => const FavoritesScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text(AppStrings.noRouteFound)),
        body: const Center(child: Text(AppStrings.noRouteFound)),
      ),
    );
  }
}
