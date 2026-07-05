// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:glowy/app/constants.dart';
import 'package:injectable/injectable.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";

@lazySingleton
class DioFactory {
  // singleton instance
  static final DioFactory _instance = DioFactory._internal();

  // dio instance
  late final Dio dio;

  // private constructor
  DioFactory._internal() {
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
    };

    dio = Dio(
      BaseOptions(
        baseUrl: Constants.baseUrl,
        headers: headers,
        receiveTimeout: Duration(milliseconds: Constants.apiTimeOut),
        sendTimeout: Duration(milliseconds: Constants.apiTimeOut),
      ),
    );

    if (!kReleaseMode) // its debug mode so print app logs
    {
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            debugPrint('┌── REQUEST ──────────────────────────');
            debugPrint('│ URL: ${options.baseUrl}${options.path}');
            debugPrint('│ Method: ${options.method}');
            debugPrint('└─────────────────────────────────────');
            handler.next(options);
          },
          onResponse: (response, handler) {
            debugPrint('┌── RESPONSE ─────────────────────────');
            debugPrint('│ Status: ${response.statusCode}');
            debugPrint('│ Data: ${response.data}');
            debugPrint('└─────────────────────────────────────');
            handler.next(response);
          },
          onError: (error, handler) {
            debugPrint('┌── ERROR ────────────────────────────');
            debugPrint('│ Type: ${error.type}');
            debugPrint('│ Message: ${error.message}');
            debugPrint('│ Status: ${error.response?.statusCode}');
            debugPrint('│ Data: ${error.response?.data}');
            debugPrint('└─────────────────────────────────────');
            handler.next(error);
          },
        ),
      );
    }
  }
  // factory constructor
  factory DioFactory() {
    return _instance;
  }
}
