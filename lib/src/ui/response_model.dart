class ResponseMessageModel {
  final String message;
  final String error;
  final int count;
  final String errorDescription;

  ResponseMessageModel(
      {this.message, this.error, this.count, this.errorDescription});

  factory ResponseMessageModel.fromJson(Map<String, dynamic> json) {
    return ResponseMessageModel(
        message: json['message'],
        error: json['error'],
        count: json['count'],
        errorDescription: json['error_description']);
  }
}