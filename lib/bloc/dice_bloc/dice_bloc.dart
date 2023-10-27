import 'dart:math';
import 'dart:ui';

import 'package:Leela/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/request_data.dart';

part 'dice_event.dart';

part 'dice_state.dart';

class DiceBloc extends Bloc<DiceEvent, DiceBlocState> {
  final Repository r;
  static const int AFTER68 = 68;

  DiceBloc(this.r)
      : super(DiceBlocState(diceResult: r.lastRandom, request: r.defaultRequest)) {
    on<InitialDiceEvent>((event, emit) {
      print('initial');
      emit(state.copyWith());
    });

    on<ThrowDiceStartEvent>((event, emit) {
      // emit(state.copyWith(isDiceBlocked: true));
      print('dice blocked');
      // r.lastRandom = Random().nextInt(6) + 1;
      r.lastRandom = 6;
      // r.addNewOpened();
      RequestData request = calculateMoves();
      defineMarkerRoute(request);
      var currentNumCell = r.currentNumCell;
      var lastRandom = r.lastRandom;
      emit(state.copyWith(
          request: request,
          currentCellNum: currentNumCell,
          diceResult: lastRandom,
          isDiceBlocked: true,
      ));

      print('dice still blocked');
    });

    on<ThrowDiceEndEvent>((event, emit) {
      print('dice unlocked');
      emit(state.copyWith(isDiceBlocked: false));
    });
  }

  RequestData calculateMoves() {
    if (!r.isAllowMove && r.lastRandom == 6) {
      r.allowToMove();
    }
    //todo: специальные отдельные реквесты не входящие в массив для отображения специальной информации
    if (!r.isAllowMove || r.currentNumCell + r.lastRandom > 72) {
      return r.getRequestByNumber(AFTER68);
    }
    var request = r.getRequestByNumber(r.currentNumCell);
    print('Была позиция ${r.previousNumCell}, выпало ${r.lastRandom}, стало ${r.currentNumCell} (${request.header})');
    return request;
  }


  void defineMarkerRoute(RequestData toRequest) {

    for (var numToOpen = r.previousNumCell + 1; numToOpen <= r.currentNumCell; numToOpen++) {
      var requestToVisit = r.getRequestByNumber(numToOpen);
      // if (requestToVisit.position != null) {
        addMarkerPos(requestToVisit.position);
      // }
    }
  }

  void addMarkerPos(Offset position) {
    if (r.markerQueue.isEmpty || r.markerQueue.last != position)
      r.markerQueue.add(position);
    // lastMarkerPos = position;
  }
}

