import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


///Image widget for fetching internet images using [CachedNetworkImage]
class CustomImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const CustomImage({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width = double.infinity,
    this.height = double.infinity,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        width: width,
        height: height,
        fadeInDuration: const Duration(milliseconds: 300), // Fade in duration
        fadeInCurve: Curves.easeIn, // Fade in curve

        // placeholder: (context, url) =>
        //     const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) =>
            Image.asset('assets/images/no-image.png'),
      ),
    );
  }
}
