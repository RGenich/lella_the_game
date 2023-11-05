import 'dart:async';
import 'dart:ui';

import 'package:Leela/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../model/request_data.dart';

part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final Repository repo;
  List<RequestData> requests = [];

  RequestBloc(this.repo) : super(RequestInitialState()) {
    on<InitializingRequestsEvent>(_loadRequests);
    on<RequestCellBuiltEvent>(_savePositionsToRequest);
  }

  _loadRequests(event, emit) async {
    await Future<void>.delayed(Duration(seconds: 1));
    requests = repo.requests;
    emit(RequestLoadedState(requests: requests));
  }

  void _savePositionsToRequest(RequestCellBuiltEvent event, Emitter<RequestState> emit) {

    var requests = repo.requests;
    RenderObject? pzRenderBox = repo.playZoneKey.currentContext?.findRenderObject();
    var reqToBuild = requests.where((req) => req.cellKey!=null);

    for (var req in reqToBuild) {
      RenderBox renderBox = req.cellKey?.currentContext?.findRenderObject() as RenderBox;

      // renderBox.parent.
      // var cellKey = req.cellKey?.currentContext.widget.
      // repo.setMarkerSize(renderBox.size);
      Offset pos = renderBox.localToGlobal(Offset.zero, ancestor: pzRenderBox);
      req.position = pos;
    }
    // emit(RequestPositionDefinedState(requests: requests));
  }

}
