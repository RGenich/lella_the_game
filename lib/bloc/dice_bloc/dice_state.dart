part of 'dice_bloc.dart';

@immutable
abstract class DiceBlocState {
  DiceStatus diceStatus = DiceStatus();
}

class DiceStatus {
  int diceResult = 1;
  bool isDiceBlocked = false;
  int currentCellNum = 0;
}

class DiceUnthrowedState extends DiceBlocState {

}

class DiceThrowedState extends DiceBlocState {

  DiceThrowedState({int? currentCellNum, int? diceResult, bool isDiceBlocked = false})
  {

    if (diceResult != null) {
      super.diceStatus.diceResult = diceResult;
    }
    super.diceStatus.currentCellNum = currentCellNum ?? 2;
    // super.diceStatus.currentCellNum;
    super.diceStatus.isDiceBlocked = isDiceBlocked;
  }
}
