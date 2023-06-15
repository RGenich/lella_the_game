import 'dart:math';

import 'package:Leela/router/routes.dart';
import 'package:Leela/service/request_loader.dart';
import 'package:Leela/theme/theme.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeelaApp extends StatefulWidget {
  const LeelaApp({super.key});

  @override
  State<LeelaApp> createState() => _LeelaAppState();
}

class _LeelaAppState extends State<LeelaApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LeelaAppState(),
      child: MaterialApp(
        title: 'Leela',
        theme: theme,
        routes: routes,
      ),
    );
  }
}

class LeelaAppState extends ChangeNotifier {
  var current = WordPair.random();
  var favArray = <WordPair>[];
  List<int> _diceScores = []; //Последовательность выпавших очков
  List<String> openedCells = [];

  // int count = 0;
  // List<RequestData> _requests = List.empty(growable: true);
  int _currentPosition = 0;
  Set<int> _openedCells = Set();
  bool openingTime = false;
  //
  // Future<List<RequestData>> get loadRequests async {
  //   return loadRequest();
  //   // return _requests;
  // }

  get getLastDiceScore => _diceScores.isNotEmpty ? _diceScores.last : 0;

  void getNextWords() {
    current = WordPair.random();
    notifyListeners();
  }

  void addToFavorite(WordPair favPair) {
    if (favArray.contains(favPair)) {
      favArray.remove(favPair);
    } else {
      favArray.add(favPair);
    }
    notifyListeners();
  }

  int buildNum = 0;

  int getNextCellNumber() {
    return buildNum;
  }

//функция хранит какие отстроены клетки и
// возвращает какую надо построить следующей

  void makeRecords(RequestData requestData) {
    openedCells.add(requestData.header);
    notifyListeners();
  }

  Future<RequestData> throwDice() async{
    var random = Random().nextInt(5) + 1;
    _diceScores.add(random);
    print('Была позиция $_currentPosition, выпало $random, стала ${_currentPosition + random}');
    _currentPosition += random;
    //todo: change to log
    _openedCells.add(_currentPosition);
    var request = await getRequestByNumber(_currentPosition);
    openRequest(request);
    notifyListeners();
    return request;
  }

  void openRequest(RequestData request) async {
    // if (currentPosition > 0) {
      // var requests = await Requests.getRequests();
      // var reqToOpen = requests.firstWhere((element) => element.num == currentPosition);
      request.isOpen = true;
      openedCells.add(request.header);
      notifyListeners();
      // return reqToOpen;
    // }
  }

  Future<RequestData> getRequestByNumber(int number) async {
    var requests = await Requests.getRequests();
    var requestByNumber = requests.firstWhere((element) => element.num == number);
    return requestByNumber;
  }

  void markOpenTime() {
    openingTime = true;
    notifyListeners();
  }
}
