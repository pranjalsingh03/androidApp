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
  final String id;
  final String userId;
  final String? role;
  final String reason;
  final DateTime leaveFrom;
  final DateTime leaveTo;
  final String status;
  final DateTime? createdAt;

  LeaveModel({
    required this.id,
    required this.userId,
    this.role,
    required this.reason,
    required this.leaveFrom,
    required this.leaveTo,
    required this.status,
    this.createdAt,
  });

  factory LeaveModel.fromJson(Map<String, dynamic> json) {
    return LeaveModel(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      role: json['role'],
      reason: json['reason'] ?? '',
      leaveFrom:
          DateTime.parse(json['leaveFrom'] ?? DateTime.now().toIso8601String()),
      leaveTo:
          DateTime.parse(json['leaveTo'] ?? DateTime.now().toIso8601String()),
      status: json['status'] ?? '',
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }
}
