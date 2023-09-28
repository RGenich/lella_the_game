import 'package:Leela/leela_app.dart';
import 'package:Leela/service/request_keeper.dart';
import 'package:Leela/widgets/field/transfer.dart';
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
  TransferType? currentCellType;

  _GameCellState(RequestData this.request) {
    request.cellKey = this.cellKey;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox cellBox = cellKey.currentContext?.findRenderObject() as RenderBox;
      Size size = cellBox.size;
      var position = cellBox.localToGlobal(Offset.zero);
      request.position = position;
      var appState = context.read<LeelaAppState>();
      appState.setCurrentCellSize(size);
      appState.setTransfersPosition(position, request.num);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<LeelaAppState>();

    cellColor = request.isOpen ? openedColor : closedColor;
    // var currentCellSize = appState.currentCellSize;
    // var pathForMarker = appState.pathForMarker;
    // print(currentCellSize);
    return Flexible(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
              key: cellKey,
              decoration: BoxDecoration(
                  border: Border.all(color: cellColor), color: cellColor),
              child: InkWell(
                  onTap: () {
                    // appState.makeRecords(request);
                    // setState(() {
                    //   request.isOpen = true;
                    //   cellColor = Color.fromRGBO(255, 255, 255, 0);
                    // });
                    Navigator.of(context)
                        .pushNamed("/card", arguments: request);
                  },
                  child: Align(
                      child: Text(
                    // isDestinationCell ? "СЮДА" : "НЕТ",
                    request.isOpen ? request.header : request.num.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10.0),
                  ))));
        },
      ),
    );
  }
}
