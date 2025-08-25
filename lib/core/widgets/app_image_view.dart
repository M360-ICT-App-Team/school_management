import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../constants/app_images.dart';
import '../constants/app_sizes.dart';
import '../constants/app_urls.dart';

class PhotoViewPage extends StatelessWidget {
  final String? imageUrl, imagePath;

  const PhotoViewPage({super.key, this.imageUrl, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                CupertinoIcons.multiply_circle_fill,
                color: Colors.redAccent,
              ),
            ),
          ),
          Expanded(
            child: Hero(
              tag: imagePath ?? imageUrl ?? '',
              child: imagePath == null
                  ? PhotoView(
                      imageProvider: NetworkImage(
                        "${AppUrls.imageUrl}/${imageUrl!}",
                      ),
                    )
                  : PhotoView(imageProvider: FileImage(File(imagePath!))),
            ),
          ),
        ],
      ),
    );
  }
}

class AppCachedNetworkImage extends StatelessWidget {
  const AppCachedNetworkImage({
    super.key,
    required this.url,
    this.height,
    this.width,
    this.isPerson = false,
    this.radius,
    this.isFlag = false,
  });
  final String url;
  final double? height, width, radius;
  final bool isPerson;
  final bool isFlag;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      color: Colors.white,
      imageUrl: isFlag ? url : "${AppUrls.imageUrl}/$url",
      height: height ?? AppSizes.height(context, 100),
      width: width ?? AppSizes.width(context, 100),
      fit: BoxFit.cover,
      placeholder: (_, __) => Container(
        height: height ?? AppSizes.height(context, 100),
        width: width ?? AppSizes.width(context, 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? AppSizes.radiusLarge),
          image: DecorationImage(
            image: isPerson
                ? const AssetImage(AppImages.noImagePerson)
                : const AssetImage(AppImages.noImagePerson),
            fit: BoxFit.cover,
          ),
        ),
      ),
      errorWidget: (_, __, ___) => Container(
        height: height ?? AppSizes.height(context, 100),
        width: width ?? AppSizes.width(context, 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? AppSizes.radiusMedium),
          image: DecorationImage(
            image: isPerson
                ? const AssetImage(AppImages.noImagePerson)
                : const AssetImage(AppImages.noImagePerson),
            fit: BoxFit.cover,
          ),
        ),
      ),
      imageBuilder: (context, imageProvider) => Container(
        height: height ?? AppSizes.height(context, 100),
        width: width ?? AppSizes.width(context, 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? AppSizes.radiusMedium),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
