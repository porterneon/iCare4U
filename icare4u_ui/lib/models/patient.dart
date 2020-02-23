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
  final int age;
  final String patientId;
  final List<String> medicines;
  final List<String> schedules;

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
        'schedules': jsonEncode(schedules)
      };

  static Patient fromJson(dynamic json) {
    return Patient(
      patientId: json['patientId'],
      name: json['patientName'],
      age: int.parse(json['age']),
      height: double.parse(json['height']),
      heightUom: json['heightUom'],
      weight: double.parse(json['weight']),
      weightUom: json['weightUom'],
      medicines: new List<String>.from(json['medicines']),
      schedules: new List<String>.from(json['schedules']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
