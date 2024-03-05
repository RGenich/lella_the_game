import 'package:Leela/bloc/marker_bloc/marker_bloc.dart';
import 'package:Leela/bloc/request_bloc/request_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/request_data.dart';
import 'field_cell.dart';

class MainField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestBloc, RequestState>(builder: (context, state) {

      if (state is RequestInitialState)
        return CircularProgressIndicator(color: Colors.cyan);
      else {
        List<GameRow> rowsWithCell = buildRows(state.requests);
        context.read<RequestBloc>()..add(RequestCellBuiltEvent());
        context.read<MarkerBloc>()..add(MarkerSizeDefiningEvent());

        return Column(
          children: rowsWithCell,
        );
      }
    }
        );
  }
}

List<GameRow> buildRows(List<RequestData> requests) {
  var startPos = 65;
  var endPos = 74;
  List<GameRow> rows = [];
  for (var j = 1; j < 9; ++j) {
    var requestsOfRow = requests.getRange(startPos, endPos).toList();
    // RequestsKeeper.requests.getRange(startPos, endPos).toList();
    rows.add(GameRow(requestsOfRow, j % 2 == 0));
    startPos -= 9;
    endPos -= 9;
  }
  return rows;
}

class GameRow extends StatelessWidget {
  final List<RequestData> requestsOfRow;
  final bool isDirectSequence;
  late final List<Widget> cells;

  //TODO: delete this keys?
  GameRow(List<RequestData> this.requestsOfRow, bool this.isDirectSequence) {
    cells = createCellSequence(isDirectSequence);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Row(children: cells));
  }

  List<Widget> createCellSequence(bool isDirectSequence) {
    List<Widget> cells = [];
    //TODO: переместить направление последовательности в этот метод?
    var sequence = isDirectSequence ? requestsOfRow : requestsOfRow.reversed;
    for (var req in sequence) {
      cells.add(GameCell(req));
    }
    return cells;
  }
}
