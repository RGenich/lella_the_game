import 'dart:collection';
import 'dart:math';

import 'package:Leela/bloc/dice_bloc/dice_bloc.dart';
import 'package:Leela/bloc/marker_bloc/marker_bloc.dart';
import 'package:Leela/bloc/request_bloc/request_bloc.dart';
import 'package:Leela/repository/repository.dart';
import 'package:Leela/router/routes.dart';
import 'package:Leela/service/request_keeper.dart';
import 'package:Leela/theme/theme.dart';
import 'package:Leela/widgets/field/transfer.dart';
import 'package:collection/collection.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'model/request_data.dart';

class LeelaApp extends StatefulWidget {
  LeelaApp() {}

  @override
  State<LeelaApp> createState() => _LeelaAppState();
}

class _LeelaAppState extends State<LeelaApp> {
  final Repository repository = Repository();
  late final MarkerBloc markerBloc = MarkerBloc(repository: repository);
  late final RequestBloc requestBloc = RequestBloc(repository);
  late final DiceBloc diceBloc = DiceBloc(repository);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return RepositoryProvider(
      create: (context) => repository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => requestBloc..add(InitializingRequestsEvent())),
          BlocProvider(create: (context) => diceBloc..add(InitialDiceEvent())),
          BlocProvider(create: (context) => markerBloc..add(MarkerInitialEvent()))
          // BlocProvider(create: (context) => markerBloc)
        ],
        child: ChangeNotifierProvider(
          create: (context) => LeelaAppState(),
          child: MaterialApp(
            title: 'Leela',
            theme: theme,
            routes: routes,
          ),
        ),
      ),
    );
  }
}

class LeelaAppState extends ChangeNotifier {
  List<Transfer> toRemove = [
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
  int _previousNum = 0;
  Queue<int> pathForMarker = Queue();

  int get currentPosition => _currentNum;

  Queue<Offset> _markerPositionQueue = Queue();

  Offset? lastMarkerPos = null;

  // Offset? get getNextMarkerPosition {
  //   if (!_isAllowMove) return getDefaultMarkerPosition();
  //   if (_markerPositionQueue.isNotEmpty)
  //     return _markerPositionQueue.removeFirst();
  //   else
  //     return lastMarkerPos;
  // }

  void addMarkerPos(Offset position) {
    if (_markerPositionQueue.isEmpty || _markerPositionQueue.last != position)
      _markerPositionQueue.add(position);
    lastMarkerPos = position;
  }

  get getLastDiceScore => _diceScores.isNotEmpty ? _diceScores.last : 0;


  // RequestData getRequestByNumber(int number) {
  //   List<RequestData> requests = RequestsKeeper.requests;
  //   var requestByNumber =
  //       requests.firstWhere((element) => element.num == number);
  //   return requestByNumber;
  // }

  void notify() {
    notifyListeners();
  }

  // bool defineCellSize() {
  //   var renderBox = RequestsKeeper.requests.last.cellKey?.currentContext
  //       ?.findRenderObject() as RenderBox;
  //   if (_cellSize != renderBox.size) {
  //     _cellSize = renderBox.size;
  //     return true;
  //   }
  //   return false;
  // }

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

  // void checkTransfer(RequestData request) {
  //   Transfer? transfer =
  //       toRemove.firstWhereOrNull((trans) => trans.startNum == request.num);
  //
  //   if (transfer != null) {
  //     transfer.isVisible = true;
  //     print('${transfer.type}! New end position: ${transfer.endNum}');
  //     // _openedPosition = transfer.endNum;
  //     RequestData requestByNumber = getRequestByNumber(transfer.endNum);
  //     Offset? position = requestByNumber.position;
  //     if (position != null) {
  //       // requestByNumber.isOpen = true;
  //       addMarkerPos(position);
  //       _currentNum = requestByNumber.num;
  //       // openPosition();
  //     }
  //     // notifyListeners();
  //   }
  // }


  void setTransfersPosition(Offset position, int num) {
    var foundTransfer =
        toRemove.firstWhereOrNull((transfer) => transfer.startNumCell == num);
    if (foundTransfer != null) {
      foundTransfer.startPos = position;
      return;
    }
    foundTransfer =
        toRemove.firstWhereOrNull((transfer) => transfer.endCellNum == num);
    if (foundTransfer != null) {
      foundTransfer.endPos = position;
    }
  }

  // void addNewMarkerPosition() {
  //   for (var toOpen = _previousNum + 1; toOpen <= _currentNum; toOpen++) {
  //     var currentRequest = RequestsKeeper.requests
  //         .firstWhereOrNull((element) => element.num == toOpen);
  //     if (currentRequest != null &&
  //         currentRequest.position != null &&
  //         currentRequest.num != _previousNum) {
  //       addMarkerPos(currentRequest.position!);
  //     }
  //   }
  // }

  // void refreshCellPositions() {
  //   for (var req in RequestsKeeper.requests) {
  //     if (req.cellKey != null) {
  //       var newPosition = getPositionByKey(req.cellKey);
  //       req.position = newPosition;
  //       setTransfersPosition(newPosition, req.num);
  //     }
  //   }
  // }

  // Offset getDefaultMarkerPosition() {
  //   var startCell =
  //       RequestsKeeper.requests.firstWhere((element) => element.num == 68);
  //   if (startCell.cellKey?.currentContext == null) return Offset.zero;
  //   var renderBox =
  //       startCell.cellKey?.currentContext?.findRenderObject() as RenderBox;
  //   return renderBox.localToGlobal(Offset.zero);
  // }

  int throwRandom() {
    return random = Random().nextInt(6) + 1;
  }

  bool isAllCellsVisited() {
    return _markerPositionQueue.isEmpty;
  }

  // void openPosition() {
  //   getRequestByNumber(currentPosition).isOpen = true;
  //   notifyListeners();
  // }
}
