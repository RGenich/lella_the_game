part of 'dice_bloc.dart';

class DiceBlocState{

  late int diceResult;
  late bool isDiceBlocked;
  late int destCellNum;
  late RequestData request;

  DiceBlocState({
      this.diceResult = 1,
      this.isDiceBlocked = false,
      this.destCellNum = 0,
      required this.request
  });

  DiceBlocState copyWith({
    int? diceResult,
    int? destCellNum,
    bool isDiceBlocked = false,
    RequestData? request
  }) {
    return DiceBlocState(
      diceResult: diceResult ?? this.diceResult,
      destCellNum: destCellNum ?? this.destCellNum,
      isDiceBlocked: isDiceBlocked,
      request: request ?? this.request
    );
  }
}