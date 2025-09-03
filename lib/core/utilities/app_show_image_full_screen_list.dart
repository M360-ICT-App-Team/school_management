import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:polytech/core/constants/app_icons.dart';

void openFullScreenList({
  required BuildContext context,
  required List<String?> imageUrls,
  required int currentIndex,
  required String baseUrl,
  bool onlineImage = true,
}) {
  final PageController pageController = PageController(initialPage: currentIndex);
  final ValueNotifier<int> currentPageNotifier = ValueNotifier<int>(currentIndex);

  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(0),
      child: Stack(
        children: [
          // Blurred + dark background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.black.withValues(alpha: 0.6)),
          ),

          // Swipeable + zoomable images
          ValueListenableBuilder<int>(
            valueListenable: currentPageNotifier,
            builder: (context, currentPage, _) => Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView.builder(
                  controller: pageController,
                  itemCount: imageUrls.length,
                  onPageChanged: (index) => currentPageNotifier.value = index,
                  itemBuilder: (context, index) {
                    final imagePath = imageUrls[index];
                    if (imagePath == null) {
                      return const Center(
                        child: Text("Invalid image", style: TextStyle(color: Colors.white)),
                      );
                    }

                    return InteractiveViewer(
                      panEnabled: true,
                      minScale: 1,
                      maxScale: 5,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: onlineImage
                            ? Image.network(
                                "$baseUrl$imagePath",
                                errorBuilder: (context, error, stackTrace) => const Text(
                                  'Failed to load image',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : Image.file(
                                File(imagePath),
                                errorBuilder: (context, error, stackTrace) => const Text(
                                  'Failed to load image',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                      ),
                    );
                  },
                ),

                // Page indicator
                if (imageUrls.length > 1)
                  Positioned(
                    bottom: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "${currentPage + 1} / ${imageUrls.length}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                // Close button
                Positioned(
                  top: 40,
                  right: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(AppIcons.cancel, color: Colors.white, size: 30),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
