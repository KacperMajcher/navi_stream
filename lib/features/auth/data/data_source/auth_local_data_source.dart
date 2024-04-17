import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class AuthLocalDataSource {
  Future<bool> setToken(response) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', response.data['data']['access_token']);
  }

  Future<bool> setOuid(response) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('ouid', response.data['data']['operator_uid']);
  }

  Future<bool> setUserId(response) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt('userId', response.data['data']['user_id']);
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token')!;
  }

  Future<String> getOuid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('ouid')!;
  }

  Future<int> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId') as int;
  }
}
