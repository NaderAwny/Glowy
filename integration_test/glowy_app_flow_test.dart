import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glowy/app/app.dart';
import 'package:glowy/app/di.dart';
import 'package:glowy/data/data_source/get_drawer_remote_data_source.dart';
import 'package:glowy/data/data_source/list_app_remote_data_source.dart';
import 'package:glowy/data/responses/get_drawer_data_responses/get_drawer_data_response.dart';
import 'package:glowy/data/responses/list_app_responses/list_app.dart';
import 'package:glowy/presentation/resources/icons_manager.dart';
import 'package:integration_test/integration_test.dart';

class FakeRemoteDataSource extends RemoteDataSource {
  @override
  Future<HomeResponse> listappdata() async {
    return HomeResponse(
      success: true,
      message: "message",
      data: HomeDataResponse([], [
        ListApp("id", "Nature Wallpapers", "platform", [
          Category("id", "Home", "LIVE", 1, 1),
          Category("id", "Live", "RING_TONE", 2, 2),
          Category("id", "Exclusive", "CATEGORY", 3, 3),
          Category("id", "Categories", "CLASSIFICATION", 4, 4),
        ]),
      ]),
    );
  }
}

class FakeDrawerRemoteDataSource implements GetDrawerRemoteDataSource {
  @override
  Future<GetDrawerDataResponse> getDrawer(String appId) async {
    return GetDrawerDataResponse(
      success: true,
      message: "message",
      data: GetDrawerDataResponseData(
        app: DrawerApp(id: appId, name: "Nature Wallpapers", categories: []),
      ),
    );
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await getIt.reset();
    await configureDependencies();
    getIt.unregister<RemoteDataSource>();
    getIt.registerLazySingleton<RemoteDataSource>(() => FakeRemoteDataSource());
    getIt.unregister<GetDrawerRemoteDataSource>();
    getIt.registerLazySingleton<GetDrawerRemoteDataSource>(
      () => FakeDrawerRemoteDataSource(),
    );
  });

  testWidgets('user opens the app and sees the apps list', (tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle(const Duration(seconds: 5));
    // After splash navigates to HomePage, the AppBar shows "Glowy"
    // and the drawer (when opened) shows "Nature Wallpapers".
    // We open the drawer to assert the app name from our fake data.

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(IconAssets.about));
    await tester.pumpAndSettle();

    // ارجع
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(IconAssets.favorites));
    await tester.pumpAndSettle();

    // ارجع
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(IconAssets.privacy));
    await tester.pumpAndSettle();

    // ارجع
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(IconAssets.terms));
    await tester.pumpAndSettle();

    // ارجع
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(IconAssets.home)); // الـ زرار Drawer
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    debugPrint('Step 5');

    await tester.tap(find.text('Home'));
    await tester.tap(find.byKey(const Key('category_name_Home')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('category_name_Home')), findsOneWidget);
    await Future.delayed(const Duration(seconds: 2));
    debugPrint('Step 6');

    await tester.tap(find.text('Live'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('category_name_Live')), findsOneWidget);
    await Future.delayed(const Duration(seconds: 2));
    debugPrint('Step 7');

    await tester.tap(find.text('Exclusive'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('category_name_Exclusive')), findsOneWidget);
    await Future.delayed(const Duration(seconds: 2));
    debugPrint('Step 8');

    await tester.tap(find.text('Categories'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('category_name_Categories')), findsOneWidget);
    await Future.delayed(const Duration(seconds: 2));
    debugPrint('Step 9');

    expect(find.text('Nature Wallpapers'), findsOneWidget);
    await Future.delayed(const Duration(seconds: 2));
    debugPrint('Step 10');
  });
}
