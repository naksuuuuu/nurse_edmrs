import 'package:bu_edmrs/utils/constants/size.dart';
import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imgUrl,
    required this.applyImageRadius,
    this.border,
    this.backgroundColor,
    this.fit,
    this.paddding,
    required this.isNetworkImage,
    this.onPressed,
  });

  final double? width, height;
  final String imgUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? paddding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: paddding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(ConstSizes.md),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius ? BorderRadius.circular(ConstSizes.md) : BorderRadius.zero,
          child: Image(
            image: isNetworkImage ? NetworkImage(imgUrl) : AssetImage(imgUrl) as ImageProvider,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
