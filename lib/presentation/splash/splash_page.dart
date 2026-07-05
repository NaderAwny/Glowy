// استدعاء مكتبة Flutter الأساسية الخاصة بالـ UI
import 'package:flutter/material.dart';

// استدعاء flutter_bloc عشان نستخدم Cubit و BlocListener
import 'package:flutter_bloc/flutter_bloc.dart';

// مكتبة ScreenUtil عشان نعمل Responsive لكل المقاسات
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Cubit المسؤول عن جلب قائمة التطبيقات
import 'package:glowy/presentation/home/list_app_cubit/list_app_cubit.dart';

// الـ States الخاصة بـ ListAppCubit
import 'package:glowy/presentation/home/list_app_cubit/list_app_state.dart';

// Cubit المسؤول عن جلب بيانات الـ Drawer
import 'package:glowy/presentation/home/get_drawer_data_cubit/get_drawer_data_cubit.dart';

// الـ States الخاصة بـ Drawer Cubit
import 'package:glowy/presentation/home/get_drawer_data_cubit/get_drawer_data_state.dart';

// ملف الـ States الجاهزة زي Loading و Error و Content
import 'package:glowy/presentation/common/state_randrer/state_randrer_impl.dart';

// ملف الصور والأصول
import 'package:glowy/presentation/resources/assets_manager.dart';

// ملف الألوان المستخدمة في المشروع
import 'package:glowy/presentation/resources/color_manager.dart';

// ملف أحجام الخطوط
import 'package:glowy/presentation/resources/font_manager.dart';

// ملف الـ Routes للتنقل بين الصفحات
import 'package:glowy/presentation/resources/routes_manager.dart';

// ملف الـ Styles الجاهزة للنصوص
import 'package:glowy/presentation/resources/styles_manager.dart';

// ملف الأحجام والـ paddings والثوابت
import 'package:glowy/presentation/resources/values_manager.dart';

// StatefulWidget لأن الشاشة حالتها بتتغير
// زي loading أو error أو success
class SplashScreen extends StatefulWidget {
  // constructor
  const SplashScreen({super.key});

  @override
  // بيربط الـ Widget بالـ State الخاص بيها
  State<SplashScreen> createState() => _SplashScreenState();
}

// الـ State الحقيقي للشاشة
class _SplashScreenState extends State<SplashScreen> {
  // متغير بيحدد هل البيانات الخاصة بالتطبيقات اتحملت ولا لا
  bool _isListAppLoaded = false;

  // متغير بيحدد هل بيانات الـ Drawer اتحملت ولا لا
  bool _isDrawerLoaded = false;

  // متغير لتخزين رسالة الخطأ لو حصل Error
  String? _errorMessage;

  @override
  void initState() {
    // أول حاجة لازم ننادي على الـ init الأساسي
    super.initState();

    // أول ما الشاشة تفتح يبدأ يحمل البيانات
    _startLoading();
  }

  // دالة مسؤولة عن بداية تحميل البيانات
  void _startLoading() {
    // setState عشان نعمل تحديث للواجهة
    setState(() {
      // بنفضي رسالة الخطأ القديمة
      _errorMessage = null;

      // بنرجع حالات التحميل false
      _isListAppLoaded = false;
      _isDrawerLoaded = false;
    });

    // بنطلب من الـ Cubit يجيب البيانات
    context.read<ListAppCubit>().getListApp();
  }

  // دالة بتسمع تغيرات حالة ListAppCubit
  void _onListAppStateChanged(BuildContext context, ListAppState state) {
    if (state.flowState is ErrorState) {
      // روح للـ Home
      _goNext();
    }
    // لو الحالة ContentState يعني البيانات وصلت
    else if (state.flowState is ContentState && state.data != null) {
      // نتأكد إننا مش حملنا قبل كده
      if (!_isListAppLoaded) {
        // نعتبر إن البيانات اتحملت
        _isListAppLoaded = true;

        // نجيب قائمة التطبيقات
        final apps = state.data?.apps ?? [];

        // لو القائمة مش فاضية
        if (apps.isNotEmpty) {
          // ناخد أول App
          final appId = apps.first.id;

          // نطلب بيانات الـ Drawer الخاصة بالتطبيق ده
          context.read<GetDrawerDataCubit>().getDrawerData(appId);
        } else {
          // لو مفيش Applications
          setState(() {
            // نعرض رسالة خطأ
            _errorMessage = "No applications found";
          });
        }
      }
    }
  }

