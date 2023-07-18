import 'dart:math';

import 'package:Leela/router/routes.dart';
import 'package:Leela/service/request_loader.dart';
import 'package:Leela/theme/theme.dart';
import 'package:Leela/widgets/field/transfer.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';


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
  List<Transfer> allTransfers = [
    Transfer(12, 8, TransferType.SNAKE),
    Transfer(16, 4, TransferType.SNAKE),
    Transfer(24, 7, TransferType.SNAKE),
    Transfer(29, 6, TransferType.SNAKE),
    Transfer(44, 9, TransferType.SNAKE),
    Transfer(52, 35, TransferType.SNAKE),
    Transfer(55, 3, TransferType.SNAKE),
    Transfer(61, 13, TransferType.SNAKE),
    Transfer(63, 2, TransferType.SNAKE),
    Transfer(72, 51, TransferType.SNAKE),

    Transfer(10, 23, TransferType.ARROW),
    Transfer(17, 69, TransferType.ARROW),
    Transfer(20, 32, TransferType.ARROW),
    Transfer(22, 60, TransferType.ARROW),
    Transfer(27, 41, TransferType.ARROW),
    Transfer(28, 50, TransferType.ARROW),
    Transfer(37, 66, TransferType.ARROW),
    Transfer(45, 67, TransferType.ARROW),
    Transfer(46, 62, TransferType.ARROW),
    Transfer(54, 68, TransferType.ARROW),
  ];

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

  Size _cellSize = Size(0, 0);

  Size get currentCellSize => _cellSize;

  void setCurrentCellSize(Size size) {
    _cellSize = size;
  }

  var favArray = <WordPair>[];
  int _currentPosition = 0;

  int get currentMarkerPos => _currentPosition;
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
    // allTransfers.f
    Transfer? transfer = allTransfers
        .firstWhereOrNull((element) => element.startNum == _currentPosition);

    if (transfer!=null) {
      transfer.isVisible = true;
      print('Snake! New position: ${transfer.endNum}');
      _currentPosition = transfer.endNum;
      _openedCells.add(_currentPosition);
      // notifySnakeIfReady();
    }

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
      defineCellSizeAndMarkerPosition();
      notifyListeners();
    }
  }

  void defineCellSizeAndMarkerPosition() {
    if (_isAllowMove) {
      var renderBox = _currentCell?.cellKey?.currentContext?.findRenderObject()
          as RenderBox;
      _markerPos = renderBox.localToGlobal(Offset.zero);
      _cellSize = renderBox.size;
      notifyListeners();
    }
  }

  void notifySnakeIfReady() {
    bool hasUnready = allTransfers
        .any((element) => element.startPos == null && element.endPos == null);
    if (!hasUnready) {
      // for (var snake in allSnakes) {
      //     var start = getPositionByKey(snake.startKey);
      //     snake.startPos = start;
      //     var end = getPositionByKey(snake.endCellKey);
      //     snake.endPos = end;
      // }
      notifyListeners();
    }
  }

  void rereadSnakesCellPositions() {
    for (var transferData in allTransfers) {
      transferData.endPos = getPositionByKey(transferData.endCellKey);
      transferData.startPos = getPositionByKey(transferData.startCellKey);
    }
    notifySnakeIfReady();
  }
}

Offset getPositionByKey(GlobalKey<State<StatefulWidget>>? endCellKey) {
  RenderBox cellRenderBox =
      endCellKey?.currentContext?.findRenderObject() as RenderBox;
  return cellRenderBox.localToGlobal(Offset.zero);
}

// class Pair {
//   Offset? startPos;
//   Offset? endPos;
// }
