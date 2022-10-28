import 'package:flutter/services.dart';

class MaskedTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 5) {
      newText.write('${newValue.text.substring(0, usedSubstringIndex = 3)}-');
      if (newValue.selection.end >= 5) {
        selectionIndex += 3;
      }
    }
    if (newTextLength >= 6) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 6));
      if (newValue.selection.end >= 6) {
        selectionIndex++;
      }
    }
    if (newTextLength >= 8) {
      newText.write('-${newValue.text.substring(6, usedSubstringIndex = 8)}');
      if (newValue.selection.end >= 11) {
        selectionIndex++;
      }
    }
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
