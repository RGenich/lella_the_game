import 'package:Leela/widgets/field/marker.dart';
import 'package:Leela/leela_app.dart';
import 'package:Leela/service/request_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'field_cell.dart';
import 'transfer.dart';

class PlayZone extends StatefulWidget {

  @override
  State<PlayZone> createState() => _PlayZoneState();
}

class _PlayZoneState extends State<PlayZone> {
  var zoneKey = GlobalKey();

  _PlayZoneState();

  List<GameRow> buildRows() {
    var startPos = 64;
    var endPos = 73;
    List<GameRow> rows = [];
    for (var j = 1; j < 9; ++j) {
      var requestsOfRow = RequestsLoader.requests.getRange(startPos, endPos).toList();
      rows.add(GameRow(requestsOfRow, j % 2 == 0));
      startPos -= 9;
      endPos -= 9;
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    //Игровое поле
    return Expanded(
      child: NotificationListener<SizeChangedLayoutNotification>(
        onNotification: rebuildPositions,
        child: SizeChangedLayoutNotifier(
          child: Stack(children: [
            Snakes(),
            Container(
                key: zoneKey,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.brown)),
                child: Column(
                  children: buildRows(),
                )),
            Marker(),
          ]),
        ),
      ),
      // Pointer(),
      // ]
    );
  }

  bool rebuildPositions(notification) {
    print('size changed');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var state = Provider.of<LeelaAppState>(context, listen: false);
      state.markerNotification();
      // state.rereadSnakesCellPositions();
    });
    return true;
  }
}

class GameRow extends StatelessWidget {
  final List<RequestData> requestsOfRow;
  final bool isDirectSequence;
  List<Widget> cells = [];

  GameRow(List<RequestData> this.requestsOfRow, bool this.isDirectSequence,
      {Key? key})
      : super(key: key) {
    cells = createRowSequence(isDirectSequence);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Row(children: cells));
  }

  List<Widget> createRowSequence(bool isDirectSequence) {
    List<Widget> cells = [];
    var sequence = isDirectSequence ? requestsOfRow : requestsOfRow.reversed;
    for (var req in sequence) {
      cells.add(GameCell(req));
    }
    return cells;
  }
}
