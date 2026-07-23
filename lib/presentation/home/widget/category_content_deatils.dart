import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glowy/presentation/home/download_cubit/download_cubit.dart';
import 'package:glowy/presentation/home/download_cubit/download_state.dart';
import 'package:glowy/presentation/home/widget/video_item_widget.dart';
import 'package:glowy/presentation/resources/media_type_enum.dart';

class CategoryContentDetails extends StatefulWidget {
  final String imageUrl;
  final MediaType mediaType;

  const CategoryContentDetails({
    super.key,
    required this.imageUrl,
    required this.mediaType,
  });

  // استخرج اسم الملف من الـ URL مع ضمان وجود extension صح
  String getFileName() {
    final uri = Uri.parse(imageUrl);
    final segments = uri.pathSegments;
    final name = segments.isNotEmpty ? segments.last : '';

    if (mediaType == MediaType.video) {
      // لو مفيش video extension → ضيف .mp4
      return (name.endsWith('.mp4') || name.endsWith('.mov'))
          ? name
          : '${name.isEmpty ? 'glowy_video' : name}.mp4';
    }

    // للصور — لو مفيش image extension صح → ضيف .jpg
    final hasImageExt = name.endsWith('.jpg') ||
        name.endsWith('.jpeg') ||
        name.endsWith('.png') ||
        name.endsWith('.webp') ||
        name.endsWith('.gif');

    if (hasImageExt) return name;
    return '${name.isEmpty ? 'glowy_image' : name}.jpg';
  }

  @override
  State<CategoryContentDetails> createState() => _CategoryContentDetailsState();
}

class _CategoryContentDetailsState extends State<CategoryContentDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DownloadCubit, DownloadState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Category Details"),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: state.status == DownloadStatus.loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.download_rounded),
                onPressed: state.status == DownloadStatus.loading
                    ? null
                    : () {
                        context.read<DownloadCubit>().downloadWithIsolate(
                          url: widget.imageUrl,
                          fileName: widget.getFileName(),
                        );
                      },
              ),
            ],
          ),
          body: Center(
            child: switch (widget.mediaType) {
              MediaType.video => VideoItemWidget(videoUrl: widget.imageUrl),
              MediaType.image || MediaType.classification =>
                CachedNetworkImage(imageUrl: widget.imageUrl),
              _ => const SizedBox.shrink(),
            },
          ),
        );
      },
    );
  }
}
