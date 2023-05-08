import 'package:flutter/material.dart';
import 'package:referl/common/error_screen.dart';
import 'package:referl/dashboard/bloc/dashboard_summary/dashboard_summary_bloc.dart';
import 'package:referl/dashboard/bloc/dashboard_summary/dashboard_summary_event.dart';
import 'package:referl/dashboard/bloc/dashboard_summary/dashboard_summary_state.dart';
import 'package:referl/dashboard/bloc/influencer_list/influencer_list_bloc.dart';
import 'package:referl/dashboard/bloc/influencer_list/influencer_list_event.dart';
import 'package:referl/dashboard/bloc/influencer_list/influencer_list_state.dart';
import 'package:referl/dashboard/widgets/influencer_list_shimmer.dart';
import 'package:referl/dashboard/widgets/influencers_list_tile.dart';
import 'package:heroicons/heroicons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referl/login/bloc/login_bloc.dart';
import 'package:referl/login/bloc/login_event.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashBoardSummaryBloc dashBoardSummaryBloc = DashBoardSummaryBloc();
  final InfluencerListBloc influencerListBloc = InfluencerListBloc();

  @override
  void initState() {
    super.initState();
    dashBoardSummaryBloc.add(FetchDashBoardSummary());
    influencerListBloc.add(FetchActiveInfluencer());
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return RefreshIndicator(
      onRefresh: () async {
        dashBoardSummaryBloc.add(FetchDashBoardSummary());
        influencerListBloc.add(FetchActiveInfluencer());
      },
      child: Scaffold(
        body: BlocConsumer<DashBoardSummaryBloc, DashBoardSummaryState>(
          bloc: dashBoardSummaryBloc,
          listener: (context, dashBoardSummaryState) {
            if (dashBoardSummaryState is DashBoardTokenExpired) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Error: Logged Out"),
                ),
              );
              loginBloc.add(LogoutUser());
            }
          },
          builder: (context, dashBoardSummaryState) {
            if (dashBoardSummaryState is DashBoardSummaryLoaded) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      child: SizedBox(
                        height: height * 0.25,
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: const Color.fromRGBO(223, 233, 237, 1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const HeroIcon(
                                    HeroIcons.user,
                                    color: Colors.green,
                                    size: 25,
                                    style: HeroIconStyle.solid,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Total Customer",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    dashBoardSummaryState
                                        .dashBoardSummaryModel.totalCustomer
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    '\u{20B9}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(8, 183, 119, 1),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Total Earnings",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    dashBoardSummaryState
                                        .dashBoardSummaryModel.totalEarning
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Influencers",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<InfluencerListBloc, InfluencerListState>(
                      bloc: influencerListBloc,
                      builder: (context, state) {
                        if (state is InfluencerListLoaded) {
                          if (state.influencerListModel.active!.isEmpty) {
                            return const Text("No Active Influencers");
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            //itemExtent: 0,
                            physics: const ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: state.influencerListModel.count,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                child: influencersListTile(
                                  name: state
                                      .influencerListModel.active?[index].name,
                                  profilePic: state.influencerListModel
                                      .active?[index].profilePic,
                                  totalReferal: state.influencerListModel
                                      .active?[index].totalReferal
                                      .toString(),
                                  totalEarning: state.influencerListModel
                                      .active?[index].totalEarning
                                      .toString(),
                                  social: state.influencerListModel
                                      .active?[index].social,
                                ),
                              );
                            },
                          );
                        }
                        if (state is InfluencerListError) {
                          return Text(state.error.toString());
                        }
                        return const InfluencerListShimmer();
                      },
                    ),
                  ],
                ),
              );
            } else if (dashBoardSummaryState is DashBoardSummaryError) {
              return ErrorScreen(
                errorMsg: dashBoardSummaryState.error!,
                retry: () {
                  dashBoardSummaryBloc.add(FetchDashBoardSummary());
                  influencerListBloc.add(FetchActiveInfluencer());
                },
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: Color.fromRGBO(12, 164, 109, 1),
                ),
                Container(
                  height: 20,
                ),
                const Text(
                  "Preparing Dashboard...",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
