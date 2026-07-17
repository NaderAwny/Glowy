import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glowy/domain/model/list_app_model.dart';
import 'package:glowy/presentation/common/state_randrer/state_randrer.dart';
import 'package:glowy/presentation/common/state_randrer/state_randrer_impl.dart';
import 'package:glowy/presentation/home/list_app_cubit/list_app_cubit.dart';
import 'package:glowy/presentation/home/list_app_cubit/list_app_state.dart';
import 'package:mocktail/mocktail.dart';

class MockListAppCubit extends MockCubit<ListAppState>
    implements ListAppCubit {}

class ListAppViewTest extends StatelessWidget {
  const ListAppViewTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ListAppCubit, ListAppState>(
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
              key: Key('error-message'),
              child: Text(flowState.message),
            );
          }
          final app = state.data?.apps ?? [];
          return ListView.builder(
            itemCount: app.length,
            itemBuilder: (_, i) => ListTile(title: Text(app[i].name)),
          );
        },
      ),
    );
  }
}

void main() {
  late MockListAppCubit cubit;
  setUp(() {
    cubit = MockListAppCubit();
  });
  Widget wrap(Widget child) => MaterialApp(
    home: BlocProvider<ListAppCubit>.value(value: cubit, child: child),
  );
  testWidgets("loading state widget_> Shows CircularProgressIndicator", (
    tester,
  ) async {
    when(() => cubit.state).thenReturn(
      ListAppState(
        flowState: LoadingState(
          stateRendererType: StateRendererType.fullScreenLoadingState,
        ),
      ),
    );
    await tester.pumpWidget(wrap(const ListAppViewTest()));
    expect(find.byKey(const Key('loading-indicator')), findsOneWidget);
  });
  testWidgets("has data_> Shows shows app list", (tester) async {
    when(() => cubit.state).thenReturn(
      ListAppState(
        flowState: ContentState(),
        data: HomeListAppModel([], [
          ListAppModel("1", "Nature Wallpapers", "android", []),
          ListAppModel("2", "Space Wallpapers", "ios", []),
        ]),
      ),
    );
    await tester.pumpWidget(wrap(const ListAppViewTest()));
    expect(find.text("Nature Wallpapers"), findsOneWidget);
    expect(find.text("Space Wallpapers"), findsOneWidget);
  });
  testWidgets("Error state widget_> Shows error message", (tester) async {
    when(() => cubit.state).thenReturn(
      ListAppState(
        flowState: ErrorState(
          StateRendererType.fullScreenErrorState,
          "Something went wrong",
        ),
      ),
    );
    await tester.pumpWidget(wrap(const ListAppViewTest()));
    expect(find.byKey(const Key('error-message')), findsOneWidget);
    expect(find.text("Something went wrong"), findsOneWidget);
  });
}
