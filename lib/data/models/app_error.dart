class AppError {
  String? error, message;
  int? status;

  AppError({
    this.error,
    this.message,
    this.status,
  });

  factory AppError.fromJson(Map<String, dynamic> json) => AppError(
        error: json["error"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "status": status,
      };
}
