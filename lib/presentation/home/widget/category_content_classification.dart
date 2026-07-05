import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:glowy/app/di.dart';
import 'package:glowy/domain/model/get_image_category_model.dart';
import 'package:glowy/presentation/common/state_randrer/state_randrer_impl.dart';
import 'package:glowy/presentation/home/category_content_classification_cubit/category_content_classification_state.dart';
import 'package:glowy/presentation/home/widget/category_content_deatils.dart';
import 'package:glowy/presentation/resources/color_manager.dart';
import 'package:glowy/presentation/resources/media_type_enum.dart';
import 'package:glowy/presentation/home/category_content_classification_cubit/category_content_%20classification_cubit.dart';

class CategoryContentClassification extends StatefulWidget {
  final String appId;
  final String categoryIdClassification;
  final String classificationId;

  const CategoryContentClassification({
    super.key,
    required this.appId,
    required this.categoryIdClassification,
    required this.classificationId,
  });

  @override
  State<CategoryContentClassification> createState() =>
      _CategoryContentClassificationState();
}

class _CategoryContentClassificationState
    extends State<CategoryContentClassification> {
  final ScrollController _scrollController = ScrollController();
  late final GetCategoryContentClassificationCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = getIt<GetCategoryContentClassificationCubit>()
      ..getCategoryContentClassification(
        appId: widget.appId,
        categoryIdClassification: widget.categoryIdClassification,
        classificationId: widget.classificationId,
      );
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      cubit.loadMoreCategoryContentClassification(
        appId: widget.appId,
        categoryIdClassification: widget.categoryIdClassification,
        classificationId: widget.classificationId,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    cubit.close(); // مهم لأننا بننشئ الـ cubit يدويًا فمحتاجين نقفلها يدويًا
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit, // ✅ نفس النسخة بالظبط، مفيش duplicate
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const BackButton(),
        ),
        body:
            BlocBuilder<
              GetCategoryContentClassificationCubit,
              CategoryContentClassificationState
            >(
              builder: (context, state) {
                final categoryContent = state.data;
                final mainWidget =
                    state.flowState?.getScreenWidget(
                      context,
                      _getContentWidget(context, categoryContent, state),
                      () {
                        cubit.getCategoryContentClassification(
                          appId: widget.appId,
                          categoryIdClassification:
                              widget.categoryIdClassification,
                          classificationId: widget.classificationId,
                        );
                      },
                    ) ??
                    _getContentWidget(context, categoryContent, state);

                return mainWidget;
              },
            ),
      ),
    );
  }

  Widget _getContentWidget(
    BuildContext context,
    ImageCategoryObject? categoryContent,
    CategoryContentClassificationState state,
  ) {
    final allImages = categoryContent?.data.items ?? [];

    return MasonryGridView.count(
      controller: _scrollController,
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: allImages.length + (state.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= allImages.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final image = allImages[index];
        final isTopRated = image.isTopRated ?? false;
        final aspectRatio = index.isEven ? 0.72 : 0.92;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryContentDetails(
                  imageUrl: image.url,
                  mediaType: MediaType.image,
                ),
              ),
            );
          },
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: aspectRatio,
                  child: CachedNetworkImage(
                    imageUrl: image.thumbUrl ?? image.url,
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
                ),
              ),
              if (isTopRated)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Top Rated',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
