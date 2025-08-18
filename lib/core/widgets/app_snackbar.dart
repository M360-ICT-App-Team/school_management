// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_text_styles.dart';

class AppBottomSheets {
  static void showSuccess(
    BuildContext context, {
    String? message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.white,
      content: _SuccessContent(message: message,),
      duration: Duration(seconds: 2),
    ));
  }


  static void showError(
    BuildContext context, {
    String? message,
  }) {
    _showBottomSheet(
      context,
      hide: true,
      content: _ErrorContent(message: message),
    );
  }

  static void showLoading(
    BuildContext context, {
    String? message,
  }) {
    _showBottomSheet(
      context,
      content: _LoadingContent(message: message),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void _showBottomSheet(
    BuildContext context, {
    required Widget content,
    bool? hide
  }) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => content,
    );

    if (hide??false) {
      Future.delayed(Duration(seconds: 2), () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      });
    }
  }
}

class _SuccessContent extends StatefulWidget {
  const _SuccessContent({this.message});

  final String? message;

  @override
  State<_SuccessContent> createState() => _SuccessContentState();
}

class _SuccessContentState extends State<_SuccessContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.bodyPadding),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HugeIcon(
              icon: HugeIcons.strokeRoundedTickDouble01,
              color: AppColors.green,
              size: AppSizes.iconSmall,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                widget.message ?? "Request completed successfully.",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.normalBold(context).copyWith(
                  color: AppColors.green,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorContent extends StatelessWidget {
  const _ErrorContent({this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.bodyPadding),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HugeIcon(
              icon: HugeIcons.strokeRoundedAlertCircle,
              color: AppColors.red,
              size: AppSizes.iconSmall,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message ?? "An error occurred. Please try again.",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.normalBold(context).copyWith(
                  color: AppColors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingContent extends StatelessWidget {
  const _LoadingContent({this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LinearProgressIndicator(
          color: AppColors.blue,
          backgroundColor: AppColors.fill,
          minHeight: 3,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppSizes.bodyPadding),
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 15,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HugeIcon(
                  icon: HugeIcons.strokeRoundedLoading01,
                  color: AppColors.blue,
                  size: AppSizes.iconSmall,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    message ?? "Please wait...",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.normalBold(context).copyWith(
                      color: AppColors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}