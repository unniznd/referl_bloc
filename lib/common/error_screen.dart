import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String errorMsg;
  final void Function() retry;
  const ErrorScreen({super.key, required this.errorMsg, required this.retry});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage(
                        "assets/images/nothing.gif",
                      ),
                      width: double.infinity,
                      height: 400,
                    ),
                    Center(
                      child: Text(
                        errorMsg,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: retry,
              icon: const Icon(
                Icons.replay,
                color: Colors.black,
              ),
              label: const Text(
                'Try Again',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).bottomAppBarColor),
            )
          ],
        ),
      ),
    );
  }
}
