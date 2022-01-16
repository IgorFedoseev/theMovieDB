import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExampleTextField extends StatelessWidget {
  const ExampleTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        //child: Image(image: AppImages.imageGoogle),
      ),
    );
  }
}

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]+'), '');

    final initialSpecialSimbolCount = newValue.selection // длина значений
        .textBefore(newValue.text) // которые не цифры
        .replaceAll(RegExp(r'[\d]+'), '') // расп до курсора
        .length;
    final cursorPosition = newValue.selection.start - initialSpecialSimbolCount;
    // высчитываем позицию курсора без вставленных символов
    var finalCursorPosition = cursorPosition; // создадим под ней переменную

    final digitsOnlyChars = digitsOnly.split(''); // разбираем строку по символу
    var newString = <String>[];

    if (oldValue.selection.textInside(oldValue.text) == ')' ||
        oldValue.selection.textInside(oldValue.text) == '-') {
      digitsOnlyChars.removeAt(cursorPosition - 2);
      finalCursorPosition -= 2;
    }

    for (var i = 0; i < digitsOnlyChars.length; i++) {
      if (i == 2) {
        newString.add(digitsOnlyChars[i]);
        newString.add(')');
        if (i <= cursorPosition) finalCursorPosition += 1;
      } else if (i == 5 || i == 7) {
        newString.add(digitsOnlyChars[i]);
        newString.add('-');
        if (i <= cursorPosition) finalCursorPosition += 1;
      } else {
        newString.add(digitsOnlyChars[i]);
      }
    }

    final resultString = newString.join(''); // соединяем снова символы вместе

    return TextEditingValue(
      text: resultString,
      selection: TextSelection.collapsed(offset: finalCursorPosition),
    );
  }
}
