import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/image_utils.dart';

class RemoteImage extends StatelessWidget {
  final String? imageId;
  final String recyclingKey;
  final BoxFit fit;
  final double? width;
  final double? height;
  final double borderRadius;
  final double? aspectRatio;

  const RemoteImage({
    super.key,
    required this.imageId,
    required this.recyclingKey,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius = 10,
    this.aspectRatio,
  });

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (imageId == null || imageId!.isEmpty) {
      child = Container(color: const Color(0xFFDDDDDD));
    } else {
      child = CachedNetworkImage(
        key: ValueKey(recyclingKey),
        imageUrl: getImageUrl(imageId!),
        fit: fit,
        placeholder: (context, url) => Container(color: const Color(0xFFDDDDDD)),
        errorWidget: (context, url, error) =>
            Container(color: const Color(0xFFDDDDDD)),
      );
    }

    child = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: child,
    );

    child = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: AppColors.black),
      ),
      child: child,
    );

    if (aspectRatio != null) {
      child = AspectRatio(aspectRatio: aspectRatio!, child: child);
    }

    if (width != null || height != null) {
      child = SizedBox(width: width, height: height, child: child);
    }

    return child;
  }
}
