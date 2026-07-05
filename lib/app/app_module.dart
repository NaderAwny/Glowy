import 'package:dio/dio.dart';
import 'package:glowy/data/network/app_api.dart';
import 'package:glowy/data/network/dio_client.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  @lazySingleton
  InternetConnectionChecker get internetConnectionChecker =>
      InternetConnectionChecker.createInstance(
        addresses: [
          AddressCheckOption(
            uri: Uri.parse('https://google.com'),
            timeout: const Duration(seconds: 5),
          ),
          AddressCheckOption(
            uri: Uri.parse('https://cloudflare.com'),
            timeout: const Duration(seconds: 5),
          ),
          AddressCheckOption(
            uri: Uri.parse('https://example.com'),
            timeout: const Duration(seconds: 5),
          ),
        ],
      );

  @lazySingleton
  Dio dio(DioFactory dioFactory) => dioFactory.dio;

  @lazySingleton
  AppServiceClient appServiceClient(Dio dio) => AppServiceClient(dio);
}
