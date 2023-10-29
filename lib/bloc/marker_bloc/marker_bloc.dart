import 'dart:ui';

import 'package:Leela/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/request_data.dart';

part 'marker_event.dart';
part 'marker_state.dart';

class MarkerBloc extends Bloc<MarkerEvent, MarkerState> {
  final Repository repository;

  MarkerBloc({required this.repository}) : super(MarkerInitialState()) {

    on<MarkerInitialEvent>((event, emit) {
    print('marker init event processing');
    // var req = repository.getRequestByNumber(68);
    // if (req.position != Offset.zero)
    //   emit(MarkerInitialState(position: req.position));
  });

  on<MarkerFirstShowEvent>((event, emit) {
      print('first show processing');
      var req = repository.getRequestByNumber(68);
      // if (req.position != Offset.zero)
        emit(MarkerFirstShowState(position: req.position));
    });

    on<TimeToMoveMarkerEvent>((event, emit) {
      print('Checking move route...');
      try {
        RequestData nextReq = repository.nextRequestToVisit;
        bool isDestinationCellReached = repository.destNumCell == nextReq.num;
        emit(MarkerMovingState(
            position: nextReq.position,
            isDestinationReach: isDestinationCellReached));
      } catch (e) {
        print('No more next marker position');
      }
    });
  }
}
