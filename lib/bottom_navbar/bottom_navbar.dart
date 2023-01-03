import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:referl/bottom_navbar/cubit/navigation_cubit.dart';
import 'package:referl/dashboard/dashboard.dart';
import 'package:referl/home/home.dart';
import 'package:referl/profile/profile.dart';
import 'package:referl/tip/tip.dart';
import 'package:referl/bottom_navbar/bloc/network_bloc.dart';
import 'package:referl/bottom_navbar/bloc/network_state.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:referl/wallet/wallet.dart';
import 'package:referl/notification/notification.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    List<Widget> screens = const [
      HomeScreen(),
      TipsScreen(),
      DashboardScreen(),
      ProfileScreen(),
    ];

    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              "Referl",
              style: TextStyle(
                fontSize: height * 0.025,
              ),
            ),
            actions: [
              IconButton(
                icon: HeroIcon(
                  HeroIcons.wallet,
                  color: Colors.black,
                  size: height * 0.0375,
                ),
                onPressed: () {
                  showWalletModel(context: context, height: height);
                },
              ),
              const SizedBox(
                width: 10,
              ),
              Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const NotificationScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: HeroIcon(
                      HeroIcons.bell,
                      color: Colors.black,
                      size: height * 0.0375,
                    ),
                  ),
                  Positioned(
                    right: 1,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: const Text(
                        "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          body: BlocListener<NetworkBloc, NetworkState>(
            listener: (context, state) {
              if (state is NetworkFailure) {
                Flushbar(
                  title: "No Internet Connection",
                  message:
                      "Check Internet Connection. Turn on Wifi or Mobile Data.",
                  duration: const Duration(seconds: 3),
                  flushbarPosition: FlushbarPosition.TOP,
                  isDismissible: false,
                ).show(context);
              }
            },
            child: BlocBuilder<NavigationCubit, int>(
              builder: ((context, tabIndex) {
                return screens[tabIndex];
              }),
            ),
          ),
          bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
            builder: (context, state) {
              return Container(
                height: height * 0.0872,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      spreadRadius: 0,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: BottomNavigationBar(
                    selectedItemColor: Colors.green,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    unselectedItemColor: Colors.black87,
                    selectedLabelStyle: TextStyle(
                      fontSize: height * 0.014,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontSize: height * 0.0125,
                      fontWeight: FontWeight.w300,
                    ),
                    type: BottomNavigationBarType.fixed,
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: HeroIcon(
                          HeroIcons.home,
                          size: height * 0.030,
                        ),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: HeroIcon(
                          HeroIcons.bookmarkSquare,
                          size: height * 0.030,
                        ),
                        label: 'Tips',
                      ),
                      BottomNavigationBarItem(
                        icon: HeroIcon(
                          HeroIcons.documentText,
                          size: height * 0.030,
                        ),
                        label: 'Dashboard',
                      ),
                      BottomNavigationBarItem(
                        icon: HeroIcon(
                          HeroIcons.user,
                          size: height * 0.030,
                        ),
                        label: 'Profile',
                      ),
                    ],
                    currentIndex: state,
                    onTap: (index) {
                      BlocProvider.of<NavigationCubit>(context).setIndex(index);
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
