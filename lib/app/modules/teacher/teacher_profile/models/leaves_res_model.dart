class LeavesResponse {
  final int statusCode;
  final List<LeaveModel> data;
  final String message;
  final bool success;

  LeavesResponse({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory LeavesResponse.fromJson(Map<String, dynamic> json) {
    return LeavesResponse(
      statusCode: json['statusCode'] ?? 0,
      data: (json['data'] as List?)
              ?.map((e) => LeaveModel.fromJson(e))
              .toList() ??
          [],
      message: json['message'] ?? '',
      success: json['success'] ?? false,
    );
  }
}

class LeaveModel {
  final DateTime date;
  final String reason;

  LeaveModel({
    required this.date,
    required this.reason,
  });

  factory LeaveModel.fromJson(Map<String, dynamic> json) {
    return LeaveModel(
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      reason: json['reason'] ?? '',
    );
  }
}