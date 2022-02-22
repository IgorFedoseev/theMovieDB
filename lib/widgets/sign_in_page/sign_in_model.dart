import 'package:flutter/material.dart';
import 'package:lazyload_flutter_course/domain/api_client/api_client.dart';
import 'package:lazyload_flutter_course/domain/data_providers/session_data_provider.dart';
import 'package:lazyload_flutter_course/ui/navigation/main_navigation.dart';

class SignInModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => _isAuthProgress;

  Future<void> auth(BuildContext context) async {
    final String login = loginTextController.text;
    final String password = passwordTextController.text;
    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Заполните логин и пароль';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    String? sessionId;
    try {
      sessionId = await _apiClient.auth(
        userName: login,
        password: password,
      );
    } catch (e) {
      _errorMessage = 'Неверные данные аккаунта';
    }
    _isAuthProgress = false;
    if (_errorMessage != null) {
      notifyListeners();
      return;
    }
    if (sessionId == null) {
      _errorMessage = 'Неизвестная ошибка';
      notifyListeners();
      return;
    }
    await _sessionDataProvider.setSessionId(sessionId);
    Navigator.of(context)
        .pushReplacementNamed(MainNavigationRoutsNames.mainScreen);
  }
}

// class SignInProvider extends InheritedNotifier {
//   final SignInModel model;
//   const SignInProvider({
//     Key? key,
//     required Widget child,
//     required this.model,
//   }) : super(key: key, notifier: model, child: child);
//
//   static SignInProvider? watch(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<SignInProvider>();
//   }
//
//   static SignInProvider? read(BuildContext context) {
//     final widget = context
//         .getElementForInheritedWidgetOfExactType<SignInProvider>()
//         ?.widget;
//     return widget is SignInProvider ? widget : null;
//   }
// }

