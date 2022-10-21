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
  List<BetSlipItem> _betSlipList = [];
  List<BetSlipItem> get betsLipList {
    return [..._betSlipList];
  }

  int get betCount {
    return _betSlipList.length;
  }

  double get totalOdd {
    var total = 1.0;
    for (var element in _betSlipList) {
      total *= element.odd;
    }

    return total;
  }

  double totalWin(double stack) {
    var total = 1.0;
    total = totalOdd * stack;
    return total;
  }

  void addBets(String matchID, String homeTeamName, String awayTeamName,
      double odd, String prediction) {
    int searchIndex =
        _betSlipList.indexWhere((element) => element.id == matchID);
    if (searchIndex == -1) {
      _betSlipList.add(
        BetSlipItem(
          id: matchID,
          odd: odd,
          homeTeam: homeTeamName,
          awayTeam: awayTeamName,
          quantity: 1,
          prediction: prediction,
        ),
      );
    } else {
      _betSlipList[searchIndex] = BetSlipItem(
        id: matchID,
        odd: odd,
        homeTeam: homeTeamName,
        awayTeam: awayTeamName,
        quantity: 1,
        prediction: prediction,
      );
    }

    notifyListeners();
  }

  void removeItem(String betID) {
    _betSlipList.removeWhere((e) => e.id == betID);
    notifyListeners();
  }

  void clear() {
    _betSlipList = [];
    notifyListeners();
  }
}
