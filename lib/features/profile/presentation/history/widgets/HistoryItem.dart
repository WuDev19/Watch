import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/features/movie/presentation/setting/widgets/ProgressBorder.dart';

class HistoryItem extends StatelessWidget {
  final String title;
  final String? posterUrl;
  final double? progress;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const HistoryItem({
    super.key,
    required this.title,
    this.posterUrl,
    this.progress,
    this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            ProgressBorder(
              borderWidth: 1.5,
              progress: progress ?? 0,
              child: AspectRatio(
                aspectRatio: 2 / 3,
                child: posterUrl != null
                    ? CachedNetworkImage(
                        imageUrl: posterUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: Colors.grey[850]),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[850],
                          child: const Icon(
                            Icons.broken_image_outlined,
                            color: Colors.white54,
                          ),
                        ),
                      )
                    : Container(
                        color: Colors.grey[850],
                        child: const Icon(
                          Icons.movie_outlined,
                          color: Colors.white54,
                          size: 32,
                        ),
                      ),
              ),
            ),
            Positioned(
              left: 8,
              right: 8,
              bottom: 10,
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                      color: Colors.black87,
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ),
            if (onRemove != null)
              Positioned(
                top: 6,
                right: 6,
                child: GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
