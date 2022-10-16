import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fantasy_bet/provide/auth.dart';
import 'package:fantasy_bet/provide/bet_slip.dart';
import 'package:fantasy_bet/provide/permier_league.dart';
import 'package:fantasy_bet/screen/bet_slip_screen.dart';
import 'package:fantasy_bet/widget/app_drawer.dart';
import 'package:fantasy_bet/widget/badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class PermierLeagueScreen extends StatefulWidget {
  const PermierLeagueScreen({super.key});
  static const routeName = '/permier_league';

  @override
  State<PermierLeagueScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PermierLeagueScreen> {
  // var _isInit = true;
  // var _isLoading = false;

  final List<Map> _betButton = [
    {'onPressed': () {}, 'text': 'Home', 'odd': 1},
    {'onPressed': () {}, 'text': 'Draw', 'odd': 1},
    {'onPressed': () {}, 'text': 'Away', 'odd': 1},
  ];

  @override
  Widget build(BuildContext context) {
    final permierLeagueData = Provider.of<PermierLeague>(context);
    final leagueList = permierLeagueData.list;

    final betSlip = Provider.of<BetSlip>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: true,
              pinned: true,
              snap: false,
              elevation: 0.0,
              expandedHeight: 260.0,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Consumer<BetSlip>(
                    builder: (_, betSlip, ch) => Badge(
                      value: betSlip.betCount.toString(),
                      child: ch!,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          BetSlipScreen.routeName,
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/icons/bl.svg',
                        width: 30.0,
                        height: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
              backgroundColor: Theme.of(context).primaryColor,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  'Permier League',
                  style: GoogleFonts.acme(),
                ),
                background: Stack(
                  children: <Widget>[
                    BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5,
                        sigmaY: 5,
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://resources.premierleague.com/premierleague/photo/2020/10/14/f1f23c0a-cd6c-4959-9e31-582f3190b4d1/Statement_Graphic_Pink.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(0), //begin color
                            Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(1), //end color
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ];
        },
        body: RefreshIndicator(
          onRefresh: () async =>
              Provider.of<PermierLeague>(context, listen: false).list,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: leagueList.length,
            itemBuilder: (context, index) => ChangeNotifierProvider(
              create: (context) => PermierLeague(),
              child: Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image.network(
                                permierLeagueData.list[index].homeTeamCrest,
                                height: 40.0,
                                width: 40.0,
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                permierLeagueData.list[index].homeTeamName,
                                style: GoogleFonts.acme(),
                              ),
                            ],
                          ),
                          Text(
                            'VS',
                            style: GoogleFonts.acme(),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Image.network(
                                permierLeagueData.list[index].awayTeamCrest,
                                height: 40.0,
                                width: 40.0,
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                permierLeagueData.list[index].awayTeamName,
                                style: GoogleFonts.acme(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                            ),
                            onPressed: () {
                              betSlip.addBets(
                                permierLeagueData.list[index].id,
                                permierLeagueData.list[index].homeTeamName,
                                permierLeagueData.list[index].awayTeamName,
                                permierLeagueData.list[index].odd[0],
                                'Home',
                              );
                              // ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   SnackBar(
                              //     content: const Text(
                              //       'Added item to BetSLip!',
                              //       textAlign: TextAlign.center,
                              //     ),
                              //     duration: const Duration(seconds: 2),
                              //     action: SnackBarAction(
                              //       label: 'UNDO',
                              //       onPressed: () {
                              //         betSlip.removeSingleBetSlips(
                              //           permierLeagueData.list[index].id,
                              //         );
                              //       },
                              //     ),
                              //     backgroundColor: Theme.of(context).primaryColor,
                              //   ),
                              // );
                            },
                            child: Text(
                              'Home  ${permierLeagueData.list[index].odd[0]}',
                              style: GoogleFonts.acme(),
                            ),
                          ),
                          // ElevatedButton(
                          //   style: ButtonStyle(
                          //     backgroundColor: MaterialStateProperty.all(
                          //         Theme.of(context).primaryColor),
                          //   ),
                          //   onPressed: () {
                          //     betSlip.addBets(
                          //       permierLeagueData.list[index].id,
                          //       permierLeagueData.list[index].homeTeamName,
                          //       permierLeagueData.list[index].awayTeamName,
                          //       permierLeagueData.list[index].odd[0],
                          //       'Draw',
                          //     );
                          //   },
                          //   child: Text(
                          //     'Draw  ${permierLeagueData.list[index].odd[1]}',
                          //     style: GoogleFonts.acme(),
                          //   ),
                          // ),
                          // ElevatedButton(
                          //   style: ButtonStyle(
                          //     backgroundColor: MaterialStateProperty.all(
                          //         Theme.of(context).primaryColor),
                          //   ),
                          //   onPressed: () {
                          //     betSlip.addBets(
                          //       permierLeagueData.list[index].id,
                          //       permierLeagueData.list[index].homeTeamName,
                          //       permierLeagueData.list[index].awayTeamName,
                          //       permierLeagueData.list[index].odd[0],
                          //       'Away',
                          //     );
                          //   },
                          //   child: Text(
                          //     'Away  ${permierLeagueData.list[index].odd[2]}',
                          //     style: GoogleFonts.acme(),
                          //   ),
                          // ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
