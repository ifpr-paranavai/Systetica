class Info {
  static const String SUCCESS = 'success';
  static const String MESSAGE = 'message';
  static const String OBJECT = 'object';

  bool? success;
  String? message;
  dynamic object;

  Info({
    this.success,
    this.message,
    this.object,
  });

  static Info fromJson(Map<String, dynamic> json) => Info(
    success: json[SUCCESS] as bool?,
    message: json[MESSAGE] as String?,
    object: json[OBJECT] as Object?,
  );

  Map<String, dynamic> toJson() {
    return {
      SUCCESS: success,
      MESSAGE: message,
      OBJECT: object,
    };
  }
}
