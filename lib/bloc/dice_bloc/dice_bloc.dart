import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'dice_event.dart';
part 'dice_state.dart';

class DiceBloc extends Bloc<DiceEvent, DiceBlocState> {
  int _lastRandom = 0;
  int _currentCell = 0;

  DiceBloc() : super(DiceUnthrowedState()) {

    on<InitialDiceEvent> ((event, emit) {
      print('initial');
    });

    on<ThrowDiceEvent>((event, emit) {
      //тут можно ебануть эмит, который будет блокировать нажатие пока анимация не закончится
      event.blabla();
      throwDice();
      emit(DiceThrowedState(_currentCell));
    });
  }


  throwDice() {
     _lastRandom = Random().nextInt(6) + 1;
     _currentCell+=_lastRandom;
  }
}
