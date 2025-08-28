import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

Future<void> appBottomSheet(BuildContext context,
    {required Widget child}) async {
  await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => Container(
          margin: const EdgeInsets.only(
            left: AppSizes.bodyPadding,
            bottom: AppSizes.bodyPadding,
            right: AppSizes.bodyPadding,
          ),
          decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium)),
          child: child));
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    this.textInputAction,
    this.hintText,
    this.keyboardType,
    required this.controller,
    super.key,
    this.onChanged,
    this.validator,
    this.obscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.autofocus,
    this.expanded,
    this.focusNode,
    this.maxLine,
    this.enable,
    this.readOnly = false,
    this.fillColor,
  });

  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;
  final bool? autofocus;
  final bool? expanded;
  final bool readOnly;
  final bool? enable;
  final FocusNode? focusNode;
  final int? maxLine;
  final bool? fillColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSizes.insidePadding / 2),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          textCapitalization: TextCapitalization.sentences,
          focusNode: focusNode,
          onChanged: onChanged,
          autofocus: autofocus ?? false,
          validator: validator,
          obscureText: obscureText ?? false,
          obscuringCharacter: '*',
          readOnly: readOnly,
          cursorColor: AppColors.primary,
          maxLines: expanded == true ? null : maxLine ?? 1,
          expands: expanded ?? false,
          enabled: enable,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 14, color: AppColors.subtitle),
            filled: true,
            fillColor: fillColor == false ? Colors.transparent : AppColors.fill,
            isDense: true,

            // Border with rounded corners
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.lightGrey, // border color
                width: 1.2, // border thickness
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.lightGrey, width: 1.2),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: AppColors.primary, // highlight color when focused
                width: 1.5,
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red, width: 1.2),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red, width: 1.5),
            ),

            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),

          onTapOutside: (event) => FocusScope.of(context).unfocus(),
        ),
      ],
    );
  }
}
// Future<void> appBottomSheet(BuildContext context,
//     {required Widget child}) async {
//   await showModalBottomSheet(
//       context: context,
//       showDragHandle: true,
//       useSafeArea: true,
//       isScrollControlled: true,
//       builder: (context) => Container(
//           margin: const EdgeInsets.only(
//             left: AppSizes.paddingBody,
//             bottom: AppSizes.paddingBody,
//             right: AppSizes.paddingBody,
//           ),
//           decoration: BoxDecoration(
//               color: AppColors.scaffoldBackgroundColor(context),
//               borderRadius: BorderRadius.circular(AppSizes.radius)),
//           child: child));
// }

class AppBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required List<T> items,
    required String Function(T) getLabel,
    T? selectedItem,
    bool isSearchable = false,
    double? height,
    String searchHint = "Search...",
  }) {
    final TextEditingController searchController = TextEditingController();
    final ValueNotifier<List<T>> filteredItems = ValueNotifier<List<T>>(items);

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: height,
              margin: const EdgeInsets.only(
                left: AppSizes.bodyPadding,
                bottom: AppSizes.bodyPadding,
                right: AppSizes.bodyPadding,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isSearchable) ...[
                     SizedBox(height: AppSizes.insidePadding),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.insidePadding),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: searchHint,
                          fillColor: AppColors.secondary,
                          prefixIcon: HugeIcon(
                            icon: HugeIcons.strokeRoundedSearch01,
                            color: AppColors.lightGrey,
                            size: 20,
                          ),
                        ),
                        onChanged: (value) {
                          filteredItems.value = items
                              .where((item) => getLabel(item)
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        },
                      ),
                    ),
                  ],
                  Expanded(
                    child: ValueListenableBuilder<List<T>>(
                      valueListenable: filteredItems,
                      builder: (context, filteredItems, _) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            final item = filteredItems[index];
                            final isSelected = selectedItem == item;
                            return ListTile(
                              title: Text(
                                getLabel(item),
                                style: TextStyle(
                                  color: isSelected
                                      ? AppColors.primary
                                      : null,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                              leading: isSelected
                                  ? Icon(Icons.check,
                                      color: AppColors.primary)
                                  : const SizedBox(width: 24),
                              onTap: () {
                                Navigator.pop(context, item);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}




