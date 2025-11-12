import 'dart:convert';

class ClassDetailModel {
  final String className;
  final String classId;

  ClassDetailModel({
    required this.className,
    required this.classId,
  });

  ClassDetailModel copyWith({
    String? className,
    String? classId,
  }) {
    return ClassDetailModel(
      className: className ?? this.className,
      classId: classId ?? this.classId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'className': className,
      'classId': classId,
    };
  }

  factory ClassDetailModel.fromMap(Map<String, dynamic> map) {
    return ClassDetailModel(
      className: map['className'] as String,
      classId: map['classId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassDetailModel.fromJson(String source) =>
      ClassDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ClassDetailModel(className: $className, classId: $classId)';

  @override
  bool operator ==(covariant ClassDetailModel other) {
    if (identical(this, other)) return true;

    return other.className == className && other.classId == classId;
  }

  @override
  int get hashCode => className.hashCode ^ classId.hashCode;
}
