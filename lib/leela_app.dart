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
  final _playZoneKey = GlobalKey();
  Offset _playZonePosition = Offset.zero;
  RequestData? _currentCell;

  Size _markerSize = Size(0, 0);

  get playZoneKey => _playZoneKey;
  Size _playZoneSize = Size(50, 100);

  Size get playZoneSize => _playZoneSize;

  // var current = WordPair.random();
  var favArray = <WordPair>[];
  List<int> _diceScores = []; //Последовательность выпавших очков
  List<String> openedCells = [];
  int _currentPosition = 0;
  Set<int> _openedCells = Set();
  Offset _markerPos = Offset(0, 0);

  int get currentPosition => _currentPosition;

  Offset get currentMarkerPosition => _markerPos;
  Size get currentMarkerSize => _markerSize;

  void setMarkerPos(Offset value) {
    _markerPos = value;
    notifyListeners();
  }

  get getLastDiceScore => _diceScores.isNotEmpty ? _diceScores.last : 0;

  void getNextWords() {
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
    _currentPosition = requestData.num;
    notifyListeners();
  }

  Future<RequestData> throwDice() async {
    var random = Random().nextInt(5) + 1;
    _diceScores.add(random);
    print(
        'Была позиция $_currentPosition, выпало $random, стала ${_currentPosition + random}');
    _currentPosition += random;
    //todo: change to log
    _openedCells.add(_currentPosition);
    var request = await getRequestByNumber(_currentPosition);
    openRequest(request);
    _currentCell = request;
    defineMarkerSizeAndPosition();
    notifyListeners();
    return request;
  }

  void openRequest(RequestData request) async {
    request.isOpen = true;
    openedCells.add(request.header);
    notifyListeners();
  }

  Future<RequestData> getRequestByNumber(int number) async {
    var requests = await Requests.getRequests();
    var requestByNumber =
        requests.firstWhere((element) => element.num == number);
    return requestByNumber;
  }

  void markerNotification() {
    if (_currentCell?.cellKey?.currentContext != null) {
      defineMarkerSizeAndPosition();
      notifyListeners();
    }
  }

  defineMarkerSizeAndPosition(){
    var renderBox = _currentCell?.cellKey?.currentContext?.findRenderObject()
    as RenderBox;
    _markerPos = renderBox.localToGlobal(Offset.zero);
    _markerSize = renderBox.size;
  }
}
