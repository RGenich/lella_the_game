
import 'package:Leela/leela_app.dart';
import 'package:Leela/service/request_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CellField extends StatefulWidget {
  final RequestData request;

  CellField(RequestData this.request);

  @override
  State<CellField> createState() => _CellFieldState(request);
}

class _CellFieldState extends State<CellField> {
  Color openedColor = Color.fromRGBO(255, 255, 255, 0);
  Color closedColor = Color.fromRGBO(0, 0, 0, 0.5);
  Color cellColor = Color.fromRGBO(255, 255, 255, 0);
  RequestData request;
  _CellFieldState(RequestData this.request);

  @override
  Widget build(BuildContext context) {
    cellColor = request.isOpen ? openedColor: closedColor;
    //todo: почему я использую  setState c провадйером?
    var appState = context.watch<LeelaAppState>();
    // var requestList = appState.requests;
    return Container(
      key: UniqueKey(),
      height: 83.0,
      width: 43.0,
      decoration: BoxDecoration(border: Border.all(color: cellColor), color: cellColor),
      child: InkWell(
          onTap: () {
            appState.makeRecords(request);
            setState(() {
              request.isOpen = true;
              cellColor = Color.fromRGBO(255, 255, 255, 0);
            }
            );
            Navigator.of(context).pushNamed("/card", arguments: request);
            },
          child: Align(
              child: Text(
                request.isOpen ? request.header : request.num.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10.0),
              ))),
    );
  }
}
