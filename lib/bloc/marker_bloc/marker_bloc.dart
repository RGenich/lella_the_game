
import 'package:Leela/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../model/request_data.dart';

part 'marker_event.dart';

part 'marker_state.dart';

class MarkerBloc extends Bloc<MarkerEvent, MarkerState> {
  final Repository repo;

  MarkerBloc(this.repo) : super(MarkerInitialState()) {
    on<MarkerInitialEvent>((event, emit) {
      print('Инициализация маркера');
    });

    on<MarkerSizeDefiningEvent>((event, emit) {
      // var playZoneKey = repo.playZoneKey;
      var request = repo.getRequestByNumber(68);
      print('это должно вызываться после построения всех клеток');
      if (request.cellKey != null) {
        RenderBox renderBox =
            request.cellKey?.currentContext?.findRenderObject() as RenderBox;
        // RenderBox pzRenderBox = playZoneKey.currentContext?.findRenderObject() as RenderBox;
        Size size = renderBox.size;
        repo.setMarkerSize(size);
        var position = request.position;
        print('размер маркера: ${size.width}');
        emit(MarkerReadyState(
            isDestinationReach: false, position: position, size: size));
      } else
        print('CELL KEY NULL');
    });

    on<IsShouldMarkerMoveEvent>((event, emit) {
      print('Checking move route...');
      try {
        RequestData nextReq = repo.nextRequestToVisit;
        bool isDestReached = repo.destNumCell == nextReq.num;
        if (isDestReached) nextReq.isOpen = isDestReached;
        Size size = repo.markerSize;
        emit(MarkerMovingState(
            size: size,
            position: nextReq.position,
            isDestinationReach: isDestReached));
      } catch (e) {
        print('Destination reached: ');
      }
    });

    on<PlayZoneKeyDefinedEvent>((event, emit) {
      repo.playZoneKey = event.playZoneKey;
    });
  }
}
