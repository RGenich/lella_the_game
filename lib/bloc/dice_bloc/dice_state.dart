part of 'dice_bloc.dart';

@immutable
abstract class DiceState {}

class DiceUnthrowedState extends DiceState {
  final int number = 0;
}
class DiceThrowedState extends DiceState {
  final int number;

  DiceThrowedState(this.number);
}
