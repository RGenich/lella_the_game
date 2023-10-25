part of 'dice_bloc.dart';

@immutable
abstract class DiceEvent extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class InitialDiceEvent extends DiceEvent {
  InitialDiceEvent();

}

class ThrowDiceEvent extends DiceEvent {
  void blabla() {print('a');}
  ThrowDiceEvent();
}

