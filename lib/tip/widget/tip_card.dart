import 'package:flutter/material.dart';

Widget tipCard({
  required var height,
  required var text,
}) {
  return Card(
    color: const Color.fromRGBO(246, 234, 255, 1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: SizedBox(
      height: height * 0.3,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
