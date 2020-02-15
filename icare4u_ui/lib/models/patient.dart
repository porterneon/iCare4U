import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
        'name': name,
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
      name: json['name'],
      age: json['age'],
      height: json['height'],
      heightUom: json['heightUom'],
      weight: json['weight'],
      weightUom: json['weightUom'],
      medicines:
          (jsonDecode(json['medicines']) as List<dynamic>).cast<String>(),
      schedules:
          (jsonDecode(json['schedules']) as List<dynamic>).cast<String>(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
