import 'package:Leela/leela_app.dart';
import 'package:Leela/service/request_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'field_cell.dart';

class FieldWidget extends StatefulWidget {
  @override
  State<FieldWidget> createState() => _FieldWidgetState();
}

class _FieldWidgetState extends State<FieldWidget> {
  List<GameRow> rows = [];
  Future<List<RequestModel>>? request;

  @override
  void initState() {
    super.initState();
     () async {
      List<RequestModel> list = await Requests.deserialize();
      setState(() {
        rows.addAll(createRows(list));
      });
     };

    // setState(() {});

  }

  @override
  Widget build(BuildContext context) {
    // var rows = createFRows(context);
    //TODO: return scaffold
    return Center(
      child: FutureBuilder<List<RequestModel>>(
        future: request,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<GameRow>  childrenRows = createRows(snapshot.data);
            return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/god.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: childrenRows,
                  mainAxisAlignment: MainAxisAlignment.end,
                ));
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  // FutureBuilder<List<RequestData>>(
  //   future: futureRequest,
  //   builder: (context, snapshot) {
  //     if (snapshot.hasData) {
  //       List<GameRow>  childrenRows = createRows(snapshot.data);
  //       return Container(
  //           decoration: BoxDecoration(
  //             image: DecorationImage(
  //               image: AssetImage("assets/images/god.jpg"),
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //           child: Column(
  //             children: childrenRows,
  //             mainAxisAlignment: MainAxisAlignment.end,
  //           ));
  //     } else {
  //       return CircularProgressIndicator();
  //     }
  //   },
  // ),
  //   );
  // }

  //
  // Future<List<GameRow>> createFRows(BuildContext context) async {
  //   // List<RequestModel> requests = await context.watch<LeelaAppState>()
  //   //     .loadRequests;
  //
  //   var startPos = 63;
  //   var endPos = 72;
  //
  //   for (var j = 1; j < 9; ++j) {
  //     var requestsOfRow = requests.getRange(startPos, endPos).toList();
  //     var gameRow = GameRow(requestsOfRow, j % 2 == 0);
  //     rows.add(gameRow);
  //     startPos -= 9;
  //     endPos -= 9;
  //   }
  //   return rows;
  //
  //   // return then;
  // }

  List<GameRow> createRows(requests) {
    var startPos = 63;
    var endPos = 72;
    var rows;
    for (var j = 1; j < 9; ++j) {
      var requestsOfRow = requests.getRange(startPos, endPos).toList();
      var gameRow = GameRow(requestsOfRow, j % 2 == 0);

      rows.add(gameRow);
      startPos -= 9;
      endPos -= 9;
    }
    return rows;
  }
}

class GameRow extends StatelessWidget {
  final List<RequestModel> requestsOfRow;
  final bool isDirectSequence;
  List<Widget> cards = [];

  GameRow(List<RequestModel> this.requestsOfRow, bool this.isDirectSequence,
      {Key? key})
      : super(key: key) {
    cards = createRowSequence(this.isDirectSequence);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: cards);
  }

  List<Widget> createRowSequence(bool isDirectSequence) {
    List<Widget> cells = [];
    var sequence = isDirectSequence ? requestsOfRow : requestsOfRow.reversed;
    for (var req in sequence) {
      cells.add(
          Padding(padding: const EdgeInsets.all(1.0), child: CellField(req)));
    }
    return cells;
  }
}
