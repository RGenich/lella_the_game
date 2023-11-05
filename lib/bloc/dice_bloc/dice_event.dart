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

class UnblockDiceEvent extends DiceEvent{
  UnblockDiceEvent();
}

class CheckTransfersAfterDiceEvent extends DiceEvent{
  CheckTransfersAfterDiceEvent();
}
