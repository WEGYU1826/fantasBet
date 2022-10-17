import 'package:fantasy_bet/provide/bet_history.dart';
import 'package:fantasy_bet/widget/app_drawer.dart';
import 'package:fantasy_bet/widget/bet_history_items.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BetHistoryScreen extends StatefulWidget {
  const BetHistoryScreen({super.key});
  static const routeName = '/bet_history';

  @override
  State<BetHistoryScreen> createState() => _BetHistoryScreenState();
}

class _BetHistoryScreenState extends State<BetHistoryScreen> {
  Future? _betHistoryFuture;

  Future _obtainBetHistoryFuture() {
    return Provider.of<BetHistory>(context, listen: false)
        .fetchAndSetBetHistory();
  }

  @override
  void initState() {
    super.initState();
    _betHistoryFuture = _obtainBetHistoryFuture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Bet History',
          style: GoogleFonts.acme(),
        ),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _betHistoryFuture,
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          } else {
            if (snapShot.error != null) {
              return const Center(
                child: Text("An error occurred"),
              );
            } else {
              return Consumer<BetHistory>(
                builder: (context, betHistoryData, ch) => ListView.builder(
                  itemCount: betHistoryData.bets.length,
                  itemBuilder: (context, index) => BetHistoryItems(
                    bets: betHistoryData.bets[index],
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
