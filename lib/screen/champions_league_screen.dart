// https://static.toiimg.com/photo/60393025.cms

// https://see.news/wp-content/uploads/2020/12/UEFA-Champions-League.jpg

import 'dart:ui';

import 'package:fantasy_bet/provide/bet_slip.dart';
import 'package:fantasy_bet/screen/bet_slip_screen.dart';
import 'package:fantasy_bet/widget/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../widget/badge.dart';

class ChampionsLeagueScreen extends StatefulWidget {
  const ChampionsLeagueScreen({super.key});
  static const routeName = '/champions_league';

  @override
  State<ChampionsLeagueScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ChampionsLeagueScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: true,
              pinned: true,
              snap: false,
              elevation: 0.0,
              expandedHeight: 250.0,
              backgroundColor: Theme.of(context).primaryColor,
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
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  'Champions League',
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
                                'https://static.toiimg.com/photo/60393025.cms'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Container(),
      ),
      drawer: AppDrawer(),
    );
  }
}
