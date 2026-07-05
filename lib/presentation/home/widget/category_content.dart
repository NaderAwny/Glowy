import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:glowy/app/di.dart';
import 'package:glowy/domain/model/get_image_category_model.dart';
import 'package:glowy/presentation/common/state_randrer/state_randrer_impl.dart';
import 'package:glowy/presentation/home/get_category_content_cubit/get_category_content_cubit.dart';
import 'package:glowy/presentation/home/get_category_content_cubit/get_category_content_state.dart';
import 'package:glowy/presentation/home/widget/category_content_deatils.dart';
import 'package:glowy/presentation/home/widget/video_item_widget.dart';
import 'package:glowy/presentation/resources/color_manager.dart';
import 'package:glowy/presentation/resources/media_type_enum.dart';
import 'package:glowy/presentation/resources/strings_manager.dart';
import 'package:glowy/presentation/resources/values_manager.dart';

class CategoryContent extends StatefulWidget {
  final String appId;
  final String categoryId;
  final MediaType selectedMediaType;

  const CategoryContent({
    super.key,
    required this.appId,
    required this.categoryId,
    this.selectedMediaType = MediaType.image,
  });

  @override
  State<CategoryContent> createState() => _CategoryContentState();
}

class _CategoryContentState extends State<CategoryContent> {
  late GetCategoryContentCubit cubit; // late (مش final) عشان نقدر نعيد إنشاءه
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    cubit = getIt<GetCategoryContentCubit>()
      ..getCategoryContent(appId: widget.appId, categoryId: widget.categoryId);
    _scrollController.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(CategoryContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    // لو اتغيرت الـ categoryId أو الـ selectedMediaType (مثلًا غيّر tab)
    // نوقف الـ cubit القديم ونعمل واحد جديد بيانات نظيفة
    if (oldWidget.categoryId != widget.categoryId ||
        oldWidget.selectedMediaType != widget.selectedMediaType) {
      cubit.close();
      cubit = getIt<GetCategoryContentCubit>()
        ..getCategoryContent(
          appId: widget.appId,
          categoryId: widget.categoryId,
        );
      // إعادة الـ scroll للأعلى
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      cubit.loadMoreCategoryContent(
        appId: widget.appId,
        categoryId: widget.categoryId,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      key: ValueKey('${widget.categoryId}_${widget.selectedMediaType}'),
      value: cubit,
      // كلما تغيرت الـ categoryId يتحتاج Cubit جديد يجيب بيانات جديدة
      child: BlocBuilder<GetCategoryContentCubit, GetCategoryContentState>(
        builder: (context, state) {
          final categoryContent = state.data;
          final mainWidget =
              state.flowState?.getScreenWidget(
                context,
                _getContentWidget(categoryContent, state),
                () {
                  context.read<GetCategoryContentCubit>().getCategoryContent(
                    appId: widget.appId,
                    categoryId: widget.categoryId,
                  );
                },
              ) ??
              _getContentWidget(categoryContent, state);

          return mainWidget;
        },
      ),
    );
  }

  Widget _getContentWidget(
    ImageCategoryObject? categoryContent,
    GetCategoryContentState state,
  ) {
    final allImages = categoryContent?.data.items ?? [];

    // فلتر العناصر بناءً على الـ selectedMediaType

    final categoryImages = allImages.where((item) {
      final itemType = MediaType.fromString(item.mediaType);
      return switch (widget.selectedMediaType) {
        MediaType.image => itemType == MediaType.image,
        MediaType.video => itemType == MediaType.video,
        // الـ API بيرجّع mediaType="IMAGE" لعناصر الـ classification
        // فبنعرض كل العناصر بدون فلترة
        MediaType.classification => true,
        MediaType.category => true,
      };
    }).toList();

    return MasonryGridView.count(
      controller: _scrollController,
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: categoryImages.length + (state.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= categoryImages.length) {
          return Center(
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }
        final image = categoryImages[index];
        final isTopRated = image.isTopRated ?? false;
        final aspectRatio = index.isEven ? 0.72 : 0.92;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryContentDetails(
                  imageUrl: categoryImages[index].url,
                  mediaType: widget.selectedMediaType,
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
                  child: switch (widget.selectedMediaType) {
                    // ── صورة ──
                    MediaType.image ||
                    MediaType.classification ||
                    MediaType.category => CachedNetworkImage(
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
                    // ── فيديو ──
                    MediaType.video => VideoItemWidget(
                      videoUrl: image.url,
                      thumbUrl: image.thumbUrl,
                    ),
                  },
                ),
              ),
              if (isTopRated)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    height: AppSize.s28.h,
                    width: AppSize.s80.w,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.circular(AppPadding.p2),
                    ),
                    child: Text(
                      AppStrings.topRated,
                      style: TextStyle(
                        color: ColorManager.black,
                        fontSize: AppSize.s8.sp,
                      ),
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
