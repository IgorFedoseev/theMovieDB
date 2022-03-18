import 'package:flutter/cupertino.dart';
import 'package:lazyload_flutter_course/domain/data_providers/session_data_provider.dart';
import 'package:lazyload_flutter_course/ui/navigation/main_navigation.dart';

class AppMovieModel {
  final _sessionDataProvider = SessionDataProvider();
  var _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> checkAuth() async{
    final sessionID = await _sessionDataProvider.getSessionId();
    _isAuth = sessionID != null;
  }

  Future<void> resetSession(BuildContext context) async{
    Navigator.of(context).pushReplacementNamed(MainNavigationRoutsNames.auth);
    await _sessionDataProvider.setSessionId(null);
    await _sessionDataProvider.setAccountId(null);
  }
}