import 'dart:async';
import 'dart:convert';

import 'package:Leela/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../model/request_data.dart';

part 'request_event.dart';

part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final Repository repo;

  RequestBloc(this.repo) : super(RequestInitialState()) {
    on<InitializingRequestsEvent>(_loadRequests);
    on<RequestCellBuiltEvent>(_setPositionsToRequest);
    on<RebuildCellsEvent>((event, emit) => emit(RequestLoadedState(requests: repo.requests)));
    on<RebuildOneCellEvent>((event, emit) => emit(RequestReloadCellState(keyNum: repo.destNumCell)));
  }

  _loadRequests(event, emit) async {
    await Future<void>.delayed(Duration(seconds: 1));
    final String jsonString =
        await rootBundle.loadString('assets/requests.json');
    List<dynamic> data = await jsonDecode(jsonString);
    List<RequestData> requests = data
        .map((e) => RequestData(
            e['header'], e['asset_name'], e['description'], e['num']))
        .toList();
    repo.setRequest(requests);
    emit(RequestLoadedState(requests: repo.requests));
  }

  void _setPositionsToRequest(RequestCellBuiltEvent event, Emitter<RequestState> emit) {
    var requests = repo.requests;
    RenderObject? pzRenderBox =
        repo.playZoneKey.currentContext?.findRenderObject();
    var reqToBuild = requests.where((req) => req.cellKey != null);

    for (var req in reqToBuild) {
      var renderBox = req.cellKey?.currentContext?.findRenderObject() as RenderBox;
      Offset pos = renderBox.localToGlobal(Offset.zero, ancestor: pzRenderBox);
      req.position = pos;
      req.size = renderBox.size;
    }
    // emit(RequestLoadedState(requests: repo.requests));
  }
}


