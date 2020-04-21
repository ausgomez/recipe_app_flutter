import 'package:flutter/material.dart';

Color lightColor(int i) {
  var colors = [
    Colors.orange[200],
    Colors.red[100],
    Colors.green[200],
    Colors.blue[100],
    Colors.purple[100]
  ];

  return i >= colors.length ? colors[i % colors.length] : colors[i];
}
