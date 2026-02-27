import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class AppDropDown<T> extends StatelessWidget {
  final String label;
  final FutureOr<List<T>> Function(String, LoadProps?)? items;
  final T? selectedItem;
  final ValueChanged<T?>? onChanged;
  final String Function(T)? itemAsString;
  final bool showSearchBox;
  final bool Function(T, T)? compareFn;
  final String? Function(T?)? validator;

  const AppDropDown({
    super.key,
    required this.label,
    required this.items,
    this.selectedItem,
    this.onChanged,
    this.itemAsString,
    this.showSearchBox = true,
    this.compareFn,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      items: items,
      selectedItem: selectedItem,
      compareFn: compareFn,
      popupProps: PopupProps.menu(
        showSearchBox: showSearchBox,
        fit: FlexFit.loose,
        searchFieldProps: const TextFieldProps(
          decoration: InputDecoration(
            hintText: "Search...",
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
      ),
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
        ),
      ),
      itemAsString: itemAsString,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
