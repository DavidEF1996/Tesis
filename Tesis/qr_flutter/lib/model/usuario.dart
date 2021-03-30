

class Usuario {
  int id;
  String nombre;
  String correo;
  String claveUser;
  String confirmarClaveUser;

  Usuario(
      {this.id,
      this.nombre,
      this.correo,
      this.claveUser,
      this.confirmarClaveUser});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nombre": nombre,
      "correo": correo,
      "claveUser": claveUser,
      "confirmarClaveUser": confirmarClaveUser,
    };
  }

  factory Usuario.fromJson(Map<String, dynamic> item) {
    return Usuario(
        id: item['codigo'],
        nombre: item['nombre'],
        correo: item['correo'],
        claveUser: item['claveUser'],
        confirmarClaveUser: item['confirmarClaveUser']);
  }
}
