import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PermierLeagueItem {
  final String id;
  final String homeTeamName;
  final String homeTeamCrest;
  final String awayTeamName;
  final String awayTeamCrest;
  final List<double> odd;

  PermierLeagueItem({
    required this.id,
    required this.homeTeamName,
    required this.homeTeamCrest,
    required this.awayTeamName,
    required this.awayTeamCrest,
    required this.odd,
  });
}

class PermierLeague with ChangeNotifier {
  final List<PermierLeagueItem> _list = [
    PermierLeagueItem(
      id: 'm0',
      homeTeamName: "Brentford FC",
      homeTeamCrest: "https://crests.football-data.org/402.png",
      awayTeamName: 'Brighton FC',
      awayTeamCrest:
          "https://upload.wikimedia.org/wikipedia/sco/thumb/f/fd/Brighton_%26_Hove_Albion_logo.svg/1024px-Brighton_%26_Hove_Albion_logo.svg.png",
      odd: [2.4, 5.0, 1.8],
    ),
    PermierLeagueItem(
      id: 'm1',
      homeTeamName: "Leicester City FC",
      homeTeamCrest: "https://crests.football-data.org/338.png",
      awayTeamName: 'Crystal Palace FC',
      awayTeamCrest: "https://crests.football-data.org/354.png",
      odd: [1.4, 8.0, 2.8],
    ),
    PermierLeagueItem(
      id: 'm2',
      homeTeamName: "Wolverhampton FC",
      homeTeamCrest:
          "https://logodownload.org/wp-content/uploads/2019/04/wolverhampton-logo-escudo-3.png",
      awayTeamName: 'Nottingham Forest FC',
      awayTeamCrest: "https://crests.football-data.org/351.png",
      odd: [2.0, 3.0, 2.9],
    ),
    PermierLeagueItem(
      id: 'm3',
      homeTeamName: "Fulham FC",
      homeTeamCrest:
          "https://seeklogo.com/images/F/fulham-fc-logo-EBBC39136A-seeklogo.com.png",
      awayTeamName: 'AFC Bournemouth FC',
      awayTeamCrest: "https://crests.football-data.org/1044.png",
      odd: [2.3, 4.2, 1.7],
    ),
    PermierLeagueItem(
      id: 'm4',
      homeTeamName: "Tottenham Hotspur FC",
      homeTeamCrest:
          "https://assets.stickpng.com/images/580b57fcd9996e24bc43c4ee.png",
      awayTeamName: 'Everton FC',
      awayTeamCrest: "https://crests.football-data.org/62.png",
      odd: [1.3, 3.9, 2.2],
    ),
    PermierLeagueItem(
      id: 'm5',
      homeTeamName: "Southampton FC",
      homeTeamCrest: "https://crests.football-data.org/340.png",
      awayTeamName: 'WestHam United FC',
      awayTeamCrest: "https://crests.football-data.org/563.png",
      odd: [2.1, 5.4, 1.6],
    ),
    PermierLeagueItem(
      id: 'm6',
      homeTeamName: "Manchester United FC",
      homeTeamCrest: "https://crests.football-data.org/66.png",
      awayTeamName: 'Newcastle United FC',
      awayTeamCrest: "https://crests.football-data.org/67.png",
      odd: [1.2, 7.0, 3.5],
    ),
    PermierLeagueItem(
      id: 'm7',
      homeTeamName: "Leeds United FC",
      homeTeamCrest: "https://crests.football-data.org/341.png",
      awayTeamName: 'Arsenal FC',
      awayTeamCrest: "https://crests.football-data.org/57.png",
      odd: [5.1, 8.1, 1.1],
    ),
    PermierLeagueItem(
      id: 'm8',
      homeTeamName: "Aston Villa FC",
      homeTeamCrest: "https://crests.football-data.org/58.png",
      awayTeamName: 'Chelsea FC',
      awayTeamCrest: "https://crests.football-data.org/61.png",
      odd: [2.5, 4.0, 1.5],
    ),
    PermierLeagueItem(
      id: 'm9',
      homeTeamName: "Liverpool FC",
      homeTeamCrest: "https://crests.football-data.org/64.png",
      awayTeamName: 'Manchester City FC',
      awayTeamCrest: "https://crests.football-data.org/65.png",
      odd: [4.4, 6.1, 3.3],
    ),
  ];

  List<PermierLeagueItem> get list {
    return [..._list];
  }

  // final String authToken;
  // final String userID;
  // PermierLeague(this.authToken, this.userID, this._list);

  // Future<void> fetchSetMatches([bool filterByUser = false]) async {
  //   final filterString = filterByUser ? 'orderBy="creatorID"&equalTo=""' : '';
  //   final url =
  //       'https://fantasybet-f763e-default-rtdb.firebaseio.com/matches.json&$filterString';
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     final extractedData = json.decode(response.body) as Map<String, dynamic>;
  //     if (extractedData == null) {
  //       return;
  //     }
  //     final List<PermierLeagueItem> loadedMatches = [];
  //     extractedData.forEach((matchID, matchData) {
  //       loadedMatches.insert(
  //           0,
  //           PermierLeagueItem(
  //             id: matchID,
  //             homeTeamName: matchData['homeTeamName'],
  //             homeTeamCrest: matchData['homeTeamCrest'],
  //             awayTeamName: matchData['awayTeamName'],
  //             awayTeamCrest: matchData['awayTeamCrest'],
  //             odd: [],
  //           ));
  //     });
  //     _list = loadedMatches;
  //     notifyListeners();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<void> addMatches(PermierLeagueItem matches) async {
  //   const url =
  //       'https://fantasybet-f763e-default-rtdb.firebaseio.com/matches.json';
  //   try {
  //     final response = await http.post(Uri.parse(url),
  //         body: json.encode({
  //           'homeTeamName': matches.homeTeamName,
  //           'homeTeamCrest': matches.homeTeamCrest,
  //           'awayTeamName': matches.awayTeamName,
  //           'awayTeamCrest': matches.awayTeamName,
  //           'odd': matches.odd,
  //         }));

  //     final newMatches = PermierLeagueItem(
  //       id: json.decode(response.body)['name'],
  //       homeTeamName: matches.homeTeamName,
  //       homeTeamCrest: matches.homeTeamCrest,
  //       awayTeamName: matches.awayTeamName,
  //       awayTeamCrest: matches.awayTeamCrest,
  //       odd: matches.odd,
  //     );
  //     list.insert(0, newMatches);
  //     notifyListeners();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

}
