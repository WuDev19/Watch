import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/colors/VColors.dart';

class ActorItem extends StatelessWidget {
  final String _nameActor;
  final String _originalNameActor;
  final String _profilePicture;

  const ActorItem({
    super.key,
    required String nameActor,
    required String originalNameActor,
    required String profilePicture,
  }) : _nameActor = nameActor,
       _originalNameActor = originalNameActor,
       _profilePicture = profilePicture;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(20)),
          child: AspectRatio(
            aspectRatio: 2 / 3,
            child: Image.network(
              _profilePicture,
              fit: BoxFit.cover,
              cacheWidth: 300,
              errorBuilder: (context, url, error) => const Icon(Icons.error),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                final value =
                    loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!;
                return Center(
                  child: CircularProgressIndicator(
                    value: value,
                    color: VColors.colorIcon,
                  ),
                );
              },
            ),
          ),
        ),
        Text(
          "$_nameActor ($_originalNameActor)",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
