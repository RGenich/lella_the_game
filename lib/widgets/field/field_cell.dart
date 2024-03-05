import 'package:Leela/bloc/request_bloc/request_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:collection/collection.dart';
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
  bool isCellOpen = false;

  _GameCellState(RequestData this.request) {
    request.cellKey = this.cellKey;
  }

  @override
  Widget build(BuildContext context) {
    if (request.num == 72 || request.num == 9) {
      print('building cell ${request.num}');
    }
    cellColor = request.isOpen ? openedColor : closedColor;
    return Flexible(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var blocState = context.watch<RequestBloc>();

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
                      // child: BlocBuilder<RequestBloc, RequestState>(
                    // buildWhen: (previous, current) {
                      // var prev = previous.requests
                      //     .firstWhereOrNull((element) => element.cellKey == cellKey);
                      // var cur = current.requests
                      //     .firstWhereOrNull((element) => element.cellKey == cellKey);
                      // return cur != null && cur.isOpen;
                    // },
                    // builder: (context, state) {
                      child: Text(
                        // isDestinationCell ? "СЮДА" : "НЕТ",
                        request.isOpen
                            ? request.header
                            : request.num.toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 10.0),
                      ))
                    // },
                  ));
        },
      ),
    );
  }
}
