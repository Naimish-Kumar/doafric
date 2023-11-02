import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'image_file.dart';

// ignore: must_be_immutable
class CircleImageView extends StatelessWidget {
  double width, height, borderWidth;
  Color borderColor;
  String url;

  CircleImageView(
      {super.key, this.width = 100,
      this.borderColor = colorWhite,
      this.borderWidth = 1,
      this.height = 100,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: borderWidth),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => SizedBox(
        width: width,
        height: height,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: borderWidth),
          image: const DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(ImageFile.placeholder),
          ),
        ),
      ),
    );
  }
}
