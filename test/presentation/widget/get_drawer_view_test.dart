import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glowy/domain/model/get_drawer_model.dart';
import 'package:glowy/presentation/common/state_randrer/state_randrer.dart';
import 'package:glowy/presentation/common/state_randrer/state_randrer_impl.dart';
import 'package:glowy/presentation/home/get_drawer_data_cubit/get_drawer_data_cubit.dart';
import 'package:glowy/presentation/home/get_drawer_data_cubit/get_drawer_data_state.dart';
import 'package:mocktail/mocktail.dart';

class MockGetDrawerDataCubit extends MockCubit<GetDrawerDataState>
    implements GetDrawerDataCubit {}

class GetDrawerViewTest extends StatelessWidget {
  const GetDrawerViewTest({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetDrawerDataCubit, GetDrawerDataState>(
        builder: (context, state) {
          final flowState = state.flowState;
          if (flowState is LoadingState) {
            return const Center(
              key: Key('loading-indicator'),
              child: CircularProgressIndicator(),
            );
          }
          if (flowState is ErrorState) {
            return Center(
              key: const Key('error-message'),
              child: Text(flowState.message),
            );
          }
          final drawer = state.data?.data.categories ?? [];
          return ListView.builder(
            itemCount: drawer.length,
            itemBuilder: (_, i) {
              final item = drawer[i];
              return ListTile(title: Text(item.name));
            },
          );
        },
      ),
    );
  }
}

void main() {
  late MockGetDrawerDataCubit cubit;
  setUp(() {
    cubit = MockGetDrawerDataCubit();
  });
  Widget wrap(Widget child) => MaterialApp(
    home: BlocProvider<GetDrawerDataCubit>.value(value: cubit, child: child),
  );
  testWidgets("loading state widget_> Shows CircularProgressIndicator", (
    tester,
  ) async {
    when(() => cubit.state).thenReturn(
      GetDrawerDataState(
        flowState: LoadingState(
          stateRendererType: StateRendererType.fullScreenLoadingState,
        ),
      ),
    );
    await tester.pumpWidget(wrap(const GetDrawerViewTest()));
    expect(find.byKey(const Key('loading-indicator')), findsOneWidget);
  });
  testWidgets("has data_> Shows shows app list", (tester) async {
    when(() => cubit.state).thenReturn(
      GetDrawerDataState(
        flowState: ContentState(),
        data: DrawerAppObject(
          DrawerAppDataModel(
            [
              CategoryDrawerModel("1", "Nature Wallpapers", "ios", 1, 1),
              CategoryDrawerModel("2", "Space Wallpapers", "android", 2, 2),
            ],
            DrawerAppModel(
              "1",
              "name",
              "description",
              "platform",
              "about",
              "privacyPolicy",
              "termsOfUse",
              "androidShareLink",
              "iphoneShareLink",
              "contactEmail",
              [],
            ),
          ),
        ),
      ),
    );
    await tester.pumpWidget(wrap(const GetDrawerViewTest()));
    expect(find.text("Nature Wallpapers"), findsOneWidget);
    expect(find.text("Space Wallpapers"), findsOneWidget);
  });
  testWidgets("Error state widget_> Shows error message", (tester) async {
    when(() => cubit.state).thenReturn(
      GetDrawerDataState(
        flowState: ErrorState(
          StateRendererType.fullScreenErrorState,
          "Something went wrong",
        ),
      ),
    );
    await tester.pumpWidget(wrap(const GetDrawerViewTest()));
    expect(find.byKey(const Key('error-message')), findsOneWidget);
    expect(find.text("Something went wrong"), findsOneWidget);
  });
}
