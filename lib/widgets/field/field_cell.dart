import 'package:Leela/leela_app.dart';
import 'package:Leela/service/request_loader.dart';
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
      RenderBox cell = cellKey.currentContext?.findRenderObject() as RenderBox;
      Size size = cell.size;
      var appState = context.read<LeelaAppState>();
      appState.setCurrentCellSize(size);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cellColor = request.isOpen ? openedColor : closedColor;
    var appState = context.read<LeelaAppState>();
    var currentPosition = appState.currentMarkerPos;
    if (request.isOpen && currentPosition == request.num) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        RenderBox cellRenderBox =
            cellKey.currentContext?.findRenderObject() as RenderBox;
        var position = cellRenderBox.localToGlobal(Offset.zero);
        appState.setMarkerPos(position);
      });
    }

    for (var transferData in appState.allTransfers) {
      if (transferData.startNum == request.num) {
        addStartPositionAfterBuild(transferData, appState);
        break;
      }
      if (transferData.endNum == request.num) {
        addEndCellfterBuild(transferData, appState);
        break;
      }
    }
    return Flexible(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
              key: cellKey,
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
                    // isDestinationCell ? "СЮДА" : "НЕТ",
                    request.isOpen ? request.header : request.num.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10.0),
                  ))));
        },
      ),
    );
  }

  void addStartPositionAfterBuild(Transfer snakeData, LeelaAppState appState) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      snakeData.addStartCellKeys(cellKey);
      appState.notifySnakeIfReady();
    });
  }

  void addEndCellfterBuild(Transfer snakeData, LeelaAppState appState) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      snakeData.addEndCellKeyAfterBuild(cellKey);
      appState.notifySnakeIfReady();
    });
  }
}
