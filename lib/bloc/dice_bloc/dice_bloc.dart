import 'dart:math';

import 'package:Leela/repository/repository.dart';
import 'package:Leela/widgets/field/dice_widget.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../service/request_keeper.dart';

part 'dice_event.dart';

part 'dice_state.dart';

class DiceBloc extends Bloc<DiceEvent, DiceBlocState> {
  // int _lastRandom = 0;
  // int _currentNumCell = 0;
  final Repository r;

  DiceBloc({required this.r}) : super(DiceUnthrowedState()) {
    on<InitialDiceEvent>((event, emit) {
      print('initial');
    });

    on<ThrowDiceStartEvent>((event, emit) {
      emit(DiceThrowedState(isDiceBlocked: true));
      print('dice blocked');
      //тут можно ебануть эмит, который будет блокировать нажатие пока анимация не закончится
      // emit(DiceBlockedState(currentCellNum: r.currentNumCell, diceResult: r.lastRandom));
      r.newValues = Random().nextInt(6) + 1;
      emit(DiceThrowedState(
          currentCellNum: r.currentNumCell,
          diceResult: r.lastRandom,
          isDiceBlocked: true));
      print('dice still blocked');
    });

    on<ThrowDiceEndEvent>((event, emit) {
      print('dice unlocked');
      calculateMoves();
      emit(DiceThrowedState(isDiceBlocked: false));
    });
  }

  RequestData calculateMoves() {
    if (!r.isAllowMove && r.lastRandom == 6) {
      r.allowToMove();
    }

    if (!r.isAllowMove || r.currentNumCell + r.lastRandom > 72) {
      r.newValues = 0;
    }
    // print('Была позиция ${_previousNum}, выпало $random, стало $_currentNum');
    var request = getRequestByNumber(r.currentNumCell);
    print('Открыта клетка через блок № ${r.currentNumCell}, ${request.header}');
    return request;
  }

  RequestData getRequestByNumber(int number) {
    return r.requests.firstWhere((element) => element.num == number);
  }
}
