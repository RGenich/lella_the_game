import 'dart:ui';

import 'package:Leela/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'marker_event.dart';
part 'marker_state.dart';

class MarkerBloc extends Bloc<MarkerEvent, MarkerState> {
  final Repository repository;

  MarkerBloc({required this.repository}) : super(MarkerInitialState()) {

    on<MarkerInitialEvent> ((event, emit ) {
      emit(MarkerInitialState());
    });


    on<TimeToMoveMarkerEvent>((event, emit) {
      print('time to move');
      try {
        Offset nextPosition = repository.getNextPosition;
        emit(MarkerMovingState(position: nextPosition));
      } catch (e) {
        print('no next marker position');
      }
    });
  }
}
