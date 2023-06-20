import 'package:Leela/features/field/marker.dart';
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
  }

  List<GameRow> buildRows(requests) {
    var startPos = 63;
    var endPos = 72;
    List<GameRow> rows = [];
    for (var j = 1; j < 9; ++j) {
      var requestsOfRow = requests.getRange(startPos, endPos).toList();
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
      // child: Stack(children: [
      child: NotificationListener<SizeChangedLayoutNotification>(
        onNotification: makeSomeStuff,
        child: SizeChangedLayoutNotifier(
          child: Stack(children: [

            Marker(),
            Container(
                key: zoneKey,
                decoration: BoxDecoration(border: Border.all(color: Colors.brown)),
                child: Column(
                  children: buildRows(requestsData),
                )),

          ]),
        ),
      ),
      // Pointer(),
      // ]
    );
  }

  bool makeSomeStuff(notification) {
    print('size changed');
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   print("CHANGED!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    //   var renderObj = zoneKey.currentContext?.findRenderObject() as RenderBox;
    //   var newSize = renderObj.size;
    //   var newPosition = renderObj.localToGlobal(Offset.zero);
    WidgetsBinding.instance.addPostFrameCallback((_){
      var state = Provider.of<LeelaAppState>(context, listen: false);
      state.moveMarkerNotification();

      // Add Your Code here.

    });

    // });
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
    // double cellHeight = playZoneSize.height;
    // double cellWidth = playZoneSize.width;
    var sequence = isDirectSequence ? requestsOfRow : requestsOfRow.reversed;
    for (var req in sequence) {
      cells.add(GameCell(req));
    }
    return cells;
  }
}
