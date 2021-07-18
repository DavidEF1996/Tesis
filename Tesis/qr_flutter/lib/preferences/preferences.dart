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
    //return _prefs.getString('id');
  }

  // SET JSESSIONID
  set id(String id) {
    _prefs.setString('id', id);
  }

  get nombres {
    return _prefs.getString('nombre') ?? '';
  }

  set nombres(String nombres) {
    _prefs.setString('nombre', nombres);
  }

  get nombresCompletos {
    return _prefs.getString('nombres') ?? '';
  }

  set nombresCompletos(String nombres) {
    _prefs.setString('nombres', nombres);
  }

  get apellidos {
    return _prefs.getString('apellidos') ?? '';
  }

  set apellidos(String apellidos) {
    _prefs.setString('apellidos', apellidos);
  }

  get autorizacion {
    return _prefs.getBool("autorizar" ?? '');
  }

  set autorizacion(bool autorizar) {
    _prefs.setBool("autorizar", autorizar);
  }

  get tipoCirujia {
    return _prefs.getString("tipo_cirujia" ?? '');
  }

  set tipoCirujia(String tipo_cirujia) {
    _prefs.setString("tipo_cirujia", tipo_cirujia);
  }

  get hora_inicio {
    return _prefs.getInt("hora_inicio");
  }

  set hora_inicio(int hora_inicio) {
    _prefs.setInt("hora_inicio", hora_inicio);
  }

  get hora_fin {
    return _prefs.getInt("hora_fin");
  }

  set hora_fin(int hora_fin) {
    _prefs.setInt("hora_fin", hora_fin);
  }

  get numero_dias {
    return _prefs.getInt("numero_dias");
  }

  set numero_dias(int numero_dias) {
    _prefs.setInt("numero_dias", numero_dias);
  }

  get codigoResponse {
    return _prefs.getInt("codigo");
  }

  set codigoResponse(int codigo) {
    _prefs.setInt("codigo", codigo);
  }
}
