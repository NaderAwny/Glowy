import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:glowy/presentation/resources/color_manager.dart';

/// Widget يعرض فيديو مع thumbnail وزر play
class VideoItemWidget extends StatefulWidget {
  final String videoUrl;
  final String? thumbUrl;

  const VideoItemWidget({super.key, required this.videoUrl, this.thumbUrl});

  @override
  State<VideoItemWidget> createState() => _VideoItemWidgetState();
}

class _VideoItemWidgetState extends State<VideoItemWidget> {
  VideoPlayerController? _controller;
  bool _isPlaying = false;
  bool _initialized = false;

  void _initAndPlay() async {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    await _controller!.initialize();
    if (mounted) {
      setState(() {
        _initialized = true;
        _isPlaying = true;
      });
      _controller!.play();
      _controller!.setLooping(true);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_initialized && _controller != null) {
      return Stack(
        fit: StackFit.expand,
        children: [
          FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller!.value.size.width,
              height: _controller!.value.size.height,
              child: VideoPlayer(_controller!),
            ),
          ),
          // زر pause في المنتصف
          Positioned(
            bottom: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isPlaying = !_isPlaying;
                  _isPlaying ? _controller!.play() : _controller!.pause();
                });
              },
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Thumbnail مع زر play قبل الضغط
    return GestureDetector(
      onTap: _initAndPlay,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Thumbnail — حاول thumbUrl أولاً ثم videoUrl كـ fallback
          CachedNetworkImage(
            imageUrl: widget.thumbUrl ?? widget.videoUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => _buildPlaceholder(),
            errorWidget: (context, url, error) => _buildPlaceholder(),
          ),

          // أيقونة play
          Center(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.55),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 36,
              ),
            ),
          ),

          // شريط سفلي للدلالة على فيديو
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  // ignore: deprecated_member_use
                  colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.videocam, color: Colors.white, size: 14),
                  SizedBox(width: 4),
                  Text(
                    'Video',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Placeholder جميل بدل الخلفية الداكنة الفاضية
  Widget _buildPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          // ignore: deprecated_member_use
          colors: [ColorManager.surface, ColorManager.surface.withOpacity(0.7)],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.videocam_outlined,
          // ignore: deprecated_member_use
          color: Colors.white.withOpacity(0.3),
          size: 40,
        ),
      ),
    );
  }
}
