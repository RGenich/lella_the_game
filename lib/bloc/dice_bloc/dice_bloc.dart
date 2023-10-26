import 'dart:math';
import 'dart:ui';

import 'package:Leela/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import '../../service/request_keeper.dart';

part 'dice_event.dart';

part 'dice_state.dart';

class DiceBloc extends Bloc<DiceEvent, DiceBlocState> {
  final Repository r;
  static const int AFTER68 = 68;

  DiceBloc(this.r)
      : super(DiceBlocState(
            diceResult: r.lastRandom, currentCellNum: r.currentNumCell, request: r.defaultRequest)) {
    on<InitialDiceEvent>((event, emit) {
      print('initial');
      emit(state.copyWith());
    });

    on<ThrowDiceStartEvent>((event, emit) {
      // emit(state.copyWith(isDiceBlocked: true));
      print('dice blocked');
      //тут можно ебануть эмит, который будет блокировать нажатие пока анимация не закончится
      r.lastRandom = Random().nextInt(6) + 1;
      // r.addNewOpened();
      var request = calculateMoves();
      addNewMarkerPosition();
      var currentNumCell = r.currentNumCell;
      var lastRandom = r.lastRandom;
      emit(state.copyWith(
          request: request,
          currentCellNum: currentNumCell,
          diceResult: lastRandom,
          isDiceBlocked: true));
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
      return getRequestByNumber(AFTER68);
    }
    var request = getRequestByNumber(r.currentNumCell);
    print(
        'Была позиция ${r.perviousNumCell}, выпало ${r.lastRandom}, стало ${r.currentNumCell} (${request.header})');
    return request;
  }

  RequestData getRequestByNumber(int number) {
    return r.requests.firstWhere((element) => element.num == number);
  }

  void addNewMarkerPosition() {
    for (var toOpen = r.perviousNumCell + 1;
        toOpen <= r.currentNumCell;
        toOpen++) {
      var currentRequest =
          r.requests.firstWhereOrNull((element) => element.num == toOpen);
      if (currentRequest != null &&
          currentRequest.position != null &&
          currentRequest.num != r.perviousNumCell) {
        addMarkerPos(currentRequest.position!);
      }
    }
  }

  void addMarkerPos(Offset position) {
    if (r.markerQueue.isEmpty || r.markerQueue.last != position)
      r.markerQueue.add(position);
    // lastMarkerPos = position;
  }
}
