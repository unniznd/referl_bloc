import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class ValidateButton extends StatelessWidget {
  const ValidateButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.height,
    required this.width,
  });
  final String buttonText;
  final void Function() onPressed;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.35,
      height: height * 0.06,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromRGBO(12, 164, 109, 1),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: height * 0.02,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            HeroIcon(
              HeroIcons.magnifyingGlass,
              color: Colors.white,
              size: height * 0.03,
              style: HeroIconStyle.solid,
            )
          ],
        ),
      ),
    );
  }
}
