class ExceptionApp implements Exception {
  final String message;
  final int? code;
  ExceptionApp(this.message, {this.code});
  @override
  String toString() => 'ExceptionApp: $message (code $code)';
}