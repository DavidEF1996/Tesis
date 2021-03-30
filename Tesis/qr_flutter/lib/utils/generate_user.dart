import 'dart:math';

List<String> generateUser(String nombre, String apellido) {
  var rng = new Random();
  int numero = rng.nextInt(4);

  List<String> nombres = nombre.split(" ");
  List<String> apellidos = apellido.split(" ");
  final inicialPrimerApellido = nombres[0];
  final inicialSegundoApellido = nombres[1];
  final inicialPrimerNombre = apellidos[0];
  final inicialSegundoNombre = apellidos[1];
  int numeroUsuario = rng.nextInt(100);
  int numeroPassword = rng.nextInt(12345);

  String usuario = "";
  String password = "";

  List<String> credenciales = [];

  switch (numero) {
    case 0:
      usuario = inicialPrimerNombre.toLowerCase() +
          inicialPrimerApellido[0] +
          inicialSegundoApellido.toLowerCase() +
          numeroUsuario.toString();
      password = inicialPrimerNombre +
          numeroPassword.toString() +
          inicialSegundoApellido[0] +
          inicialPrimerApellido;
      print(usuario);
      print(numero);
      break;
    case 1:
      usuario = inicialPrimerNombre[0] +
          inicialSegundoNombre.toLowerCase() +
          inicialPrimerApellido.toLowerCase() +
          numeroUsuario.toString();
      password = inicialPrimerNombre +
          numeroPassword.toString() +
          inicialSegundoApellido[0] +
          inicialPrimerApellido;
      print(usuario);
      print(numero);

      break;
    case 2:
      usuario = inicialPrimerNombre.toLowerCase() +
          inicialSegundoNombre[0] +
          inicialSegundoApellido.toLowerCase() +
          numeroUsuario.toString();
      password = inicialPrimerNombre +
          numeroPassword.toString() +
          inicialSegundoApellido[0] +
          inicialPrimerApellido;
      print(usuario);
      break;
    case 3:
      usuario = inicialPrimerApellido.toLowerCase() +
          inicialSegundoApellido[0] +
          inicialPrimerNombre.toLowerCase() +
          numeroUsuario.toString();
      password = inicialPrimerNombre +
          numeroPassword.toString() +
          inicialSegundoApellido[0] +
          inicialPrimerApellido;
      print(usuario);
      print(numero);
      break;
  }

  credenciales.add(usuario);
  credenciales.add(password);
  return credenciales;
}
