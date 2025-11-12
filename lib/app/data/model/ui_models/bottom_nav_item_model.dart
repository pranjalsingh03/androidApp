import 'dart:convert';

class BottomNavItemModel {
  String label;
  String iconPath;
  BottomNavItemModel({
    required this.label,
    required this.iconPath,
  });

  BottomNavItemModel copyWith({
    String? label,
    String? iconPath,
  }) {
    return BottomNavItemModel(
      label: label ?? this.label,
      iconPath: iconPath ?? this.iconPath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'label': label,
      'iconPath': iconPath,
    };
  }

  factory BottomNavItemModel.fromMap(Map<String, dynamic> map) {
    return BottomNavItemModel(
      label: map['label'] as String,
      iconPath: map['iconPath'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BottomNavItemModel.fromJson(String source) =>
      BottomNavItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BottomNavItemModel(label: $label, iconPath: $iconPath)';

  @override
  bool operator ==(covariant BottomNavItemModel other) {
    if (identical(this, other)) return true;

    return other.label == label && other.iconPath == iconPath;
  }

  @override
  int get hashCode => label.hashCode ^ iconPath.hashCode;
}
