// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class test {
  int testPoints;
  DateTime data;
  test({
    required this.testPoints,
    required this.data,
  });

  test copyWith({
    int? testPoints,
    DateTime? data,
  }) {
    return test(
      testPoints: testPoints ?? this.testPoints,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'testPoints': testPoints,
      'data': data.millisecondsSinceEpoch,
    };
  }

  factory test.fromMap(Map<String, dynamic> map) {
    return test(
      testPoints: map['testPoints'] as int,
      data: DateTime.fromMillisecondsSinceEpoch(map['data'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory test.fromJson(String source) =>
      test.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'test(testPoints: $testPoints, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is test &&
        other.testPoints == testPoints &&
        other.data == data;
  }

  @override
  int get hashCode => testPoints.hashCode ^ data.hashCode;
}
