import 'dart:ui';

import 'package:Leela/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/request_data.dart';

part 'marker_event.dart';

part 'marker_state.dart';

class MarkerBloc extends Bloc<MarkerEvent, MarkerState> {
  final Repository repo;

  MarkerBloc(this.repo) : super(MarkerInitialState()) {
    on<MarkerInitialEvent>((event, emit) {
      print('marker init event processing');
      // var req = repository.getRequestByNumber(68);
      // if (req.position != Offset.zero)
      //   emit(MarkerInitialState(position: req.position));
    });

    on<MarkerSizeDefinedEvent>((event, emit) {
      repo.setMarkerSize(event.size);
    });

    on<MarkerFirstShowEvent>((event, emit) {
      print('first show processing');
      var req = repo.getRequestByNumber(68);
      var size = repo.markerSize;
      // if (req.position != Offset.zero)
      emit(MarkerFirstShowState(position: req.position, size: size));
    });

    on<TimeToMoveMarkerEvent>((event, emit) {
      print('Checking move route...');
      try {
        RequestData nextReq = repo.nextRequestToVisit;
        bool isDestReached = repo.destNumCell == nextReq.num;
        if (isDestReached)
          nextReq.isOpen = isDestReached;
        Size size = repo.markerSize;
        emit(MarkerMovingState(
            size: size,
            position: nextReq.position,
            isDestinationReach: isDestReached));
      } catch (e) {
        print('Destination reached: ');
      }
    });
  }
}
