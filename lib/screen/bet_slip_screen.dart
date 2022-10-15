import 'package:fantasy_bet/provide/bet_history.dart';
import 'package:fantasy_bet/provide/bet_slip.dart';
import 'package:fantasy_bet/widget/betSlip.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BetSlipScreen extends StatelessWidget {
  BetSlipScreen({super.key});
  static const routeName = '/bet_slip';
  final _form = GlobalKey<FormState>();
  TextEditingController stakeController = TextEditingController();
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
                      onSaved: (value) {},
                      controller: stakeController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "input can't be empty";
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
                  onPressed: () {},
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
                          betSlip.totalAmount.toString(),
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
                        'Stake',
                        style: GoogleFonts.acme(fontSize: 20.0),
                      ),
                      const SizedBox(width: 10),
                      const Spacer(),
                      Chip(
                        label: Text(
                          betSlip.totalAmount.toString(),
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
                          betSlip.totalAmount.toString(),
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
                  BetButton(betSlip: betSlip),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: ListView.builder(
                itemCount: betSlip.betSlips.length,
                itemBuilder: (context, index) => BetSlipCard(
                      id: betSlip.betSlips.values.toList()[index].id,
                      betID: betSlip.betSlips.keys.toList()[index],
                      homeTeam:
                          betSlip.betSlips.values.toList()[index].homeTeam,
                      awayTeam:
                          betSlip.betSlips.values.toList()[index].awayTeam,
                      odd: betSlip.betSlips.values.toList()[index].odd,
                      prediction:
                          betSlip.betSlips.values.toList()[index].prediction,
                    )),
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
  });
  final BetSlip betSlip;

  @override
  State<BetButton> createState() => _BetButtonState();
}

class _BetButtonState extends State<BetButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (widget.betSlip.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<BetHistory>(context, listen: false)
                  .addBetHistory(
                widget.betSlip.betSlips.values.toList(),
                widget.betSlip.totalAmount,
              );
              setState(() {
                _isLoading = false;
              });
              widget.betSlip.clear();
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
