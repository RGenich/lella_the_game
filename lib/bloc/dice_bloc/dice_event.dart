part of 'dice_bloc.dart';

@immutable
abstract class DiceEvent {


}

class InitialDiceEvent extends DiceEvent {
  InitialDiceEvent();

}

class ThrowDiceEvent extends DiceEvent {

  void blabla() {print('throwed thrue bloc');}

  ThrowDiceEvent();
}

