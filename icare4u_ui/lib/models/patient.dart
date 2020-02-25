import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Patient extends Equatable {
  final double weight;
  final String name;
  final DateTime createdAt;
  final String weightUom;
  final double height;
  final String heightUom;
  final String age;
  final String patientId;
  final List<String> medicines;
  final List<String> schedules;
  final String birthDate;

  Patient({
    @required this.patientId,
    this.name,
    this.weight,
    this.weightUom,
    this.height,
    this.heightUom,
    this.age,
    this.medicines,
    this.schedules,
    this.createdAt,
    this.birthDate,
  }) : assert(patientId != null);

  @override
  List<Object> get props => [patientId];

  Map<String, dynamic> toJson() => {
        'patientId': patientId,
        'patientName': name,
        'weight': weight,
        'weightUom': weightUom,
        'height': height,
        'heightUom': heightUom,
        'age': age,
        'createdAt': createdAt.toIso8601String(),
        'medicines': jsonEncode(medicines),
        'schedules': jsonEncode(schedules),
        'birthDate': birthDate,
      };

  static Patient fromJson(dynamic json) {
    return Patient(
      patientId: json['patientId'],
      name: json['patientName'],
      age: calculateAge(json['birthDate']),
      height: double.parse(json['height']),
      heightUom: json['heightUom'],
      weight: double.parse(json['weight']),
      weightUom: json['weightUom'],
      medicines: json['medicines'] != null
          ? new List<String>.from(json['medicines'])
          : new List<String>(),
      schedules: json['schedules'] != null
          ? new List<String>.from(json['schedules'])
          : new List<String>(),
      createdAt: DateTime.parse(json['createdAt']),
      birthDate: json['birthDate'],
    );
  }

  static String calculateAge(String birthDate) {
    if (birthDate == null || birthDate.length == 0) return "";

    final birthday = DateTime.parse(birthDate);
    final difference =
        (DateTime.now().difference(birthday).inDays / 365).floor().toString();

    debugPrint('patient age: $difference');
    return difference;
  }
}
