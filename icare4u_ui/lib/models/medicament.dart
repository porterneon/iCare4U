import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Medicament extends Equatable {
  final String id;
  final DateTime createdAt;
  final String imageUrl;
  final String description;
  final String name;

  Medicament({
    @required this.id,
    this.createdAt,
    this.imageUrl,
    this.description,
    this.name,
  }) : assert(id != null);

  @override
  List<Object> get props => [id];

  Map<String, dynamic> toJson() => {
        'id': id,
        'itemName': name,
        'itemDescription': description,
        'imageUrl': imageUrl,
        'createdAt': createdAt.toIso8601String(),
      };

  static Medicament fromJson(dynamic json) {
    return Medicament(
      id: json['id'],
      createdAt: json['createdAt'],
      imageUrl: json['imageUrl'],
      description: json['itemDescription'],
      name: json['itemName'],
    );
  }
}
