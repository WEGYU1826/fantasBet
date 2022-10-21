import 'package:fantasy_bet/provide/bet_history.dart';
import 'package:fantasy_bet/provide/bet_slip.dart';
import 'package:fantasy_bet/widget/betSlip.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BetSlipScreen extends StatefulWidget {
  const BetSlipScreen({super.key});
  static const routeName = '/bet_slip';

  @override
  State<BetSlipScreen> createState() => _BetSlipScreenState();
}

class _BetSlipScreenState extends State<BetSlipScreen> {
  final _form = GlobalKey<FormState>();

  double stake = 5;

  @override
  Widget build(BuildContext context) {
    final betSlip = Provider.of<BetSlip>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Bet Slip',
          style: GoogleFonts.acme(),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Form(
                    key: _form,
                    child: TextFormField(
                      onSaved: (value) => setState(() {
                        stake = double.parse(value!);
                      }),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "stack can't be empty";
                        } else if (double.parse(value) < 5) {
                          return 'stack should be above 4';
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Stake',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5.0),
                ElevatedButton(
                  onPressed: () {
                    final isValid = _form.currentState!.validate();
                    if (isValid) {
                      _form.currentState!.save();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: GoogleFonts.acme(),
                  ),
                ),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.all(15.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      Text(
                        'Total Odd',
                        style: GoogleFonts.acme(fontSize: 20.0),
                      ),
                      const SizedBox(width: 10),
                      const Spacer(),
                      Chip(
                        label: Text(
                          betSlip.totalOdd.toStringAsFixed(2),
                          style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .titleMedium!
                                .color,
                          ),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: <Widget>[
                      Text(
                        'Stake',
                        style: GoogleFonts.acme(fontSize: 20.0),
                      ),
                      const SizedBox(width: 10),
                      const Spacer(),
                      Chip(
                        label: Text(
                          stake.toStringAsFixed(2),
                          style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium!
                                  .color),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: <Widget>[
                      Text(
                        'Total Win',
                        style: GoogleFonts.acme(fontSize: 20.0),
                      ),
                      const Spacer(),
                      Chip(
                        label: Text(
                          '${betSlip.totalWin(stake).toStringAsFixed(2)} Birr',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .titleMedium!
                                  .color),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BetButton(
                        betSlip: betSlip,
                        stake: stake,
                      ),
                      TextButton(
                        onPressed: () {
                          betSlip.clear();
                        },
                        child: Text(
                          'Clear All',
                          style: GoogleFonts.acme(
                            fontSize: 20.0,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: ListView.builder(
              itemCount: betSlip.betsLipList.length,
              itemBuilder: (context, index) {
                return BetSlipCard(
                  id: betSlip.betsLipList[index].id,
                  homeTeam: betSlip.betsLipList[index].homeTeam,
                  awayTeam: betSlip.betsLipList[index].awayTeam,
                  odd: betSlip.betsLipList[index].odd,
                  prediction: betSlip.betsLipList[index].prediction,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BetButton extends StatefulWidget {
  const BetButton({
    super.key,
    required this.betSlip,
    required this.stake,
  });
  final BetSlip betSlip;
  final double stake;

  @override
  State<BetButton> createState() => _BetButtonState();
}

class _BetButtonState extends State<BetButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final betHistory = Provider.of<BetHistory>(context, listen: false);
    return TextButton(
      onPressed: (widget.betSlip.totalWin(widget.stake) <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              try {
                await Provider.of<BetHistory>(context, listen: false)
                    .payment(widget.stake);
                if (betHistory.messageResponse() ==
                    'For bet from Fantasy bet') {
                  // ignore: use_build_context_synchronously
                  await Provider.of<BetHistory>(context, listen: false)
                      .addBetHistory(
                    widget.betSlip.betsLipList,
                    widget.betSlip.totalWin(widget.stake),
                    betHistory.statusResponse(),
                  );
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Successful',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.acme(fontSize: 20.0),
                      ),
                      duration: const Duration(seconds: 2),
                      // ignore: use_build_context_synchronously
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  );
                  setState(() {
                    _isLoading = false;
                  });
                  widget.betSlip.clear();
                } else {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Invalid Transaction',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.acme(fontSize: 20.0),
                      ),
                      duration: const Duration(seconds: 2),
                      // ignore: use_build_context_synchronously
                      backgroundColor: Theme.of(context).accentColor,
                    ),
                  );
                  setState(() {
                    _isLoading = false;
                  });
                }
              } catch (e) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      e.toString(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.acme(fontSize: 20.0),
                    ),
                    duration: const Duration(seconds: 2),
                    // ignore: use_build_context_synchronously
                    backgroundColor: Theme.of(context).accentColor,
                  ),
                );
              }

              setState(() {
                _isLoading = false;
              });
            },
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : Text(
              'BET NOW',
              style: GoogleFonts.acme(
                color: Theme.of(context).primaryColor,
                fontSize: 20.0,
              ),
            ),
    );
  }
}
