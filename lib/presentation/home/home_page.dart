import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glowy/domain/model/list_app_model.dart';
import 'package:glowy/presentation/common/state_randrer/state_randrer_impl.dart';
import 'package:glowy/presentation/home/get_drawer_data_cubit/get_drawer_data_cubit.dart';
import 'package:glowy/presentation/home/get_drawer_data_cubit/get_drawer_data_state.dart';
import 'package:glowy/presentation/home/list_app_cubit/list_app_cubit.dart';
import 'package:glowy/presentation/home/list_app_cubit/list_app_state.dart';
import 'package:glowy/presentation/home/widget/category_content.dart';
import 'package:glowy/presentation/home/widget/classification_content.dart';
import 'package:glowy/presentation/home/widget/drawer_widget.dart';
import 'package:glowy/presentation/resources/color_manager.dart';
import 'package:glowy/presentation/resources/font_manager.dart';
import 'package:glowy/presentation/resources/media_type_enum.dart';
import 'package:glowy/presentation/resources/strings_manager.dart';
import 'package:glowy/presentation/resources/styles_manager.dart';
import 'package:glowy/presentation/resources/values_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  MediaType selectedMediaType = MediaType.image;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetDrawerDataCubit, GetDrawerDataState>(
      builder: (context, drawerState) {
        // جيب أول categoryId من الـ Drawer
        final drawerCategories = drawerState.data?.data.categories ?? [];
        // الـ categoryId بيتغير بناءً على الـ tab المختار
        final categoryId =
            drawerCategories.isNotEmpty &&
                _selectedIndex < drawerCategories.length
            ? drawerCategories[_selectedIndex].id
            : drawerCategories.isNotEmpty
            ? drawerCategories.first.id
            : '';
        return BlocBuilder<ListAppCubit, ListAppState>(
          builder: (context, state) {
            final categories = state.data?.categories ?? [];
            final apps = state.data?.apps ?? [];
            final appId = apps.isNotEmpty ? apps.first.id : '';

            final mainWidget =
                state.flowState?.getScreenWidget(
                  context,
                  _getContentWidget(categories, appId, categoryId),
                  () {
                    context.read<ListAppCubit>().getListApp();
                  },
                ) ??
                _getContentWidget(categories, appId, categoryId);

            return mainWidget;
          },
        );
      },
    );
  }

  Widget _getContentWidget(
    List<CategoryModel> categories,
    String appId,
    String categoryId,
  ) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      appBar: AppBar(
        title: Text(
          AppStrings.appName,
          style: TextStyle(
            shadows: [
              Shadow(
                // ignore: deprecated_member_use
                color: ColorManager.primary.withOpacity(AppSize.s0_8),
                blurRadius: 10,
              ),
              Shadow(
                // ignore: deprecated_member_use
                color: ColorManager.primary.withOpacity(AppSize.s0_5),
                blurRadius: 20,
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      drawer: DrawerWidget(appId: appId),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (categories.isEmpty)
              const Expanded(
                child: Center(child: Text(AppStrings.noCategoriesFound)),
              )
            else
              SizedBox(
                height: AppSize.s40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p16,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = _selectedIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                          // ✅ بنعتمد على نوع الـ category من الـ API مش على الـ index
                          if (index == 0) {
                            selectedMediaType = MediaType.image;
                          } else if (index == 1) {
                            selectedMediaType = MediaType.video;
                          } else if (index == 2) {
                            selectedMediaType = MediaType.classification;
                          } else if (index == 3) {
                            selectedMediaType =
                                MediaType.category; // → ClassificationContent
                          } else {
                            selectedMediaType = MediaType.fromString(
                              category.type,
                            );
                          }
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: AppPadding.p10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p22,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? ColorManager.primary
                              // ignore: deprecated_member_use
                              : ColorManager.surface.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(AppSize.s12),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          key: Key('category_name_${category.name}'),
                          category.name,
                          style: isSelected
                              ? getRegularStyle(
                                  color: ColorManager.background,
                                  fontSize: FontSize.s12,
                                )
                              : getRegularStyle(
                                  color: ColorManager.white,
                                  fontSize: FontSize.s12,
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            SizedBox(height: AppSize.s16),

            if (selectedMediaType == MediaType.category)
              Expanded(
                child: ClassificationContent(
                  appId: appId,
                  categoryId: categoryId,
                ),
              )
            else if (categoryId.isNotEmpty)
              Expanded(
                child: CategoryContent(
                  appId: appId,
                  categoryId: categoryId,
                  selectedMediaType: selectedMediaType,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
