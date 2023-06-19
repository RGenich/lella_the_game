import 'package:Leela/features/field/pointer.dart';
import 'package:Leela/leela_app.dart';
import 'package:Leela/service/request_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'field_cell.dart';

class PlayZone extends StatefulWidget {
  const PlayZone(List<RequestData> this.requestsData, {super.key});

  final List<RequestData> requestsData;

  @override
  State<PlayZone> createState() => _PlayZoneState(requestsData);
}

class _PlayZoneState extends State<PlayZone> {
  var zoneKey = GlobalKey();

  // Size playZoneSize = Size(200, 100);

  List<RequestData> requestsData;

  _PlayZoneState(List<RequestData> this.requestsData);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // context.findRenderObject()?.
      var findRenderObject =
          zoneKey.currentContext?.findRenderObject() as RenderBox;
      var playZoneSize = findRenderObject.size;
      var state = Provider.of<LeelaAppState>(context, listen: false);
      state.setPlayZoneSize(playZoneSize);
    });
  }

  List<GameRow> buildRows(requests) {
    var startPos = 63;
    var endPos = 72;
    List<GameRow> rows = [];
    for (var j = 1; j < 9; ++j) {
      var requestsOfRow = requests.getRange(startPos, endPos).toList();
      var gameRow = GameRow(requestsOfRow, j % 2 == 0);

      rows.add(gameRow);
      startPos -= 9;
      endPos -= 9;
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    // final playZoneKey = context.watch<LeelaAppState>().playZoneKey;
    return Expanded(
      child: Stack(
          children: [
        Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.brown)),
            key: zoneKey,
            child: Column(
              children: buildRows(requestsData),
            )),
        Pointer(),
      ]),
    );
  }
}

class GameRow extends StatelessWidget {
  final List<RequestData> requestsOfRow;
  final bool isDirectSequence;
  List<Widget> cards = [];

  GameRow(List<RequestData> this.requestsOfRow, bool this.isDirectSequence,
      {Key? key})
      : super(key: key) {
    cards = createRowSequence(isDirectSequence);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: cards);
  }

  List<Widget> createRowSequence(bool isDirectSequence) {
    List<Widget> cells = [];
    // double cellHeight = playZoneSize.height;
    // double cellWidth = playZoneSize.width;
    var sequence = isDirectSequence ? requestsOfRow : requestsOfRow.reversed;
    for (var req in sequence) {
      cells.add(CellField(req));
    }
    return cells;
  }
}
