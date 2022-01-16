import 'package:flutter/material.dart';

abstract class AppButtonStyle {

  static final ButtonStyle linkButton = ButtonStyle(
    textStyle: MaterialStateProperty.all(
      const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

}
