import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glowy/app/di.dart';
import 'package:glowy/presentation/home/list_app_cubit/list_app_cubit.dart';
import 'package:glowy/presentation/home/get_drawer_data_cubit/get_drawer_data_cubit.dart';
import 'package:glowy/presentation/home/download_cubit/download_cubit.dart';
import 'package:glowy/presentation/home/download_cubit/download_state.dart';
import 'package:glowy/presentation/resources/routes_manager.dart';
import 'package:glowy/presentation/resources/them_manager.dart';

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  //private named constructor
  MyApp._internal();
  int appState = 0;
  //static instance of the class
  static final MyApp _instance = MyApp._internal(); //singleton pattern
  //factory constructor
  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<ListAppCubit>(
              create: (context) => getIt<ListAppCubit>(),
            ),
            BlocProvider<GetDrawerDataCubit>(
              create: (context) => getIt<GetDrawerDataCubit>(),
            ),
            BlocProvider<DownloadCubit>(
              create: (context) => getIt<DownloadCubit>(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: getApplicationTheme(),
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: Routes.splashRoute,
            builder: (context, child) {
              return BlocListener<DownloadCubit, DownloadState>(
                listener: (context, state) {
                  if (state.status == DownloadStatus.success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('✅ Saved to Gallery successfully!'),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    context.read<DownloadCubit>().reset();
                  } else if (state.status == DownloadStatus.failure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('❌ ${state.errorMessage ?? 'Download failed'}'),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    context.read<DownloadCubit>().reset();
                  }
                },
                child: child,
              );
            },
          ),
        );
      },
    );
  }
}
