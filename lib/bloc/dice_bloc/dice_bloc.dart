import 'package:Leela/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
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
      // r.lastRandom = Random().nextInt(6) + 1;
      repo.defineNewDestinationCell(6);
      RequestData request = calculateMarkerDestination();
      defineMarkerRoute(request);
      var currentNumCell = repo.destNumCell;
      var lastRandom = repo.diceScore;
      emit(state.copyWith(
        request: request,
        destCellNum: currentNumCell,
        diceResult: lastRandom,
        isDiceBlocked: true,
      ));
      repo.prevNumCell = currentNumCell;

      print('dice still blocked');
    });

    on<ThrowDiceEndEvent>((event, emit) {
      print('dice unlocked');
      emit(state.copyWith(isDiceBlocked: false));
    });

    on<CheckTransfersAfterDiceEvent>((event, emit) {
      if (hasTransfer()) {
        var req = repo.getRequestByNumber(repo.destNumCell);
        emit(state.copyWith(request: req,isDiceBlocked: false, destCellNum: repo.destNumCell));
      };
    });
  }

  RequestData calculateMarkerDestination() {
    if (!repo.isAllowMove && repo.destNumCell == 6) {
      repo.allowToMove();
    }
    //todo: специальные отдельные реквесты не входящие в массив для отображения специальной информации
    if (!repo.isAllowMove || repo.destNumCell + repo.diceScore > 72) {
      return repo.getRequestByNumber(AFTER68);
    }
    var request = repo.getRequestByNumber(repo.destNumCell);
    print(
        'Была позиция ${repo.prevNumCell}, выпало ${repo.destNumCell}, стало ${repo.destNumCell} (${request.header})');
    return request;
  }

  void defineMarkerRoute(RequestData toRequest) {
    for (var numToOpen = repo.prevNumCell + 1;numToOpen <= repo.destNumCell;
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

  bool hasTransfer() {
    var currentNumCell = repo.destNumCell;
    var transfer = repo.transfers
        .firstWhereOrNull((t) => t.startNumCell == currentNumCell);
    bool isTransferFound = false;

    if (transfer != null) {
      transfer.isVisible = true;
      print('Змея/Стрела ${transfer.type}! Новая конечная позиция: ${transfer.endCellNum}');
      repo.prevNumCell = transfer.endCellNum;
      repo.newDestinationNum = transfer.endCellNum;
      RequestData req = repo.getRequestByNumber(transfer.endCellNum);
      addMarkerPos(req);
      isTransferFound = true;
    }
    return isTransferFound;
  }
}
