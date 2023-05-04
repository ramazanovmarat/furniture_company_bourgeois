import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FurnitureCacheImage extends StatelessWidget {
  final String imageUrl;
  final double? height, width;
  const FurnitureCacheImage({Key? key, required this.imageUrl, this.height, this.width}) : super(key: key);

  Widget _imageWidget(ImageProvider imageProvider) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image:imageProvider,
          fit: BoxFit.cover,
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) {
          return _imageWidget(imageProvider);
      },
      placeholder: (context, url) {
        return const Center(child: CircularProgressIndicator());
      },
      errorWidget: (context, url, error) {
        return _imageWidget(const AssetImage('assets/images/error.jpg'));
      },
    );
  }
}
