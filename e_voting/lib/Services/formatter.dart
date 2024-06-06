import 'package:flutter/services.dart';

class CNICInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;
    if (newText.isEmpty) {
      return newValue;
    }

    // Allow digits and dashes
    final filteredText = newText.replaceAll(RegExp(r'[^0-9-]'), '');
    return newValue.copyWith(
      text: filteredText,
      selection: TextSelection.collapsed(offset: filteredText.length),
    );
  }
}
