import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _instancia = new Preferences._internal();

  factory Preferences() {
    return _instancia;
  }

  Preferences._internal();

  SharedPreferences _prefs;

  initPreferences() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET JSESSIONID
  get id {
    return _prefs.getString('id') ?? '';
  }

  // SET JSESSIONID
  set id(String id) {
    _prefs.setString('id', id);
  }
}
