import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referl/bottom_navbar/bloc/navigation/navigation_bloc.dart';
import 'package:referl/bottom_navbar/bottom_navbar.dart';
import 'package:referl/dashboard/bloc/dashboard_summary/dashboard_summary_bloc.dart';
import 'package:referl/dashboard/bloc/influencer_list/influencer_list_bloc.dart';
import 'package:referl/home/bloc/home_summary/home_summary_bloc.dart';
import 'package:referl/home/bloc/influencer_request/influencer_request_bloc.dart';
import 'package:referl/home/cubit/tab_navigation_cubit.dart';
import 'package:referl/bottom_navbar/bloc/network/network_bloc.dart';
import 'package:referl/home/cubit/your_offer_edit_cubit.dart';
import 'package:referl/home/cubit/your_offer_submit.dart';
import 'package:referl/login/bloc/login_bloc.dart';
import 'package:referl/login/bloc/login_event.dart';
import 'package:referl/login/bloc/login_state.dart';
import 'package:referl/login/login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:referl/wallet/bloc/balance/balance_bloc.dart';
import 'package:referl/wallet/bloc/payment/payment_bloc.dart';

const storage = FlutterSecureStorage();

void main() async {
  runApp(const ReferlApp());
}

class ReferlApp extends StatefulWidget {
  const ReferlApp({super.key});

  @override
  State<ReferlApp> createState() => _ReferlAppState();
}

class _ReferlAppState extends State<ReferlApp> {
  @override
  void initState() {
    super.initState();
    loginBloc.add(IsAuthenticated());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Referl",
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        fontFamily: 'Montserrat',
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => TabNavigationCubit(),
          ),
          BlocProvider(
            create: (_) => NavigationBloc(),
          ),
          BlocProvider(
            create: (_) => YourOfferEditCubit(),
          ),
          BlocProvider(
            create: (_) => YourOfferSubmitCubit(),
          ),
          BlocProvider(
            create: (_) => NetworkBloc(),
          ),
          BlocProvider(
            create: (_) => LoginBloc(),
          ),
          BlocProvider(
            create: (_) => HomeSummaryBloc(),
          ),
          BlocProvider(
            create: (_) => InfluencerRequestBloc(),
          ),
          BlocProvider(
            create: (_) => DashBoardSummaryBloc(),
          ),
          BlocProvider(
            create: (_) => InfluencerListBloc(),
          ),
          BlocProvider(
            create: (_) => WalletBalanceBloc(),
          ),
          BlocProvider(
            create: (_) => PaymentBloc(),
          ),
        ],
        child: BlocBuilder<LoginBloc, AuthenticationState>(
          bloc: loginBloc,
          builder: (context, state) {
            if (state is AuthenticationAuthenticated) {
              return const BottomNavBar();
            }
            if (state is AuthenticationInitial) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
