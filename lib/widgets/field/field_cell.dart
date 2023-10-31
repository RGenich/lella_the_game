
import 'package:Leela/leela_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/request_data.dart';

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
  GlobalKey cellKey = GlobalKey();

  _GameCellState(RequestData this.request) {
    request.cellKey = this.cellKey;
  }
  //
  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     print('ПостФреймКоллБек КЛЕТКИ');
  //
  //     // Bloc requestBloc = BlocProvider.of<RequestBloc>(context);
  //     // Bloc markerBloc = BlocProvider.of<MarkerBloc>(context);
  //     //
  //     // RenderBox cellBox = cellKey.currentContext?.findRenderObject() as RenderBox;
  //     // Size size = cellBox.size;
  //     // Offset pos = cellBox.localToGlobal(Offset.zero);
  //     //
  //     // requestBloc.add(RequestCellBuiltEvent(request: request, position: pos));
  //     // markerBloc.add(MarkerSizeDefinedEvent(size));
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    print('building cell ${request.num}');

    cellColor = request.isOpen ? openedColor : closedColor;
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


