part of 'dice_bloc.dart';

@immutable
abstract class DiceEvent {
}

class InitialDiceEvent extends DiceEvent {
  InitialDiceEvent();
}

class ThrowDiceStartEvent extends DiceEvent {
  ThrowDiceStartEvent();
}

class ThrowDiceEndEvent extends DiceEvent{
  ThrowDiceEndEvent();
}

class CheckTransfersAfterDiceEvent extends DiceEvent{
  CheckTransfersAfterDiceEvent();
}
