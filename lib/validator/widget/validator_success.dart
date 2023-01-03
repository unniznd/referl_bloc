import 'package:flutter/material.dart';
import 'package:referl/validator/widget/curve_wave.dart';
import 'package:heroicons/heroicons.dart';

class ValidatorSuccess extends StatelessWidget {
  final double height;
  final AnimationController animationController;

  const ValidatorSuccess({
    super.key,
    required this.height,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.8,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            width: 100,
            child: Divider(
              color: Color.fromRGBO(189, 189, 189, 1),
              thickness: 4.5,
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          const Text(
            "Creative tagline \nkeeps changing",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          ScaleTransition(
            scale: Tween(begin: 0.95, end: 1.0).animate(
              CurvedAnimation(
                parent: animationController,
                curve: const CurveWave(),
              ),
            ),
            child: const HeroIcon(
              HeroIcons.checkCircle,
              size: 200,
              color: Colors.green,
              style: HeroIconStyle.solid,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Approved",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
