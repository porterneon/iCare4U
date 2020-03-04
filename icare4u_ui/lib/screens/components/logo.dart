import 'package:flutter/material.dart';

final logo = Hero(
  tag: 'hero',
  child: Container(
    child: Center(
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
            child: Image.asset('assets/logos/logo.png'),
          )),
    ),
  ),
);
