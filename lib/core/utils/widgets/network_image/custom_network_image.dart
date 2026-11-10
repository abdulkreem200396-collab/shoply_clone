import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.url,
    this.fit = BoxFit.contain,
    this.iconSize = 40,
  });

  final String url;
  final BoxFit fit;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return Icon(
        Icons.shopping_bag_outlined,
        size: iconSize,
        color: Colors.grey,
      );
    }

    return Image.network(
      url,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const Center(child: CircularProgressIndicator(strokeWidth: 2));
      },
      errorBuilder: (context, error, stack) {
        return Icon(
          Icons.broken_image_outlined,
          size: iconSize,
          color: Colors.grey,
        );
      },
    );
  }
}
