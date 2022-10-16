import 'dart:convert';

import 'package:fantasy_bet/provide/bet_slip.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class BetHistoryItem {
  final String id;
  final double totalWin;
  final List<BetSlipItem> bets;
  final DateTime dateTime;

  BetHistoryItem({
    required this.id,
    required this.totalWin,
    required this.bets,
    required this.dateTime,
  });
}

class BetHistory with ChangeNotifier {
  List<BetHistoryItem> _bets = [];
  final String authToken;
  final String userID;

  BetHistory(this._bets, this.authToken, this.userID);

  List<BetHistoryItem> get bets {
    return [..._bets];
  }

  Future<void> fetchAndSetBetHistory() async {
    final url =
        'https://fantasybet-f763e-default-rtdb.firebaseio.com/bethistorys/$userID.json?auth=$authToken';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<BetHistoryItem> loadedBetHistory = [];
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((betID, betData) {
        loadedBetHistory.insert(
          0,
          BetHistoryItem(
            id: betID,
            totalWin: betData['totalWin'],
            bets: (betData['bets'] as List<dynamic>)
                .map(
                  (items) => BetSlipItem(
                    id: items['id'],
                    odd: items['odd'],
                    homeTeam: items['homeTeam'],
                    awayTeam: items['awayTeam'],
                    quantity: items['quantity'],
                    prediction: items['prediction'],
                  ),
                )
                .toList(),
            dateTime: DateTime.parse(betData['dateTime']),
          ),
        );
      });
      _bets = loadedBetHistory;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addBetHistory(List<BetSlipItem> betSlip, double total) async {
    final url =
        'https://fantasybet-f763e-default-rtdb.firebaseio.com/bethistorys/$userID.json?auth=$authToken';
    final timeStamp = DateTime.now();
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'totalWin': total,
          'dateTime': timeStamp.toIso8601String(),
          'bets': betSlip
              .map((e) => {
                    'id': e.id,
                    'odd': e.odd,
                    'homeTeam': e.homeTeam,
                    'awayTeam': e.awayTeam,
                    'quantity': e.quantity,
                    'prediction': e.quantity,
                  })
              .toList(),
        }),
      );
      _bets.insert(
        0,
        BetHistoryItem(
          id: json.decode(response.body)['name'],
          totalWin: total,
          bets: betSlip,
          dateTime: timeStamp,
        ),
      );
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
