import 'package:lazyload_flutter_course/domain/data_providers/session_data_provider.dart';

class AppMovieModel {
  final _sessionDataProvider = SessionDataProvider();
  var _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> checkAuth() async{
    final sessionID = await _sessionDataProvider.getSessionId();
    _isAuth = sessionID != null;
  }
}