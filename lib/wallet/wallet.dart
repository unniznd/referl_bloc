import 'package:flutter/material.dart';

void showWalletModel({
  required BuildContext context,
  required var height,
}) {
  showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    isScrollControlled: true,
    backgroundColor: const Color.fromRGBO(231, 238, 250, 1),
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 10,
          right: 10,
        ),
        child: SizedBox(
          height: height * 0.7,
          child: DraggableScrollableSheet(
            initialChildSize: 1,
            minChildSize: 0.85,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Divider(
                        color: Color.fromRGBO(189, 189, 189, 1),
                        thickness: 3,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Adding Money",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      "Current Balance: \u{20B9} 200",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Card(
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                        ),
                        child: Center(
                          child: ListTile(
                            title: Center(
                              child: SizedBox(
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusColor: Colors.transparent,
                                    hintStyle: TextStyle(
                                      fontSize: 14,
                                    ),
                                    hintText: "Enter Money",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: const Color.fromRGBO(234, 244, 225, 1),
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                                top: 10,
                                bottom: 10,
                              ),
                              child: const Text(
                                "500",
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: const Color.fromRGBO(234, 244, 225, 1),
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                                top: 10,
                                bottom: 10,
                              ),
                              child: const Text(
                                "1000",
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: const Color.fromRGBO(234, 244, 225, 1),
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                                top: 10,
                                bottom: 10,
                              ),
                              child: const Text(
                                "2000",
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: const Color.fromRGBO(234, 244, 225, 1),
                            child: Container(
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                                top: 10,
                                bottom: 10,
                              ),
                              child: const Text(
                                "5000",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                      color: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const ListTile(
                        title: Text(
                          "Money will be added to your account",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        leading: SizedBox(
                            // width: 10,
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 150,
                      height: 50,
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
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                        },
                        child: const Text(
                          "Confirm",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
