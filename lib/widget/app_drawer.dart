import 'package:fantasy_bet/screen/bet_history_screen.dart';
import 'package:fantasy_bet/screen/permier_league_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../helper/custom_route.dart';
import '../provide/auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              'Fantasy Bet',
              style: GoogleFonts.acme(),
            ), //BetSlip
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: SvgPicture.asset(
              'assets/icons/pl1.svg',
              height: 40.0,
              width: 40.0,
              // color: Colors.white,
            ),
            title: Text(
              'Permier League',
              style: GoogleFonts.acme(fontSize: 20.0),
            ),
            onTap: () {
              // Navigator.of(context).pushReplacementNamed(
              //   PermierLeagueScreen.routeName,
              // );
              Navigator.of(context).pushReplacement(
                CustomRoute(
                  builder: (context) => PermierLeagueScreen(),
                ),
              );
            },
          ),
          // const Divider(),
          // ListTile(
          //   leading: SvgPicture.asset(
          //     'assets/icons/cl.svg',
          //     height: 35.0,
          //     width: 35.0,
          //   ),
          //   title: Text(
          //     'Champions League',
          //     style: GoogleFonts.acme(fontSize: 20.0),
          //   ),
          //   onTap: () {
          //     // Navigator.of(context).pushReplacementNamed(
          //     //   ChampionsLeagueScreen.routeName,
          //     // );
          //     Navigator.of(context).pushReplacement(
          //       CustomRoute(
          //         builder: (context) => ChampionsLeagueScreen(),
          //       ),
          //     );
          //   },
          // ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.history_outlined),
            title: Text(
              'Bet History',
              style: GoogleFonts.acme(fontSize: 20.0),
            ),
            onTap: () {
              // Navigator.of(context).pushReplacementNamed(
              //   BetHistoryScreen.routeName,
              // );
              Navigator.of(context).pushReplacement(
                CustomRoute(
                  builder: (context) => BetHistoryScreen(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: SvgPicture.asset(
              'assets/icons/lo.svg',
              height: 28.0,
              width: 28.0,
            ),
            title: Text(
              'Log Out',
              style: GoogleFonts.acme(fontSize: 20.0),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
