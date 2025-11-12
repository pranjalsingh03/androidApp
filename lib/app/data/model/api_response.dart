import 'dart:convert';

class ApiResponse {
  final String message;
  final bool success;

  ApiResponse({
    required this.message,
    required this.success,
  });

  ApiResponse copyWith({
    String? message,
    bool? success,
  }) {
    return ApiResponse(
      message: message ?? this.message,
      success: success ?? this.success,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'success': success,
    };
  }

  factory ApiResponse.fromMap(Map<String, dynamic> map) {
    return ApiResponse(
      message: map['message'] as String,
      success: map['success'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiResponse.fromJson(String source) =>
      ApiResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ApiResponse(message: $message, success: $success)';

  @override
  bool operator ==(covariant ApiResponse other) {
    if (identical(this, other)) return true;

    return other.message == message && other.success == success;
  }

  @override
  int get hashCode => message.hashCode ^ success.hashCode;
}
