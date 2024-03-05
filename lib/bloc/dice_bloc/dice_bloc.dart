import 'dart:math';

import 'package:Leela/model/ovelay_step.dart';
import 'package:Leela/repository/repository.dart';
import 'package:Leela/widgets/field/transfer.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../model/request_data.dart';

part 'dice_event.dart';

part 'dice_state.dart';

class DiceBloc extends Bloc<DiceEvent, DiceBlocState> {
  final Repository repo;
  static const int AFTER68 = 68;

  DiceBloc(this.repo)
      : super(DiceBlocState(
            diceResult: repo.diceScore, request: repo.defaultRequest)) {
    on<InitialDiceEvent>((event, emit) {
      emit(state.copyWith());
    });

    on<ThrowDiceStartEvent>((event, emit) {
      print('dice blocked');
      var random = Random().nextInt(6) + 1;
      var diceBlocState = state;
      if (random == 6) {
        repo.defineNewDestinationCell(random);
        RequestData request = calculateMarkerDestinationRequest();
        repo.addTrace(
            new OverlayStep(header: request.header, stepType: StepType.USUAL));
        defineMarkerRoute(request);
        var currentNumCell = repo.destNumCell;
        var lastRandom = repo.diceScore;

        emit(diceBlocState.copyWith(
          request: request,
          destCellNum: currentNumCell,
          diceResult: lastRandom,
          isDiceBlocked: true,
        ));
        repo.prevNumCell = currentNumCell;
        print('dice still blocked');
      } else {
        emit(diceBlocState.copyWith(
          request: repo.getRequestByNumber(-1),
          destCellNum: 68,
          diceResult: random,
          isDiceBlocked: false,
        ));
      }
    });

    on<CheckTransfersAfterDiceEvent>((event, emit) {
      var transfer = findTransfer();
      if (transfer != null) {
        transfer.isVisible = true;
        print('Змея/Стрела ${transfer.type}! Конечная позиция: ${transfer.endCellNum}');
        repo.prevNumCell = transfer.endCellNum;
        repo.newDestinationNum = transfer.endCellNum;
        RequestData req = repo.getRequestByNumber(transfer.endCellNum);
        addMarkerPos(req);
        var request = repo.getRequestByNumber(repo.destNumCell);
        repo.addTrace(OverlayStep(
            header: request.header,
            stepType: transfer.type == TransferType.SNAKE
                ? StepType.SNAKE
                : StepType.ARROW));
        emit(state.copyWith(
            request: request,
            isDiceBlocked: true,
            destCellNum: repo.destNumCell));
      } else {
        print('Unblocking of dice...');
        emit(state.copyWith(isDiceBlocked: false));
      }
    });
  }

  RequestData calculateMarkerDestinationRequest() {
    // if (!repo.isAllowMove && repo.destNumCell == 6) {
    //   repo.allowToMove();
    // }
    // //todo: специальные отдельные реквесты не входящие в массив для отображения специальной информации
    // if (!repo.isAllowMove || repo.destNumCell + repo.diceScore > 72) {
    //   var notStartRequest = repo.getRequestByNumber(AFTER68);
    //   // var notStartRequest = repo.getRequestByNumber(-1);
    //   // notStartRequest.position = repo.getRequestByNumber(AFTER68).position;
    //   return notStartRequest;
    // }
    var request = repo.getRequestByNumber(repo.destNumCell);

    print(
        'Была позиция ${repo.prevNumCell}, выпало ${repo.destNumCell}, стало ${repo.destNumCell} (${request.header})');
    return request;
  }

  void defineMarkerRoute(RequestData toRequest) {
    for (var numToOpen = repo.prevNumCell + 1;
        numToOpen <= repo.destNumCell;
        numToOpen++) {
      var requestToVisit = repo.getRequestByNumber(numToOpen);
      // if (requestToVisit.position != null) {
      addMarkerPos(requestToVisit);
      // }
    }
  }

  void addMarkerPos(RequestData request) {
    if (repo.markerQueue.isEmpty || repo.markerQueue.last != request)
      repo.markerQueue.add(request);
    // lastMarkerPos = position;
  }

  Transfer? findTransfer() {
    var currentNumCell = repo.destNumCell;
    return repo.transfers
        .firstWhereOrNull((t) => t.startNumCell == currentNumCell);
  }
}
