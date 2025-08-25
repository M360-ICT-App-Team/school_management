import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

Future<void> appBottomSheet(
  BuildContext context, {
  required Widget child,
}) async {
  await showModalBottomSheet(
    context: context,
    showDragHandle: true,
    useSafeArea: true,
    isScrollControlled: true,
    builder: (context) => SafeArea(
      child: Container(
        padding: const EdgeInsets.only(
          left: AppSizes.bodyPadding,
          bottom: AppSizes.bodyPadding,
          right: AppSizes.bodyPadding,
        ),
        child: child,
      ),
    ),
  );
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

/*
FilePickCard(
  title: "License Copy",
  existingFileUrl: documentResponseModel?.licenseCopy,
  fileNotifier: licenseCopyNotifier,
  icon: HugeIcons.strokeRoundedLicense,
),
*/

class AppSheetInput<T> extends FormField<T> {
  final List<T> items;
  final T? selectedItem;
  final String Function(T) getLabel;
  final String hint;
  final String label;
  final bool isSearchable;
  final IconData icon;
  final double? height;

  AppSheetInput({
    super.key,
    required this.items,
    this.height,
    required this.selectedItem,
    super.initialValue,
    required this.getLabel,
    required void Function(T?) onChanged,
    this.isSearchable = false,
    required this.hint,
    required this.label,
    required this.icon,
    super.validator,
    bool autovalidateMode = false,
  }) : super(
         autovalidateMode: autovalidateMode
             ? AutovalidateMode.onUserInteraction
             : AutovalidateMode.disabled,
         builder: (FormFieldState<T> state) {
           return _AppSheetContent<T>(
             label: label,
             items: items,
             height: height,
             selectedItem: selectedItem,
             getLabel: getLabel,
             onChanged: (T? value) {
               state.didChange(value);
               onChanged(value);
             },
             hint: hint,
             icon: icon,
             isSearchable: isSearchable,
             errorText: state.errorText,
             state: state,
           );
         },
       );
}

class _AppSheetContent<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedItem;
  final String Function(T) getLabel;
  final void Function(T?) onChanged;
  final String hint;
  final String label;
  final bool isSearchable;
  final IconData icon;
  final String? errorText;
  final double? height;
  final FormFieldState<T> state;

  const _AppSheetContent({
    required this.items,
    required this.height,
    required this.selectedItem,
    required this.getLabel,
    required this.onChanged,
    required this.hint,
    required this.label,
    required this.icon,
    required this.isSearchable,
    required this.errorText,
    required this.state,
  });

  @override
  State<_AppSheetContent<T>> createState() => _AppSheetContentState<T>();
}

class _AppSheetContentState<T> extends State<_AppSheetContent<T>> {
  final TextEditingController _searchController = TextEditingController();
  List<T> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  @override
  void didUpdateWidget(covariant _AppSheetContent<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      setState(() {
        _filteredItems = widget.items;
      });
    }
  }

  void _showDropdown() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: widget.height,
              margin: const EdgeInsets.only(
                left: AppSizes.bodyPadding,
                bottom: AppSizes.bodyPadding,
                right: AppSizes.bodyPadding,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.isSearchable) ...[
                    const SizedBox(height: AppSizes.insidePadding),
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Search...",
                        fillColor: AppColors.fill,
                        filled: true,
                        prefixIcon: HugeIcon(
                          icon: HugeIcons.strokeRoundedSearch01,
                          color: Theme.of(context).colorScheme.outline,
                          size: 20,
                        ),
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          color: AppColors.lightGrey,
                        ),
                        isDense: true,
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(style: BorderStyle.none),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(AppSizes.textFieldRadius),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(style: BorderStyle.none),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(AppSizes.textFieldRadius),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(style: BorderStyle.none),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(AppSizes.textFieldRadius),
                          ),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(style: BorderStyle.none),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(AppSizes.textFieldRadius),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setModalState(() {
                          _filteredItems = widget.items
                              .where(
                                (item) => widget
                                    .getLabel(item)
                                    .toLowerCase()
                                    .contains(value.toLowerCase()),
                              )
                              .toList();
                        });
                      },
                    ),
                    _buildListView(),
                  ] else
                    _buildListView(),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      _searchController.clear();
      setState(() {
        _filteredItems = widget.items;
      });
    });
  }

  Widget _buildListView() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _filteredItems.length,
        itemBuilder: (context, index) {
          final item = _filteredItems[index];
          final isSelected = widget.selectedItem == item;
          return ListTile(
            title: Text(
              widget.getLabel(item),
              style: TextStyle(
                color: isSelected ? AppColors.primary : null,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            leading: isSelected
                ? Icon(Icons.check, color: AppColors.primary)
                : const SizedBox(width: 24),
            onTap: () {
              widget.onChanged(item);
              Navigator.pop(context);
              _searchController.clear();
              setState(() {
                _filteredItems = widget.items;
              });
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: _showDropdown,
          child: IgnorePointer(
            ignoring: true,
            child: AppTextField(
              suffixIcon: Icon(Icons.arrow_drop_down, color: Colors.grey),
              hintText: widget.hint,
              readOnly: true,
              controller: TextEditingController(
                text: widget.selectedItem != null
                    ? widget.getLabel(widget.selectedItem as T)
                    : '',
              ),
            ),
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: Text(
              widget.errorText!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}


