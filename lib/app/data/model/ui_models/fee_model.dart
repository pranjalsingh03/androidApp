import 'dart:convert';

class FeeModel {
  String color; // Color as a string (e.g., "blue")
  int amount;

  FeeModel({
    required this.color,
    required this.amount,
  });

  FeeModel copyWith({
    String? message,
    String? color,
    int? amount,
  }) {
    return FeeModel(
      color: color ?? this.color,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'color': color,
      'amount': amount,
    };
  }

  factory FeeModel.fromMap(Map<String, dynamic> map) {
    return FeeModel(
      color: map['data']['color'] as String,
      amount: map['data']['amount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeeModel.fromJson(String source) =>
      FeeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FeeModel( color: $color, amount: $amount)';
  }

  @override
  bool operator ==(covariant FeeModel other) {
    if (identical(this, other)) return true;

    return other.color == color &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    return color.hashCode ^ amount.hashCode;
  }
}