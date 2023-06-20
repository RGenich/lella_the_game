import 'package:Leela/leela_app.dart';
import 'package:Leela/service/request_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameCell extends StatefulWidget {
  final RequestData request;

  GameCell(RequestData this.request);

  @override
  State<GameCell> createState() => _GameCellState(request);
}

class _GameCellState extends State<GameCell> {
  final Color openedColor = Color.fromRGBO(255, 255, 255, 0);
  final Color closedColor = Color.fromRGBO(0, 0, 0, 0.5);
  Color cellColor = Color.fromRGBO(255, 255, 255, 0);
  final RequestData request;
  var cellKey = GlobalKey();

  _GameCellState(RequestData this.request) {
    request.cellKey = this.cellKey;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cellColor = request.isOpen ? openedColor : closedColor;
    var appState = context.watch<LeelaAppState>();
    var currentPosition = appState.currentPosition;

    if (request.isOpen && currentPosition == request.num) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        RenderBox cellRenderBox =
            cellKey.currentContext?.findRenderObject() as RenderBox;
        var position = cellRenderBox.localToGlobal(Offset.zero);
        appState.setMarkerPos(position);
      });
    }
    return Flexible(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
              key: cellKey,
              // height: (height - 2) / 8,
              // width: (width - 2) / 9,
              decoration: BoxDecoration(
                  border: Border.all(color: cellColor), color: cellColor),
              child: InkWell(
                  onTap: () {
                    appState.makeRecords(request);
                    setState(() {
                      request.isOpen = true;
                      cellColor = Color.fromRGBO(255, 255, 255, 0);
                    });
                    Navigator.of(context)
                        .pushNamed("/card", arguments: request);
                  },
                  child: Align(
                      child: Text(
                    // request.isOpen ? request.header : request.num.toString(),
                    constraints.maxWidth.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10.0),
                  ))));
        },
      ),
    );
  }
}
