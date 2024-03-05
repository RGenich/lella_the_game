import 'dart:collection';

import 'package:flutter/material.dart';

import '../model/ovelay_step.dart';
import '../model/request_data.dart';
import '../widgets/field/transfer.dart';

class Repository {
  late final List<RequestData> _requests;

  final List<Transfer> _allTransfers = [
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
  List<OverlayStep> _traces = [
    OverlayStep(header: 'Космическое сознание', stepType: StepType.START)
  ];
  int _destNumCell = 68;
  int _prevNumCell = 0;

  final Queue<RequestData> _markerRoute = Queue();
  int _lastRandomNum = 0;
  bool _isAllowMove = false;
  Size _markerSize = Size(333, 333);
  late GlobalKey _playZoneKey;

  List<RequestData> get requests => _requests;

  List<Transfer> get transfers => _allTransfers;

  bool get isAllowMove => _isAllowMove;

  int get diceScore => _lastRandomNum;

  int get destNumCell => _destNumCell;

  int get prevNumCell => _prevNumCell;

  Size get markerSize => _markerSize;

  Queue get markerQueue => _markerRoute;

  RequestData get defaultRequest => RequestData('Бросай, пока не выпадет 6',
      'not_start', 'Бросай, пока не выпадет 6', -1);

  RequestData get nextRequestToVisit => _markerRoute.removeFirst();

  RequestData get lastRequest => getRequestByNumber(_destNumCell);

  GlobalKey get playZoneKey => _playZoneKey;

  List<OverlayStep> get traces => _traces;

  List<RequestData> setRequest(List<RequestData> requests) =>
      _requests = requests;

  void addTrace(OverlayStep step) => _traces.add(step);

  set playZoneKey(GlobalKey playZoneKey) => _playZoneKey = playZoneKey;

  set prevNumCell(int newPrevious) => _prevNumCell = newPrevious;

  set newDestinationNum(int num) => _destNumCell = num;

  void allowToMove() {
    _isAllowMove = true;
  }

  void defineNewDestinationCell(int newScore) {
    _lastRandomNum = newScore;
    newDestinationNum = _prevNumCell + newScore;
  }

  RequestData getRequestByNumber(int num) {
    return requests.firstWhere((element) => element.num == num);
  }

  RequestData getLastRequest() {
    return getRequestByNumber(_prevNumCell == 0 ? 68 : _prevNumCell);
  }

  void setMarkerSize(Size size) {
    _markerSize = size;
  }
}
