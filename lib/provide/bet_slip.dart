import 'package:flutter/foundation.dart';

class BetSlipItem {
  final String id;
  final String homeTeam;
  final String awayTeam;
  final String prediction;
  final int quantity;
  final double odd;

  BetSlipItem({
    required this.id,
    required this.odd,
    required this.homeTeam,
    required this.awayTeam,
    required this.quantity,
    required this.prediction,
  });
}

class BetSlip with ChangeNotifier {
  Map<String, BetSlipItem> _betSlips = {};
  Map<String, BetSlipItem> get betSlips {
    return {..._betSlips};
  }

  // int get betCount {
  //   var total = 0;
  //   _betSlips.forEach((key, value) {
  //     total += value.quantity;
  //   });
  //   return total;
  // }
  int get betCount {
    return _betSlips == null ? 0 : _betSlips.length;
  }

  double get totalOdd {
    var total = 1.0;
    _betSlips.forEach((key, value) {
      total *= value.odd;
    });
    return total;
  }

  double totalWin(double stack) {
    var total = 1.0;
    total = totalOdd * stack;
    return total;
  }

  void addBets(String matchID, String homeTeamName, String awayTeamName,
      double odd, String prediction) {
    _betSlips.putIfAbsent(
      matchID,
      () => BetSlipItem(
        id: DateTime.now().toString(),
        odd: odd,
        homeTeam: homeTeamName,
        awayTeam: awayTeamName,
        quantity: 1,
        prediction: prediction,
      ),
    );

    notifyListeners();
  }

  void removeItem(String betID) {
    _betSlips.remove(betID);
    notifyListeners();
  }

  void removeSingleBetSlips(String betID) {
    if (!_betSlips.containsKey(betID)) {
      return;
    }
    if (_betSlips[betID]!.quantity > 1) {
      _betSlips.update(
        betID,
        (existingCartItem) => BetSlipItem(
          id: existingCartItem.id,
          homeTeam: existingCartItem.homeTeam,
          awayTeam: existingCartItem.awayTeam,
          odd: existingCartItem.odd,
          prediction: existingCartItem.prediction,
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      _betSlips.remove(betID);
    }
    notifyListeners();
  }

  void clear() {
    _betSlips = {};
    notifyListeners();
  }
}
