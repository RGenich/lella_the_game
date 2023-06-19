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
  final Color openedColor = Color.fromRGBO(255, 255, 255, 0);
  final Color closedColor = Color.fromRGBO(0, 0, 0, 0.5);
  Color cellColor = Color.fromRGBO(255, 255, 255, 0);
  final RequestData request;
  var cellKey = GlobalKey();

  _CellFieldState(RequestData this.request);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cellColor = request.isOpen ? openedColor : closedColor;
    var appState = context.watch<LeelaAppState>();
    double width = appState.playZoneSize.width;
    double height = appState.playZoneSize.height;
    var currentPosition = appState.currentPosition;
    if (request.isOpen && currentPosition == request.num) {
      RenderBox cellRenderBox = cellKey.currentContext?.findRenderObject() as RenderBox;
      var position = cellRenderBox.localToGlobal(Offset.zero);
      appState.setMarkerPos(position);
    }
    // var renderObject = appState.playZoneKey.currentContext?.findRenderObject();
    // double? heightZone = renderObject.
    // double? widthZone = appState.playZoneKey.currentContext?.size?.width;
    // var requestList = appState.requests;
    return Container(
        key: cellKey,
        height: (height - 2) / 8,
        width: (width - 2) / 9,
        decoration: BoxDecoration(
            border: Border.all(color: cellColor), color: cellColor),
        child: InkWell(
            onTap: () {
              appState.makeRecords(request);
              setState(() {
                request.isOpen = true;
                cellColor = Color.fromRGBO(255, 255, 255, 0);
              });
              Navigator.of(context).pushNamed("/card", arguments: request);
            },
            child: Align(
                child: Text(
              request.isOpen ? request.header : request.num.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10.0),
            ))));
  }
}
