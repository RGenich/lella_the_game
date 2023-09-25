import 'dart:collection';
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
  Queue<RequestData> _currentCells = Queue();

  Size _cellSize = Size(0, 0);

  Size get currentCellSize => _cellSize;

  void setCurrentCellSize(Size size) {
    _cellSize = size;
  }

  var favArray = <WordPair>[];
  int _openedPosition = 0;
  Queue<int> pathForMarker = Queue();

  int get currentOpenPosition => _openedPosition;
  Queue<Offset> _markerPositionQueue = Queue();

  Offset? get getNextMarkerPosition {
    if (_markerPositionQueue.isNotEmpty)
      return _markerPositionQueue.removeFirst();
    else return null;
  }

  void addMarkerPos(Offset value) {
    _markerPositionQueue.add(value);
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
    // openedCells.add(requestData.header);
    _openedPosition = requestData.num;
    notifyListeners();
  }

  RequestData throwDice() {
    var random = Random().nextInt(6) + 1;
    // _diceScores.add(random);
    //TODO: return only for six?
    // if (!_isAllowMove && random == 6) {
    _isAllowMove = true;
    // }
    print('Была позиция $_openedPosition, выпало $random');

    if (!_isAllowMove) random = 0;
    _openedPosition += random;

    print('Открыта клетка № $_openedPosition');
    var request = getRequestByNumber(_openedPosition);
    Offset? position = request.position;
    if (position != null) addMarkerPos(position);
    // defineMarkerSizeAndPosition();
    checkTransfer(request);
    // notifyListeners();
    return request;
  }

  void openRequest(RequestData request) {
    request.isOpen = true;
    // openedCells.add(request.header);
    notifyListeners();
  }

  RequestData getRequestByNumber(int number) {
    List<RequestData> requests = RequestsLoader.requests;
    var requestByNumber =
        requests.firstWhere((element) => element.num == number);
    return requestByNumber;
  }

  void markerNotification() {
    notifyListeners();
  //   if (_markerPositionQueue.isNotEmpty) notifyListeners();
    // if (_currentCells.isNotEmpty &&
    //     _currentCells.first.cellKey?.currentContext != null) {
    //   defineCellSizeAndMarkerPosition();
  }

void defineCellSizeAndMarkerPosition() {
  while (_isAllowMove && _currentCells.isNotEmpty) {
    var renderBox = _currentCells
        .removeFirst()
        .cellKey
        ?.currentContext
        ?.findRenderObject() as RenderBox;
    _markerPositionQueue.add(renderBox.localToGlobal(Offset.zero));
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

// void rereadSnakesCellPositions() {
//   for (var transferData in allTransfers) {
//     transferData.endPos = getPositionByKey(transferData.endCellKey);
//     transferData.startPos = getPositionByKey(transferData.startCellKey);
//   }
//   notifySnakeIfReady();
// }

  checkUnvisitedMarkerPositions() {
    print('more marker position cheking');
    if (_markerPositionQueue.isNotEmpty) {
      notifyListeners();
    }
  }

  void checkTransfer(RequestData request) {
    Transfer? transfer =
        allTransfers.firstWhereOrNull((trans) => trans.startNum == request.num);

    if (transfer != null) {
      transfer.isVisible = true;
      print('Snake! New end position: ${transfer.endNum}');
      // _openedPosition = transfer.endNum;
      RequestData requestByNumber = getRequestByNumber(transfer.endNum);
      Offset? position = requestByNumber.position;
      if (position != null) {
        addMarkerPos(position);
        _openedPosition = requestByNumber.num;
      }
      // notifyListeners();
    }
  }

  Offset getPositionByKey(GlobalKey<State<StatefulWidget>>? endCellKey) {
    RenderBox cellRenderBox =
        endCellKey?.currentContext?.findRenderObject() as RenderBox;
    return cellRenderBox.localToGlobal(Offset.zero);
  }

  void setTransfersPosition(Offset position, int num) {
    var foundTransfer = allTransfers.firstWhereOrNull((transfer) => transfer.startNum == num);
    if (foundTransfer!=null) {
      foundTransfer.startPos = position;
      return;
    }
    foundTransfer = allTransfers.firstWhereOrNull((transfer) => transfer.endNum == num);
    if (foundTransfer!=null) {
      foundTransfer.endPos = position;
    }
  }
// class Pair {
//   Offset? startPos;
//   Offset? endPos;
// }
}
