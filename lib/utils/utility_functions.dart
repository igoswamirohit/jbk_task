import 'package:flutter/material.dart';

double calculatePercentage(double value, double total) {
  return (value / total) * 100;
}

showSnackbar(BuildContext context, {required String msg}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}