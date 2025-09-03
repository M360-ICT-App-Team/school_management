import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:polytech/core/constants/app_icons.dart';

void openFullScreen(BuildContext context, String imageUrl, {bool onlineImage = true}) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent, // Make dialog background transparent
      insetPadding: const EdgeInsets.all(0),
      child: Stack(
        children: [
          // Blurred and darkened background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Blur effect
            child: Container(
              color: Colors.black.withValues(alpha: 0.6), // Darkened background with opacity
            ),
          ),
          // Full-screen image with zoom functionality
          InteractiveViewer(
            child: Center(
              child: onlineImage
                  ? Image.network(
                      imageUrl,
                      errorBuilder: (context, error, stackTrace) => const Text(
                        'Failed to load image',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  : Image.file(
                      File(imageUrl),
                      errorBuilder: (context, error, stackTrace) => const Text(
                        'Failed to load image',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
            ),
          ),
          // Close button at the top left
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              icon: const Icon(AppIcons.cancel, color: Colors.white, size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    ),
  );
}
