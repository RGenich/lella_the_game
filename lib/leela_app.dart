import 'dart:collection';
import 'dart:math';

import 'package:Leela/router/routes.dart';
import 'package:Leela/service/request_keeper.dart';
import 'package:Leela/theme/theme.dart';
import 'package:Leela/widgets/field/transfer.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);;
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
    Transfer(12, 8, TransferType.SNAKE),//1
    Transfer(16, 4, TransferType.SNAKE),//2
    Transfer(24, 7, TransferType.SNAKE),//3
    Transfer(29, 6, TransferType.SNAKE),//5
    Transfer(44, 9, TransferType.SNAKE),//6
    Transfer(52, 35, TransferType.SNAKE),//8
    Transfer(55, 3, TransferType.SNAKE),//7
    Transfer(61, 13, TransferType.SNAKE),//9
    Transfer(63, 2, TransferType.SNAKE), //4
    Transfer(72, 51, TransferType.SNAKE), //10

    Transfer(10, 23, TransferType.ARROW), //1
    Transfer(17, 69, TransferType.ARROW), //2
    Transfer(20, 32, TransferType.ARROW), //3
    Transfer(22, 60, TransferType.ARROW), //4
    Transfer(27, 41, TransferType.ARROW), //5
    Transfer(28, 50, TransferType.ARROW), //6
    Transfer(37, 66, TransferType.ARROW), //7
    Transfer(45, 67, TransferType.ARROW), //8
    Transfer(46, 62, TransferType.ARROW), //9
    Transfer(54, 68, TransferType.ARROW),

    ///////////////REAL

    // Transfer(1, 64, TransferType.ARROW),
    // Transfer(55, 61, TransferType.ARROW),
    // Transfer(46, 3, TransferType.ARROW),
    // Transfer(9, 4, TransferType.ARROW),
  ];

  bool _isAllowMove = false;
  int random = 0;

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

  RequestData checkMovies() {
    // random = Random().nextInt(6) + 1;
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
      // checkTransfer(request);
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
        requestByNumber.isOpen = true;
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

  int throwRandom() {
    return random = Random().nextInt(6) + 1;
  }
}
