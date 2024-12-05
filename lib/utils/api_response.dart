class ApiResponse<T> {
  final bool success;
  final String messsage;
  final int statusCode;
  final T data;

  ApiResponse(
      {required this.success,
      required this.messsage,
      required this.statusCode,
      required this.data});
}
