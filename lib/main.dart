import 'package:fantasy_bet/helper/custom_route.dart';
import 'package:fantasy_bet/provide/auth.dart';
import 'package:fantasy_bet/provide/bet_history.dart';
import 'package:fantasy_bet/provide/bet_slip.dart';
import 'package:fantasy_bet/provide/permier_league.dart';
import 'package:fantasy_bet/screen/auth_screen.dart';
import 'package:fantasy_bet/screen/bet_history_screen.dart';
import 'package:fantasy_bet/screen/bet_slip_screen.dart';
import 'package:fantasy_bet/screen/champions_league_screen.dart';
import 'package:fantasy_bet/screen/home_Screen.dart';
import 'package:fantasy_bet/screen/permier_league_screen.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import 'screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (context) => PermierLeague(),
        ),
        ChangeNotifierProvider(
          create: (context) => BetSlip(),
        ),
        ChangeNotifierProxyProvider<Auth, BetHistory>(
          create: (_) => BetHistory(
            [],
            null.toString(),
            null.toString(),
          ),
          update: (_, authData, prevBetsObject) => BetHistory(
            prevBetsObject == null ? [] : prevBetsObject.bets,
            authData.token,
            authData.userID,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, authData, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fantasy Bet',
          theme: ThemeData(
            primaryColor: HexColor('#00796B'),
            // ignore: deprecated_member_use
            accentColor: HexColor('#FF4081'),
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder(),
              }, //for all page route
            ),
          ),
          home: authData.isAuth
              ? PermierLeagueScreen()
              : FutureBuilder(
                  future: authData.tryAutoLogin(),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            AuthScreen.routeName: (context) => AuthScreen(),
            MainPage.routeName: (context) => MainPage(),
            PermierLeagueScreen.routeName: (context) => PermierLeagueScreen(),
            ChampionsLeagueScreen.routeName: (context) =>
                ChampionsLeagueScreen(),
            BetSlipScreen.routeName: (context) => BetSlipScreen(),
            BetHistoryScreen.routeName: (context) => BetHistoryScreen(),
          },
        ),
      ),
    );
  }
}
