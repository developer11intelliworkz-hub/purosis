import 'package:flutter/services.dart';

class CommonValidation {
  static String? fieldValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter value";
    }
    return null;
  }

  static String? dropdownValidation(value) {
    if (value == null) {
      return "Please enter value";
    }
    return null;
  }

  static List<TextInputFormatter> inputValidationOnlyNumber({
    int maxLength = 6,
  }) {
    return [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(maxLength),
    ];
  }

  static List<TextInputFormatter> inputValidationOnlyDecimalNumber({
    int maxLength = 6,
  }) {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      LengthLimitingTextInputFormatter(maxLength),
    ];
  }

  static String? isValidEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter value";
    }
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$');
    if (!emailRegex.hasMatch(value)) {
      return "Enter valid email";
    }
    return null;
  }
}
