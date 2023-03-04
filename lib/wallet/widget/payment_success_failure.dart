import 'package:flutter/material.dart';

import 'package:heroicons/heroicons.dart';
import 'package:referl/wallet/widget/curve_wave.dart';

class PaymentSucessFailure extends StatelessWidget {
  final double height;
  final AnimationController animationController;
  final bool isSucessful;
  final String transactionId;

  const PaymentSucessFailure({
    super.key,
    required this.height,
    required this.animationController,
    required this.isSucessful,
    required this.transactionId,
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
          if (isSucessful)
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
          if (!isSucessful)
            ScaleTransition(
              scale: Tween(begin: 0.95, end: 1.0).animate(
                CurvedAnimation(
                  parent: animationController,
                  curve: const CurveWave(),
                ),
              ),
              child: const HeroIcon(
                HeroIcons.xCircle,
                size: 200,
                color: Colors.red,
                style: HeroIconStyle.solid,
              ),
            ),
          const SizedBox(
            height: 40,
          ),
          if (isSucessful)
            const Text(
              "Money Adding to Wallet Sucessful",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          if (!isSucessful)
            const Text(
              "Money Adding to Wallet Failed",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Transaction Id $transactionId",
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
