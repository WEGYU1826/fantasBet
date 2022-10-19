import 'dart:collection';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fantasy_bet/provide/auth.dart';
import 'package:fantasy_bet/provide/bet_slip.dart';
import 'package:fantasy_bet/provide/permier_league.dart';
import 'package:fantasy_bet/screen/bet_slip_screen.dart';
import 'package:fantasy_bet/widget/app_drawer.dart';
import 'package:fantasy_bet/widget/badge.dart';
import 'package:fantasy_bet/widget/bet_btn.dart';
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
  var selectedMatch = -1;
  int selectedIndex = -1;
  HashSet selectItems = HashSet();

  Map<String, int> _myIndex = {};

  final List<String> _betBtnText = [
    'Home',
    'Draw',
    'Away',
  ];

  // void doMultiSelection(String path, [String? betID]) {
  //   setState(() {
  //     if (selectItems.contains(path)) {
  //       selectItems.remove(path);
  //       Provider.of<BetSlip>(context, listen: false).removeItem(betID!);
  //     } else {
  //       selectItems.add(path);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final permierLeagueData =
        Provider.of<PermierLeague>(context, listen: false);
    final leagueList = permierLeagueData.list;
    final betSlip = Provider.of<BetSlip>(context);
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
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          BetSlipScreen.routeName,
                        );
                      },
                      icon: SvgPicture.asset(
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
            itemBuilder: (context, index) => Card(
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
                            CachedNetworkImage(
                              width: 40.0,
                              height: 40.0,
                              imageUrl:
                                  permierLeagueData.list[index].homeTeamCrest,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
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
                            CachedNetworkImage(
                              width: 40.0,
                              height: 40.0,
                              imageUrl:
                                  permierLeagueData.list[index].awayTeamCrest,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
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
                    const SizedBox(height: 10.0),
                    Wrap(
                      direction: Axis.horizontal,
                      children: List.generate(
                        permierLeagueData.list[index].odd.length,
                        (i) {
                          // _myIndex[index.toString()]
                          return InkWell(
                            onTap: () {
                              betSlip.addBets(
                                permierLeagueData.list[index].id,
                                permierLeagueData.list[index].homeTeamName,
                                permierLeagueData.list[index].awayTeamName,
                                permierLeagueData.list[index].odd[i],
                                _betBtnText[i],
                              );
                              if (_myIndex[index.toString()] == null) {
                                _myIndex[index.toString()] = i;
                                setState(() {});
                                return;
                              }
                              if (_myIndex[index.toString()]! >= 0 &&
                                  i == _myIndex[index.toString()]) {
                                _myIndex[index.toString()] = -1;
                                Provider.of<BetSlip>(context, listen: false)
                                    .removeItem(
                                  betSlip.betsLipList[index].id,
                                );
                              } else {
                                _myIndex[index.toString()] = i;
                              }

                              setState(() {});
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: BetButtons(
                                color: Colors.white,
                                backgroundColor: _myIndex[index.toString()] == i
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context).primaryColor,
                                borderColor: _myIndex[index.toString()] == i
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context).primaryColor,
                                size: 25,
                                text:
                                    '${_betBtnText[i]} ${permierLeagueData.list[index].odd[i]}',
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
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
