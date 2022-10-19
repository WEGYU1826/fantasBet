import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:fantasy_bet/provide/bet_history.dart' as bet;

class BetHistoryItems extends StatefulWidget {
  const BetHistoryItems({super.key, this.bets});

  final bet.BetHistoryItem? bets;
  @override
  State<BetHistoryItems> createState() => _BetHistoryItemsState();
}

class _BetHistoryItemsState extends State<BetHistoryItems> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _expanded ? min(widget.bets!.bets.length * 20 + 110, 300) : 95,
      child: Card(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: Text('${widget.bets!.totalWin.toStringAsFixed(2)} Birr'),
              subtitle: Text(
                DateFormat('dd/mm/yyyy hh:mm').format(
                  widget.bets!.dateTime,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  _expanded
                      ? Icons.expand_less_outlined
                      : Icons.expand_more_outlined,
                ),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                // vertical: 4,
              ),
              height:
                  _expanded ? min(widget.bets!.bets.length * 20 + 10, 180) : 0,
              child: ListView(
                children: widget.bets!.bets
                    .map(
                      (e) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '${e.homeTeam} VS ${e.awayTeam}',
                            style: GoogleFonts.acme(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${e.prediction}  ${e.odd}',
                            style: GoogleFonts.acme(
                              fontSize: 16.0,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
