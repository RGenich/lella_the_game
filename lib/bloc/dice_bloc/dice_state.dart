part of 'dice_bloc.dart';

class DiceBlocState{

  late int diceResult;
  late bool isDiceBlocked;
  late int currentCellNum;
  late RequestData request;

  DiceBlocState({
      this.diceResult = 1,
      this.isDiceBlocked = false,
      this.currentCellNum = 0,
      required this.request
  });

  DiceBlocState copyWith({
    int? diceResult,
    int? currentCellNum,
    bool isDiceBlocked = false,
    RequestData? request
  }) {
    return DiceBlocState(
      diceResult: diceResult ?? this.diceResult,
      currentCellNum: currentCellNum ?? this.currentCellNum,
      isDiceBlocked: isDiceBlocked,
      request: request ?? this.request
    );
  }
}