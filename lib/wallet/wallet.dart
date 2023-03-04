import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referl/common/error_screen.dart';
import 'package:referl/wallet/bloc/balance/balance_bloc.dart';
import 'package:referl/wallet/bloc/balance/balance_event.dart';
import 'package:referl/wallet/bloc/balance/balance_state.dart';
import 'package:referl/wallet/bloc/payment/payment_bloc.dart';
import 'package:referl/wallet/bloc/payment/payment_event.dart';
import 'package:referl/wallet/bloc/payment/payment_state.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:referl/wallet/widget/payment_success_failure.dart';

void showWalletModel({
  required BuildContext context,
  required var height,
  required var walletBalanceBloc,
  required var paymentBloc,
  required TextEditingController amountController,
  required Razorpay razorpay,
  required AnimationController animationController,
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
      razorpay.on(
        Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) {
          walletBalanceBloc.add(
            SuccessfulPayment(
              response.paymentId.toString(),
              response.orderId.toString(),
              response.signature.toString(),
            ),
          );
          razorpay.clear();
        },
      );

      razorpay.on(
        Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) {
          print("here");
        },
      );

      return BlocBuilder<WalletBalanceBloc, WalletBalanceState>(
        bloc: walletBalanceBloc,
        builder: (context, state) {
          if (state is WalletBalanceLoaded) {
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
                          Text(
                            "Current Balance: \u{20B9} ${state.walletModel.balance}",
                            style: const TextStyle(
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
                                        controller: amountController,
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
                          BlocBuilder<PaymentBloc, PaymentState>(
                            bloc: paymentBloc,
                            builder: (context, paymentState) {
                              if (paymentState is PaymentLoading) {
                                return SizedBox(
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
                                    onPressed: null,
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }
                              if (paymentState is PaymentRedirected) {
                                var options = {
                                  "key": paymentState.paymentModel.key,
                                  "amount": paymentState.paymentModel.amount,
                                  "name": paymentState.paymentModel.name,
                                  "description":
                                      paymentState.paymentModel.description,
                                  "order_id": paymentState.paymentModel.orderId,
                                };

                                try {
                                  razorpay.open(options);
                                } catch (e) {
                                  walletBalanceBloc.add(FailedPayment(
                                    paymentState.paymentModel.orderId
                                        .toString(),
                                  ));
                                }
                              }
                              return SizedBox(
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
                                  onPressed: () {
                                    paymentBloc.add(
                                      MakeOrder(
                                          int.parse(amountController.text)),
                                    );
                                    amountController.text = '';
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
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          } else if (state is WalletBalanceError) {
            return Container(
              padding: const EdgeInsets.only(
                // bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 10,
                right: 10,
              ),
              child: SizedBox(
                height: height * 0.7,
                child: Center(
                  child: ErrorScreen(
                    errorMsg: state.error!,
                    retry: () {
                      walletBalanceBloc.add(FetchWalletBalance());
                    },
                  ),
                ),
              ),
            );
          } else if (state is ProcessingPayment) {
            return Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: SizedBox(
                height: height * 0.7,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Processing payment",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is AddMoneySuccesful) {
            return PaymentSucessFailure(
              height: height,
              animationController: animationController,
              isSucessful: true,
              transactionId: "100",
            );
          } else if (state is AddMoneyFailed) {
            return PaymentSucessFailure(
              height: height,
              animationController: animationController,
              isSucessful: false,
              transactionId: "100",
            );
          }
          return Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: SizedBox(
              height: height * 0.7,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      );
    },
  );
}
