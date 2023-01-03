import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:referl/common/error_screen.dart';
import 'package:referl/home/bloc/home_summary/home_summary_bloc.dart';
import 'package:referl/home/bloc/home_summary/home_summary_event.dart';
import 'package:referl/home/bloc/home_summary/home_summary_state.dart';
import 'package:referl/home/bloc/influencer_request/influencer_request_bloc.dart';
import 'package:referl/home/bloc/influencer_request/influencer_request_event.dart';
import 'package:referl/home/bloc/influencer_request/influencer_request_state.dart';
import 'package:referl/home/cubit/tab_navigation_cubit.dart';
import 'package:referl/home/cubit/your_offer_submit.dart';
import 'package:referl/home/model/influencer_request_model.dart';
import 'package:referl/home/widgets/validator_button.dart';
import 'package:referl/home/widgets/your_offer_edit_view.dart';
import 'package:referl/home/widgets/your_offer_view.dart';
import 'package:referl/login/bloc/login_event.dart';
import 'package:referl/validator/validator.dart';
import 'package:referl/home/widgets/influencers_request_tile.dart';
import 'package:referl/home/cubit/your_offer_edit_cubit.dart';
import 'package:referl/login/bloc/login_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final FocusNode _payoutFocusNode = FocusNode();
  final FocusNode _validityFocusNode = FocusNode();
  final HomeSummaryBloc homeSummaryBloc = HomeSummaryBloc();
  final YourOfferSubmitCubit yourOfferSubmitCubit = YourOfferSubmitCubit();
  final InfluencerRequestBloc influencerRequestBloc = InfluencerRequestBloc();

  final TextEditingController refController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    homeSummaryBloc.add(FetchMonthlySummary());
    influencerRequestBloc.add(FetchInfluencerRequest());
    animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    var payoutController = TextEditingController();
    var validityController = TextEditingController();
    TabController tabController = TabController(length: 2, vsync: this);

    YourOfferEditCubit yourOfferEditCubit = YourOfferEditCubit();
    TabNavigationCubit tabNavigationCubit = TabNavigationCubit();

    return RefreshIndicator(
      onRefresh: () async {
        homeSummaryBloc.add(FetchMonthlySummary());
        influencerRequestBloc.add(FetchInfluencerRequest());
      },
      child: SafeArea(
        child: BlocConsumer<HomeSummaryBloc, HomeSummaryState>(
          bloc: homeSummaryBloc,
          listener: (context, homeSummaryState) {
            if (homeSummaryState is HomeSummaryTokenExpired) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Error: Logged Out"),
                ),
              );
              loginBloc.add(LoggedOut());
            }
          },
          builder: (context, homeSummaryState) {
            if (homeSummaryState is HomeSummaryLoaded) {
              return Container(
                padding: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Balance",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: height * 0.02,
                              ),
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            Text(
                              "\u{20B9}${homeSummaryState.homeSummaryModel.balance}.00",
                              style: TextStyle(
                                fontSize: height * 0.04,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: width * 0.27,
                                  height: height * 0.1,
                                  child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    color:
                                        const Color.fromRGBO(234, 244, 225, 1),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${homeSummaryState.homeSummaryModel.earning}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: height * 0.017,
                                          ),
                                        ),
                                        Text(
                                          "Earnings",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: height * 0.015,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.04,
                                ),
                                SizedBox(
                                  width: width * 0.27,
                                  height: height * 0.1,
                                  child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    color:
                                        const Color.fromRGBO(234, 233, 240, 1),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${homeSummaryState.homeSummaryModel.referal}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: height * 0.017,
                                          ),
                                        ),
                                        Text(
                                          "Referrals",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: height * 0.015,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ValidateButton(
                              buttonText: "Validator",
                              width: width,
                              height: height,
                              onPressed: () {
                                showValidatorModal(
                                    context: context,
                                    height: height,
                                    refController: refController,
                                    amountController: amountController,
                                    phoneController: phoneController,
                                    animationController: animationController);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<TabNavigationCubit, int>(
                        bloc: tabNavigationCubit,
                        builder: (context, tabIndex) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 50,
                                child: AppBar(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  bottom: TabBar(
                                    labelColor: Colors.black,
                                    labelStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                    controller: tabController,
                                    unselectedLabelColor: Colors.black26,
                                    indicatorColor:
                                        const Color.fromRGBO(12, 164, 109, 1),
                                    onTap: (index) {
                                      tabNavigationCubit.setIndex(index);

                                      if (index == 1) {
                                        yourOfferEditCubit.setEditing(false);
                                      }
                                    },
                                    tabs: const [
                                      Tab(
                                        text: "Influencer Requests",
                                      ),
                                      Tab(
                                        text: "Dashboard",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (tabIndex == 0)
                                BlocConsumer<InfluencerRequestBloc,
                                    InfluencerRequestState>(
                                  bloc: influencerRequestBloc,
                                  listener: (context, state) {
                                    if (state is InfluencerRequestAccepted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text("Request Accept Successful"),
                                        ),
                                      );
                                    }
                                    if (state
                                        is InfluencerRequestAcceptFailed) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text("Request Accept Failed"),
                                        ),
                                      );
                                    }
                                    if (state is InfluencerRequestRejected) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text("Request Reject Successful"),
                                        ),
                                      );
                                    }
                                    if (state
                                        is InfluencerRequestRejectFailed) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text("Request Reject Failed"),
                                        ),
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is InfluencerRequestLoaded) {
                                      if (state.influencerRequestModel.requests!
                                          .cast<InfluencerRequest>()
                                          .isEmpty) {
                                        return const Text(
                                          "No Influencer Requests",
                                        );
                                      }
                                      return ListView.separated(
                                        itemCount: state
                                            .influencerRequestModel.requests!
                                            .cast<InfluencerRequest>()
                                            .length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        separatorBuilder: (context, index) {
                                          return const Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 5, top: 0),
                                            child: Divider(),
                                          );
                                        },
                                        itemBuilder: (context, index) {
                                          return InfluencersRequestTile(
                                            influencerRequest: state
                                                    .influencerRequestModel
                                                    .requests!
                                                    .cast<InfluencerRequest>()[
                                                index],
                                            width: width,
                                            onAccept: () async {
                                              influencerRequestBloc.add(
                                                AcceptInfluencerRequest(
                                                    state.influencerRequestModel
                                                        .requests!
                                                        .cast<InfluencerRequest>()[
                                                            index]
                                                        .id,
                                                    index),
                                              );
                                            },
                                            onReject: () async {
                                              influencerRequestBloc.add(
                                                RejectInfluencerRequest(
                                                    state.influencerRequestModel
                                                        .requests!
                                                        .cast<InfluencerRequest>()[
                                                            index]
                                                        .id,
                                                    index),
                                              );
                                            },
                                            showProfile: () {
                                              influencerRequestBloc.add(
                                                SetProfileInfluencerRequest(
                                                  false,
                                                  index,
                                                ),
                                              );
                                            },
                                            showSocial: () {
                                              influencerRequestBloc.add(
                                                SetProfileInfluencerRequest(
                                                  true,
                                                  index,
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                    } else if (state
                                        is InfluencerRequestError) {
                                      return Text(
                                        state.error.toString(),
                                      );
                                    }
                                    return const CircularProgressIndicator();
                                  },
                                ),
                              if (tabIndex == 1)
                                BlocBuilder<YourOfferEditCubit, bool>(
                                  bloc: yourOfferEditCubit,
                                  builder: (context, state) {
                                    if (!state) {
                                      return YourOfferView(
                                          amount: homeSummaryState
                                              .homeSummaryModel.payout
                                              .toString(),
                                          timeline: homeSummaryState
                                              .homeSummaryModel.validity
                                              .toString(),
                                          onEdit: () {
                                            yourOfferEditCubit.setEditing(true);
                                          },
                                          isLoading: false,
                                          height: height);
                                    }
                                    return BlocBuilder<YourOfferSubmitCubit,
                                        bool>(
                                      bloc: yourOfferSubmitCubit,
                                      builder: (context, state) {
                                        if (state) {
                                          return YourOfferEditView(
                                            payoutController: payoutController,
                                            validityController:
                                                validityController,
                                            onConfirm: () async {},
                                            screenWidth: width,
                                            onClose: () {
                                              yourOfferEditCubit
                                                  .setEditing(false);
                                            },
                                            isLoadingConfirm: true,
                                            payoutFocusNode: _payoutFocusNode,
                                            validityFocusNode:
                                                _validityFocusNode,
                                            formKey: formKey,
                                          );
                                        }
                                        return YourOfferEditView(
                                          payoutController: payoutController,
                                          validityController:
                                              validityController,
                                          onConfirm: () async {
                                            if (formKey.currentState!
                                                .validate()) {
                                              yourOfferSubmitCubit
                                                  .setSubmiting(true);
                                              homeSummaryBloc.add(
                                                UpdateYourOffer(
                                                  int.parse(
                                                    validityController.text,
                                                  ),
                                                  int.parse(
                                                    payoutController.text,
                                                  ),
                                                ),
                                              );
                                              yourOfferSubmitCubit
                                                  .setSubmiting(false);
                                              yourOfferEditCubit
                                                  .setEditing(false);
                                            }
                                          },
                                          screenWidth: width,
                                          onClose: () {
                                            yourOfferEditCubit
                                                .setEditing(false);
                                          },
                                          isLoadingConfirm: false,
                                          payoutFocusNode: _payoutFocusNode,
                                          validityFocusNode: _validityFocusNode,
                                          formKey: formKey,
                                        );
                                      },
                                    );
                                  },
                                ),
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            }
            if (homeSummaryState is HomeSummaryError) {
              return ErrorScreen(
                errorMsg: homeSummaryState.error!,
                retry: () {
                  homeSummaryBloc.add(FetchMonthlySummary());
                  influencerRequestBloc.add(FetchInfluencerRequest());
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
