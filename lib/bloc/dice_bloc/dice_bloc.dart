import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dice_event.dart';
part 'dice_state.dart';

class DiceBloc extends Bloc<DiceEvent, DiceState> {
  DiceBloc() : super(DiceUnthrowedState()) {
    on<ThrowDiceEvent>((event, emit) {
      emit(DiceThrowedState(6));
    });
  }
}
