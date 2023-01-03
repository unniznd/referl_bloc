import 'package:flutter/material.dart';

Widget noInternetConnection() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: const [
      Align(
        alignment: Alignment.center,
        child: Text(
          "No Internet Connection!",
        ),
      )
    ],
  );
}
