part of 'dice_bloc.dart';

@immutable
abstract class DiceBlocState {
  int number = 0;
}

class DiceUnthrowedState extends DiceBlocState {

}

class DiceThrowedState extends DiceBlocState {
  final int currentCellNum;

  DiceThrowedState(this.currentCellNum, diceResult)
  {
    super.number = diceResult;
  }
}
