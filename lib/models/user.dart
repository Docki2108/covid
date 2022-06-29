// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid/view/register.dart';

//singleTon
class User {
  static User? _User;
  List<DocumentReference>? testi;
  String id;
  String name;
  int years;
  Gender gender;

  User._(
      {required this.id,
      this.testi,
      required this.name,
      required this.years,
      required this.gender});

  factory User(
          {String? id,
          List<DocumentReference>? testi,
          String? name,
          int? years,
          Gender? gender}) =>
      _User ??= User._(
          id: id!, testi: testi!, name: name!, years: years!, gender: gender!);

  void clear() {
    _User = null;
  }

  User copyWith({
    String? id,
    String? name,
    int? years,
    Gender? gender,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      years: years ?? this.years,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'years': years,
      'gender': gender == Gender.Male,
      'testi': testi,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      years: map['years'] as int,
      gender: map['gender'] as bool ? Gender.Male : Gender.Female,
      testi: (map['testi'] ?? <DocumentReference>[]).cast<DocumentReference>(),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, years: $years, gender: $gender)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.years == years &&
        other.gender == gender;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ years.hashCode ^ gender.hashCode;
  }
}
