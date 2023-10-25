import 'package:Leela/bloc/request_bloc/request_bloc.dart';
import 'package:Leela/leela_app.dart';
import 'package:Leela/service/request_keeper.dart';
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
  final Color closedColor = Color.fromRGBO(0, 0, 0, 0.34);
  Color cellColor = Color.fromRGBO(255, 255, 255, 0);
  final RequestData request;
  var cellKey = GlobalKey();

  _GameCellState(RequestData this.request) {
    request.cellKey = this.cellKey;
  }

  RequestBloc requestBloc = RequestBloc();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RenderBox cellBox = cellKey.currentContext?.findRenderObject() as RenderBox;
      Size size = cellBox.size;
      var position = cellBox.localToGlobal(Offset.zero);
      request.position = position;
      requestBloc.add(RequestCellBuiltEvent(request: request, position: position));
      var appState = context.read<LeelaAppState>();
      appState.setCurrentCellSize(size);
      appState.setTransfersPosition(position, request.num);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<LeelaAppState>();

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
                    Navigator.of(context)
                        .pushNamed("/card", arguments: request);
                  },
                  child: Align(
                      child: Text(
                    // isDestinationCell ? "СЮДА" : "НЕТ",
                    request.isOpen ? request.header : request.num.toString(),
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 10.0),
                  ))));
        },
      ),
    );
  }
}

