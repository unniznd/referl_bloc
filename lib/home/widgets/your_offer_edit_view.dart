// ignore_for_file: file_names
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class YourOfferEditView extends StatelessWidget {
  const YourOfferEditView({
    super.key,
    required this.payoutController,
    required this.validityController,
    required this.onConfirm,
    required this.screenWidth,
    required this.onClose,
    required this.isLoadingConfirm,
    required this.payoutFocusNode,
    required this.validityFocusNode,
    required this.formKey,
  });

  final TextEditingController payoutController;
  final TextEditingController validityController;
  final void Function() onConfirm;
  final double screenWidth;
  final void Function() onClose;
  final bool isLoadingConfirm;
  final FocusNode payoutFocusNode;
  final FocusNode validityFocusNode;

  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SizedBox(
        width: double.maxFinite,
        height: 250,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: const Color.fromRGBO(234, 233, 240, 1),
          child: Stack(
            children: [
              Positioned(
                top: 5,
                right: 5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: onClose,
                      child: const HeroIcon(
                        HeroIcons.xMark,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                top: 10,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.55,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: payoutController,
                          focusNode: payoutFocusNode,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter minimum 30 rupees";
                            } else if (int.parse(value.toString()) < 30) {
                              return "Enter minimum 30 rupees";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 2.0,
                              ),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            focusColor: Colors.transparent,
                            prefixStyle: const TextStyle(fontSize: 18),
                            contentPadding: const EdgeInsets.only(left: 48),
                            hintStyle: const TextStyle(
                              fontSize: 14,
                            ),
                            hintText: "Payout per referal",
                            suffixIcon: const Padding(
                              padding: EdgeInsetsDirectional.only(
                                bottom: 25,
                                end: 7.5,
                                top: 2,
                              ),
                              child: Text(
                                "\$",
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: screenWidth * 0.55,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          focusNode: validityFocusNode,
                          keyboardType: TextInputType.number,
                          controller: validityController,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter minimum of 3 days";
                            } else if (int.parse(value.toString()) < 3) {
                              return "Enter minimum of 3 days";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 2.0,
                              ),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            focusColor: Colors.transparent,
                            prefixStyle: const TextStyle(fontSize: 18),
                            contentPadding: const EdgeInsets.only(left: 48),
                            hintStyle: const TextStyle(
                              fontSize: 14,
                            ),
                            hintText: "Referal validitty",
                            suffixIcon: const Padding(
                              padding: EdgeInsetsDirectional.only(
                                bottom: 25,
                                start: 10,
                              ),
                              child: Icon(
                                Icons.calendar_today,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      if (!isLoadingConfirm)
                        SizedBox(
                          width: 125,
                          height: 42,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(12, 164, 109, 1),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            onPressed: onConfirm,
                            child: const Text(
                              "Confirm",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      if (isLoadingConfirm)
                        SizedBox(
                          width: 125,
                          height: 42,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(12, 164, 109, 1),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            onPressed: null,
                            child: const Center(
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget yourOfferEditView({
  required var payoutController,
  required var validityController,
  required var onConfirm,
  required double screenWidth,
  required var onClose,
  required bool isLoadingConfirm,
  required var payoutFocusNode,
  required var validityFocusNode,
  required var context,
}) {
  return SizedBox(
    width: double.maxFinite,
    height: 250,
    child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: const Color.fromRGBO(234, 233, 240, 1),
      child: Stack(
        children: [
          Positioned(
            top: 5,
            right: 5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onClose,
                  child: const HeroIcon(
                    HeroIcons.xMark,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            top: 10,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth * 0.55,
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      controller: payoutController,
                      focusNode: payoutFocusNode,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 2.0,
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        focusColor: Colors.transparent,
                        prefixStyle: const TextStyle(fontSize: 18),
                        contentPadding: const EdgeInsets.only(left: 48),
                        hintStyle: const TextStyle(
                          fontSize: 14,
                        ),
                        hintText: "Payout per referal",
                        suffixIcon: const Padding(
                          padding: EdgeInsetsDirectional.only(
                            bottom: 25,
                            end: 7.5,
                            top: 2,
                          ),
                          child: Text(
                            "\$",
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: screenWidth * 0.55,
                    child: TextField(
                      textAlign: TextAlign.center,
                      focusNode: validityFocusNode,
                      keyboardType: TextInputType.number,
                      controller: validityController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            width: 2.0,
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        focusColor: Colors.transparent,
                        prefixStyle: const TextStyle(fontSize: 18),
                        contentPadding: const EdgeInsets.only(left: 48),
                        hintStyle: const TextStyle(
                          fontSize: 14,
                        ),
                        hintText: "Referal validitty",
                        suffixIcon: const Padding(
                          padding: EdgeInsetsDirectional.only(
                            bottom: 25,
                            start: 10,
                          ),
                          child: Icon(
                            Icons.calendar_today,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  if (!isLoadingConfirm)
                    SizedBox(
                      width: 125,
                      height: 42,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(12, 164, 109, 1),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        onPressed: onConfirm,
                        child: const Text(
                          "Confirm",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  if (isLoadingConfirm)
                    SizedBox(
                      width: 125,
                      height: 42,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromRGBO(12, 164, 109, 1),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        onPressed: null,
                        child: const Center(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
