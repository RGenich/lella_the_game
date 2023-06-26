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
  Offset _startSnakePosition = Offset.zero;

  get startSnakePos => _startSnakePosition;

  Offset _endSnakePosition = Offset.zero;

  get endSnakePos => _endSnakePosition;

  Offset _directPosition = Offset.zero;

  get directPosition => _directPosition;

  final _playZoneKey = GlobalKey();

  get playZoneKey => _playZoneKey;
  Size _playZoneSize = Size(50, 100);

  Size get playZoneSize => _playZoneSize;

  bool _isAllowMove = false;

  //Последовательность выпавших очков
  List<int> _diceScores = [];
  List<String> openedCells = [];

  RequestData? _currentCell;

  Size _markerSize = Size(0, 0);

  Size get currentMarkerSize => _markerSize;

  var favArray = <WordPair>[];

  int _currentPosition = 0;

  int get currentPosition => _currentPosition;

  Set<int> _openedCells = Set();
  Offset _markerPos = Offset(0, 0);

  Offset get currentMarkerPosition => _markerPos;

  void setMarkerPos(Offset value) {
    _markerPos = value;
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

//функция хранит какие отстроены клетки и
// возвращает какую надо построить следующей

  void makeRecords(RequestData requestData) {
    openedCells.add(requestData.header);
    _currentPosition = requestData.num;
    notifyListeners();
  }

  Future<RequestData> throwDice() async {
    var random = Random().nextInt(6) + 1;
    _diceScores.add(random);
    if (!_isAllowMove && random == 6) {
      _isAllowMove = true;
    }
    print('Была позиция $_currentPosition, выпало $random');

    if (!_isAllowMove) random = 0;

    _currentPosition += random;
    print('Новая позиция $_currentPosition');
    _openedCells.add(_currentPosition);
    var request = await getRequestByNumber(_currentPosition);
    openRequest(request);
    _currentCell = request;
    // defineMarkerSizeAndPosition();
    notifyListeners();
    return request;
  }

  void openRequest(RequestData request) async {
    request.isOpen = true;
    openedCells.add(request.header);
    notifyListeners();
  }

  Future<RequestData> getRequestByNumber(int number) async {
    var requests = await RequestsLoader.getRequests();
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

  void defineMarkerSizeAndPosition() {
    var renderBox =
        _currentCell?.cellKey?.currentContext?.findRenderObject() as RenderBox;
    _markerPos = renderBox.localToGlobal(Offset.zero);
    _markerSize = renderBox.size;
    notifyListeners();
  }

  void addStartSnakePosition(Offset position) {
    _startSnakePosition = position;
    if (allPositionSet()) notifyListeners();
  }

  void addEndSnakePosition(Offset position) {
    _endSnakePosition = position;
    if (allPositionSet()) notifyListeners();
  }

  bool allPositionSet() {
    return _startSnakePosition != Offset.zero &&
        _endSnakePosition != Offset.zero;
  }

  void snakeNotification() {
    _startSnakePosition =

  }
}
