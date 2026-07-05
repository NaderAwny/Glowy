import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:glowy/app/di.dart';
import 'package:glowy/domain/model/classification_category_model.dart';
import 'package:glowy/presentation/common/state_randrer/state_randrer_impl.dart';
import 'package:glowy/presentation/home/classification_category_cubit/classification_category_cubit.dart';
import 'package:glowy/presentation/home/classification_category_cubit/classification_category_state.dart';
import 'package:glowy/presentation/home/widget/category_content_classification.dart';
import 'package:glowy/presentation/resources/color_manager.dart';

class ClassificationContent extends StatelessWidget {
  final String appId;
  final String categoryId;

  const ClassificationContent({
    super.key,
    required this.appId,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // كلما تغيرت الـ categoryId يتحتاج Cubit جديد يجيب بيانات جديدة
      create: (context) =>
          getIt<ClassificationCategoryCubit>()
            ..getClassificationCategory(appId: appId, categoryId: categoryId),

      child:
          BlocBuilder<ClassificationCategoryCubit, ClassificationCategoryState>(
            builder: (context, state) {
              final categoryContent = state.data;
              final mainWidget =
                  state.flowState?.getScreenWidget(
                    context,
                    _getContentWidget(categoryContent),
                    () {
                      context
                          .read<ClassificationCategoryCubit>()
                          .getClassificationCategory(
                            appId: appId,
                            categoryId: categoryId,
                          );
                    },
                  ) ??
                  _getContentWidget(categoryContent);

              return mainWidget;
            },
          ),
    );
  }

  Widget _getContentWidget(ClassificationCategoryMainModel? categoryContent) {
    final classificationCategory = categoryContent?.data?.classification ?? [];

    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: classificationCategory.length,
      itemBuilder: (context, index) {
        final image = classificationCategory[index];
        final aspectRatio = index.isEven ? 0.72 : 0.92;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryContentClassification(
                  appId: appId,
                  classificationId: image.id ?? "",
                  categoryIdClassification: categoryId,
                ),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: aspectRatio,
              child: CachedNetworkImage(
                imageUrl: image.thumbnailUrl ?? "",
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: ColorManager.surface),
                errorWidget: (context, url, error) => Container(
                  color: ColorManager.surface,
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: ColorManager.grey,
                    size: 32,
                  ),
                ),
              ),

              // ── فيديو ──
            ),
          ),
        );
      },
    );
  }
}