  // دالة بتسمع تغيرات Drawer Cubit
  void _onDrawerStateChanged(BuildContext context, GetDrawerDataState state) {
    // لو حصل Error
    if (state.flowState is ErrorState) {
      // نخزن رسالة الخطأ
      setState(() {
        _errorMessage = (state.flowState as ErrorState).message;
      });
    }
    // لو البيانات وصلت
    else if (state.flowState is ContentState && state.data != null) {
      // نتأكد إننا مش نفذنا قبل كده
      if (!_isDrawerLoaded) {
        // نعتبر إن الـ Drawer اتحمل
        _isDrawerLoaded = true;

        // نروح للشاشة الرئيسية
        _goNext();
      }
    }
  }

  // دالة التنقل للصفحة الرئيسية
  void _goNext() {
    // pushReplacementNamed
    // يعني يفتح الصفحة الجديدة
    // ويحذف الـ Splash من الـ Stack
    Navigator.pushReplacementNamed(context, Routes.homeRoute);
  }

  @override
  Widget build(BuildContext context) {
    // MultiBlocListener
    // بنستخدمه لما يكون عندنا أكتر من Listener
    return MultiBlocListener(
      // ليستة الـ listeners
      listeners: [
        // Listener خاص بـ ListAppCubit
        BlocListener<ListAppCubit, ListAppState>(
          // أول ما الـ state يتغير
          listener: _onListAppStateChanged,
        ),

        // Listener خاص بالـ Drawer Cubit
        BlocListener<GetDrawerDataCubit, GetDrawerDataState>(
          // أول ما الحالة تتغير
          listener: _onDrawerStateChanged,
        ),
      ],

      // الـ UI الأساسي
      child: Scaffold(
        // لون خلفية الشاشة
        backgroundColor: ColorManager.background,

        // الـ AppBar
        appBar: AppBar(
          // خلفية شفافة
          backgroundColor: Colors.transparent,

          // يشيل الـ shadow
          elevation: 0,

          // ارتفاع الـ AppBar
          toolbarHeight: 100.h,
        ),

        // جسم الشاشة
        body: Center(
          // عمود رأسي
          child: Column(
            children: [
              // Logo التطبيق
              SizedBox(
                // العرض
                width: AppSize.s100.w,

                // الارتفاع
                height: AppSize.s100.h,

                // الصورة
                child: Image.asset(ImageAssets.appLogoPng),
              ),

              // مسافة
              SizedBox(height: AppSize.s40.h),

              // لو فيه Error
              if (_errorMessage != null) ...[
                // Padding للنص
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p20.w),

                  // رسالة الخطأ
                  child: Text(
                    // نص الخطأ
                    _errorMessage!,

                    // Style النص
                    style: getRegularStyle(
                      // لون الخطأ
                      color: ColorManager.error,

                      // حجم الخط
                      fontSize: FontSize.s16.sp,
                    ),

                    // توسيط النص
                    textAlign: TextAlign.center,
                  ),
                ),

                // مسافة
                SizedBox(height: AppSize.s20.h),

                // زر Retry
                ElevatedButton(
                  // لما المستخدم يضغط
                  onPressed: _startLoading,

                  // شكل الزر
                  style: ElevatedButton.styleFrom(
                    // لون الخلفية
                    backgroundColor: ColorManager.primary,

                    // لون النص
                    foregroundColor: ColorManager.background,
                  ),

                  // النص داخل الزر
                  child: const Text("Retry"),
                ),
              ] else ...[
                // هنا مكان الـ Loading
                // أنت قافله حاليا
                // CircularProgressIndicator(
                //   color: ColorManager.primary,
                // ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
