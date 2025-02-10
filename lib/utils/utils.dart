import 'package:flutter/material.dart';

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Center(
        child: Text(
      message,
      style: const TextStyle(color: Colors.white),
      textAlign: TextAlign.center,
    )),
    backgroundColor: const Color(0xFF731C65),
  ));
}

bool isFirstCharVowel(String value) =>
    ['a', 'e', 'i', 'o', 'u'].contains(value[0].toLowerCase());
