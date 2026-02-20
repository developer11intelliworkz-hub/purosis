import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppImageView extends StatelessWidget {
  const AppImageView({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.color,
  });

  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      fit: fit,
      imageUrl: imageUrl?.trim() ?? "",
      color: color,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(width: 200, height: 200, color: Colors.white),
      ),
      errorWidget: (context, url, error) => Icon(Icons.broken_image_outlined),
    );
  }
}
