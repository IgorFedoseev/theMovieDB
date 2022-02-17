import 'package:flutter/material.dart';

class SignInModel extends ChangeNotifier{
  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> auth(BuildContext context) async{

  }
}

class SignInProvider extends InheritedNotifier {
  final SignInModel model;
  const SignInProvider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(key: key, notifier: model, child: child);

  static SignInProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SignInProvider>();
  }

  static SignInProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<SignInProvider>()
        ?.widget;
    return widget is SignInProvider ? widget : null;
  }
}