import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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

  @override
  State<CategoryContentDetails> createState() => _CategoryContentDetailsState();
}

class _CategoryContentDetailsState extends State<CategoryContentDetails> {
  @override
  Widget build(BuildContext context) {
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
      ),
      body: Center(
        child: switch (widget.mediaType) {
          MediaType.video => VideoItemWidget(videoUrl: widget.imageUrl),
          MediaType.image || MediaType.classification => CachedNetworkImage(
            imageUrl: widget.imageUrl,
          ),
          _ => const SizedBox.shrink(),
        },
      ),
    );
  }
}
