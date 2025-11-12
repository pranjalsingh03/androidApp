class OtpVerifyModel {
  final String userType;
  final String accessToken;

  OtpVerifyModel({
    required this.userType,
    required this.accessToken,
  });

  factory OtpVerifyModel.fromJson(Map<String, dynamic> json) {
    return OtpVerifyModel(
      userType: json['data']['teacher'] != null ? 'Teacher' : 'Student',
      accessToken: json['data']['accessToken'],
    );
  }
}
