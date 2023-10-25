part of 'dice_bloc.dart';

@immutable
abstract class DiceBlocState {}

class DiceUnthrowedState extends DiceBlocState {
  final int number = 0;

}

class DiceThrowedState extends DiceBlocState {
  final int currentCellNum;

  DiceThrowedState(this.currentCellNum);
}
