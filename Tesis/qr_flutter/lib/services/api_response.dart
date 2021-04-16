class APIResponse<T> {
  T data;
  bool error;
  String mensajeError;

  APIResponse({this.data, this.error = false, this.mensajeError});
}
