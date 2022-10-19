import 'package:fantasy_bet/provide/bet_slip.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BetSlipCard extends StatelessWidget {
  const BetSlipCard({
    super.key,
    this.id,
    this.awayTeam,
    this.homeTeam,
    this.odd,
    this.prediction,
  });

  final String? id;
  final String? homeTeam;
  final String? awayTeam;
  final double? odd;
  final String? prediction;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Are you sure?',
              textAlign: TextAlign.center,
              style: GoogleFonts.acme(),
            ),
            content: Text(
              'Do you want to remove the match from the betSlip',
              textAlign: TextAlign.center,
              style: GoogleFonts.acme(),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('NO'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('YES'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<BetSlip>(context, listen: false).removeItem(id!);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(
                  child: Text(
                    odd.toString(),
                    style: GoogleFonts.acme(color: Colors.white),
                  ),
                ),
              ),
            ),
            title: Text(
              '${homeTeam!}  Vs  ${awayTeam!}',
              style: GoogleFonts.acme(),
            ),
            subtitle: Text(
              'Prediction: ${prediction!}',
              style: GoogleFonts.acme(),
            ),
            trailing: Text(
              'Pending...',
              style: GoogleFonts.acme(),
            ),
          ),
        ),
      ),
    );
  }
}
