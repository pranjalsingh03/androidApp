class Due {
  final String month;
  final int amount;

  Due({required this.month, required this.amount});

  factory Due.fromJson(Map<String, dynamic> json) {
    return Due(
      month: json['month'],
      amount: json['amount'],
    );
  }
}

class PastPayment {
  final String month;
  final int amount;
  final DateTime date;

  PastPayment({required this.month, required this.amount, required this.date});

  factory PastPayment.fromJson(Map<String, dynamic> json) {
    return PastPayment(
      month: json['month'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
    );
  }
}

class DuesResponse {
  final List<Due> dueList;
  final List<PastPayment> pastPayments;

  DuesResponse({required this.dueList, required this.pastPayments});

  factory DuesResponse.fromJson(Map<String, dynamic> json) {
    return DuesResponse(
      dueList: (json['data']['dueList'] as List)
          .map((e) => Due.fromJson(e))
          .toList(),
      pastPayments: (json['data']['pastPayments'] as List)
          .map((e) => PastPayment.fromJson(e))
          .toList(),
    );
  }
}
