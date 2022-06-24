import 'package:flutter/material.dart';

class Const {
  static final Const _singleton = Const._internal();

  factory Const() {
    return _singleton;
  }

  Const._internal();
  static final baseColorShimmer = Colors.grey.shade300;
  static final highlightColorShimmer = Colors.grey.shade100;
}
