import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _guestUsernameKey = 'guestUsername';

  Future<void> saveGuestUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_guestUsernameKey, username);
  }

  Future<String?> getGuestUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_guestUsernameKey);
  }
}
