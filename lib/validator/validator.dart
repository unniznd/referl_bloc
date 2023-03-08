import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referl/validator/bloc/validator_bloc.dart';
import 'package:referl/validator/bloc/validator_event.dart';
import 'package:referl/validator/bloc/validator_state.dart';
import 'package:referl/validator/widget/validator_success.dart';

void showValidatorModal({
  required BuildContext context,
  required var height,
  required TextEditingController refController,
  required TextEditingController amountController,
  required TextEditingController phoneController,
  required AnimationController animationController,
}) {
  final formKey = GlobalKey<FormState>();
  String? dropdown;
  showModalBottomSheet<void>(
    context: context,
    // useRootNavigator: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    backgroundColor: const Color.fromRGBO(231, 238, 250, 1),
    isScrollControlled: true,
    builder: (BuildContext context) {
      var items = [
        'Instagram',
        'WhatsApp',
        'Facebook',
        'Twitter',
        'Snapchat',
        'Others'
      ];

      final ValidatorBloc validatorBloc = ValidatorBloc();

      return BlocConsumer<ValidatorBloc, ValidatorState>(
        bloc: validatorBloc,
        listener: (context, state) {
          if (state is ValidatorError) {
            showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Error Occured'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(state.error.toString()),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        builder: (context, state) {
          bool isLoading = state is ValidatorLoading;
          if (state is ValidatorSuccessful) {
            refController.clear();
            phoneController.clear();
            amountController.clear();
            return ValidatorSuccess(
              height: height,
              animationController: animationController,
            );
          }
          return StatefulBuilder(
            builder: (context, setState) {
              return Container(
                padding: EdgeInsets.fromLTRB(
                  10,
                  0,
                  10,
                  MediaQuery.of(context).viewInsets.bottom,
                ),
                height: height * 0.7,
                child: SafeArea(
                  child: Form(
                    key: formKey,
                    child: DraggableScrollableSheet(
                      initialChildSize: 1,
                      minChildSize: 0.85,
                      builder: (context, scrollController) {
                        return SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
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
                                height: 20,
                              ),
                              Card(
                                elevation: 7,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 2,
                                    bottom: 2,
                                  ),
                                  child: Center(
                                    child: ListTile(
                                      title: Center(
                                        child: SizedBox(
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.text,
                                            controller: refController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.toString().length < 6) {
                                                return "Referral code should have 6 characters";
                                              }
                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              focusColor: Colors.transparent,
                                              errorMaxLines: 2,
                                              hintStyle: TextStyle(
                                                fontSize: 14,
                                              ),
                                              hintText: "Referal Code",
                                              errorText: null,
                                            ),
                                          ),
                                        ),
                                      ),
                                      leading: const IconButton(
                                        icon: Icon(Icons.qr_code),
                                        color: Colors.black,
                                        onPressed: null,
                                      ),
                                      trailing: const IconButton(
                                        icon: Icon(Icons.qr_code_scanner),
                                        color: Colors.black,
                                        onPressed: null,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Card(
                                elevation: 7,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 2,
                                    bottom: 2,
                                  ),
                                  child: Container(
                                    alignment: AlignmentDirectional.center,
                                    child: ListTile(
                                      title: Center(
                                          child:
                                              DropdownButtonFormField<String>(
                                        isExpanded: true,
                                        decoration: const InputDecoration(
                                          hintText: '',
                                          errorMaxLines: 2,
                                        ),
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Select any platform from dropdown';
                                          }

                                          return null;
                                        },
                                        value: null,
                                        hint: const Text("Platform"),
                                        focusColor: Colors.transparent,
                                        alignment: Alignment.center,
                                        dropdownColor: const Color.fromRGBO(
                                          223,
                                          233,
                                          237,
                                          1,
                                        ),
                                        icon: const Icon(null),
                                        items: items.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(
                                              items,
                                            ),
                                          );
                                        }).toList(),
                                        selectedItemBuilder:
                                            (BuildContext context) {
                                          return items
                                              .map<Widget>((String item) {
                                            return Center(
                                              child: Text(
                                                item,
                                                textAlign: TextAlign.center,
                                              ),
                                            );
                                          }).toList();
                                        },
                                        onChanged: (String? currentValue) {
                                          setState(
                                            () => dropdown =
                                                currentValue.toString(),
                                          );
                                        },
                                      )),
                                      leading: const IconButton(
                                        icon: Icon(
                                          Icons.language,
                                        ),
                                        onPressed: null,
                                      ),
                                      trailing: const IconButton(
                                        icon: Icon(
                                          Icons.play_arrow,
                                        ),
                                        onPressed: null,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Card(
                                elevation: 7,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 2,
                                    bottom: 2,
                                  ),
                                  child: Center(
                                    child: ListTile(
                                      title: Center(
                                        child: SizedBox(
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            controller: phoneController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.toString().length !=
                                                      10) {
                                                return 'Phone number should contain 10 characters';
                                              }

                                              return null;
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              focusedBorder: InputBorder.none,
                                              errorMaxLines: 2,
                                              enabledBorder: InputBorder.none,
                                              focusColor: Colors.transparent,
                                              hintStyle: TextStyle(
                                                fontSize: 14,
                                              ),
                                              hintText: "Phone",
                                            ),
                                          ),
                                        ),
                                      ),
                                      leading: const IconButton(
                                        icon: Icon(Icons.phone_android),
                                        color: Colors.black,
                                        onPressed: null,
                                      ),
                                      trailing: const IconButton(
                                        icon: Icon(null),
                                        onPressed: null,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Card(
                                elevation: 7,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 2,
                                    bottom: 2,
                                  ),
                                  child: Center(
                                    child: ListTile(
                                      title: Center(
                                        child: SizedBox(
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            controller: amountController,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.toString().length <=
                                                      1) {
                                                return 'Amount should not be blank or less than 9';
                                              }

                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              focusColor: Colors.transparent,
                                              errorMaxLines: 2,
                                              hintStyle: TextStyle(
                                                fontSize: 14,
                                              ),
                                              hintText: "Bill Amount",
                                            ),
                                          ),
                                        ),
                                      ),
                                      leading: const IconButton(
                                          onPressed: null,
                                          icon: Icon(
                                            IconData(
                                              0xf05db,
                                              fontFamily: 'MaterialIcons',
                                            ),
                                          )),
                                      trailing: const IconButton(
                                        icon: Icon(null),
                                        onPressed: null,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                width: 150,
                                height: 50,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      const Color.fromRGBO(12, 164, 109, 1),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            print(dropdown);
                                            validatorBloc.add(
                                              AddReferral(
                                                dropdown.toString(),
                                                refController.text,
                                                phoneController.text,
                                                amountController.text,
                                              ),
                                            );
                                          }
                                        },
                                  child: isLoading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text(
                                          "Validate",
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
                ),
              );
            },
          );
        },
      );
    },
  );
}
