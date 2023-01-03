// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class YourOfferView extends StatelessWidget {
  const YourOfferView({
    super.key,
    required this.amount,
    required this.timeline,
    // required var onRefresh,
    required this.onEdit,
    required this.isLoading,
    required this.height,
  });
  final String amount;
  final String timeline;
  // final void Function() onRefresh,
  final void Function() onEdit;
  final bool isLoading;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: height * 0.2,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: const Color.fromRGBO(223, 233, 237, 1),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
            : Stack(
                children: [
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // GestureDetector(
                        //   onTap: onRefresh,
                        //   child: HeroIcon(
                        //     HeroIcons.arrowPath,
                        //     color: Colors.black,
                        //     size: height * 0.035,
                        //   ),
                        // ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: onEdit,
                          child: HeroIcon(
                            HeroIcons.pencil,
                            color: Colors.black,
                            size: height * 0.035,
                          ),
                        ),
                        const SizedBox(
                          width: 1,
                        )
                      ],
                    ),
                  ),
                  Positioned.fill(
                    top: height * 0.2 / 2.8,
                    child: Text(
                      amount,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    top: 40,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "$timeline Day(s)",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
