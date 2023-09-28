import 'dart:collection';
import 'dart:math';

import 'package:Leela/router/routes.dart';
import 'package:Leela/service/request_keeper.dart';
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

  // Offset _directPosition = Offset.zero;

  // get directPosition => _directPosition;
  // final _playZoneKey = GlobalKey();
  //
  // get playZoneKey => _playZoneKey;
  // Size _playZoneSize = Size(50, 100);
  //
  // Size get playZoneSize => _playZoneSize;
  bool _isAllowMove = false;

  //Последовательность выпавших очков
  List<int> _diceScores = [];

  // Queue<RequestData> _currentCells = Queue();

  Size _cellSize = Size(0, 0);

  Size get currentCellSize => _cellSize;

  void setCurrentCellSize(Size size) {
    _cellSize = size;
  }

  var favArray = <WordPair>[];
  int _currentNum = 0;
  Queue<int> pathForMarker = Queue();

  int get currentPosition => _currentNum;

  Queue<Offset> _markerPositionQueue = Queue();

  Offset? lastMarkerPos = null;

  Offset? get getNextMarkerPosition {
    if (!_isAllowMove) return getDefaultMarkerPosition();
    if (_markerPositionQueue.isNotEmpty)
      return _markerPositionQueue.removeFirst();
    else
      return lastMarkerPos;
  }

  void addMarkerPos(Offset position) {
    if (_markerPositionQueue.isEmpty || _markerPositionQueue.last != position)
      _markerPositionQueue.add(position);
    lastMarkerPos = position;
  }

  get getLastDiceScore => _diceScores.isNotEmpty ? _diceScores.last : 0;

//функция хранит какие отстроены клетки и
// возвращает какую надо построить следующей

  void makeRecords(RequestData requestData) {
    // openedCells.add(requestData.header);
    _currentNum = requestData.num;
    notifyListeners();
  }

  RequestData throwDice() {
    var random = Random().nextInt(6) + 1;
    //TODO: return only for six?
    if (!_isAllowMove && random == 6) {
    _isAllowMove = true;
    }
    print('Была позиция $_currentNum, выпало $random');

    if (!_isAllowMove) random = 0;
    if (_currentNum + random <= 72) {
      _currentNum += random;

      var request = getRequestByNumber(_currentNum);
      request.isOpen = true;
      print('Открыта клетка № $_currentNum, ${request.header}');
      Offset? position = request.position;
      if (position != null) addMarkerPos(position);
      checkTransfer(request);
      return request;
    } else {
      print('Нужно кидать пока не выпадет 72');
      return getRequestByNumber(-1);
    }
  }

  RequestData getRequestByNumber(int number) {
    List<RequestData> requests = RequestsKeeper.requests;
    var requestByNumber =
        requests.firstWhere((element) => element.num == number);
    return requestByNumber;
  }

  void notify() {
    notifyListeners();
  }

  bool defineCellSize() {
    var renderBox = RequestsKeeper.requests.last.cellKey?.currentContext
        ?.findRenderObject() as RenderBox;
    if (_cellSize != renderBox.size) {
      _cellSize = renderBox.size;
      return true;
    }
    return false;
  }

  void notifySnakeIfReady() {
    // bool hasUnready = allTransfers
    //     .any((element) => element.startPos == null && element.endPos == null);
    // if (!hasUnready) {
    notifyListeners();
    // }
  }

  checkUnvisitedMarkerPositions() {
    print('marker position checking');
    if (_markerPositionQueue.isNotEmpty) {
      notifyListeners();
    }
  }

  void checkTransfer(RequestData request) {
    Transfer? transfer =
        allTransfers.firstWhereOrNull((trans) => trans.startNum == request.num);

    if (transfer != null) {
      transfer.isVisible = true;
      print('${transfer.type}! New end position: ${transfer.endNum}');
      // _openedPosition = transfer.endNum;
      RequestData requestByNumber = getRequestByNumber(transfer.endNum);
      Offset? position = requestByNumber.position;
      if (position != null) {
        addMarkerPos(position);
        _currentNum = requestByNumber.num;
      }
      // notifyListeners();
    }
  }

  Offset getPositionByKey(GlobalKey<State<StatefulWidget>>? cellKey) {
    RenderBox cellRenderBox =
        cellKey?.currentContext?.findRenderObject() as RenderBox;
    return cellRenderBox.localToGlobal(Offset.zero);
  }

  void setTransfersPosition(Offset position, int num) {
    var foundTransfer =
        allTransfers.firstWhereOrNull((transfer) => transfer.startNum == num);
    if (foundTransfer != null) {
      foundTransfer.startPos = position;
      return;
    }
    foundTransfer =
        allTransfers.firstWhereOrNull((transfer) => transfer.endNum == num);
    if (foundTransfer != null) {
      foundTransfer.endPos = position;
    }
  }

  void defineMarkerPosition() {
    var currentRequest = RequestsKeeper.requests
        .firstWhereOrNull((element) => element.num == _currentNum);
    if (currentRequest != null && currentRequest.position != null) {
      addMarkerPos(currentRequest.position!);
    }
  }

  void refreshCellPositions() {
    for (var req in RequestsKeeper.requests) {
      if (req.cellKey != null) {
        var newPosition = getPositionByKey(req.cellKey);
        req.position = newPosition;
        setTransfersPosition(newPosition, req.num);
      }
    }
  }

  Offset getDefaultMarkerPosition() {
    var startCell =
        RequestsKeeper.requests.firstWhere((element) => element.num == 68);
    if (startCell.cellKey?.currentContext == null) return Offset.zero;
    var renderBox =
        startCell.cellKey?.currentContext?.findRenderObject() as RenderBox;
    return renderBox.localToGlobal(Offset.zero);
  }
}
