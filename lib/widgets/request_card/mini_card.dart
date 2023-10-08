import 'package:Leela/leela_app.dart';
import 'package:Leela/service/request_keeper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MiniCard extends StatefulWidget {
  final RequestData request;

  MiniCard(RequestData this.request, {super.key});

  @override
  State<MiniCard> createState() => _MiniCardState(request);
}

class _MiniCardState extends State<MiniCard> {
  _MiniCardState(this.request);

  var appState;
  bool expanded = false;
  RequestData request;

  initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 10)).then((value) => setState(() {
          expanded = !expanded;
        }));
  }

  @override
  Widget build(BuildContext context) {
    var txtTheme = Theme.of(context).textTheme;
    appState = context.watch<LeelaAppState>();
    Size currentCellSize = appState?.currentCellSize;
    Offset reqPosition = request.position ?? Offset.zero;

    return LayoutBuilder(builder: (context, constraints) {
      var expandedHeight = constraints.maxHeight / 100 * 95;
      var expandedWidth = constraints.maxWidth / 100 * 70;
      return Align(
        alignment: Alignment.topLeft,
        child: AnimatedContainer(
          curve: Curves.fastOutSlowIn,
          // height: expanded ? 700.0 : 400.0 ,
          height: expanded ? expandedHeight : currentCellSize.height,
          width: expanded ? expandedWidth : currentCellSize.width,
          duration: Duration(seconds: 2),
          transform: expanded
              ? Matrix4.translationValues(
                  constraints.maxWidth / 10, 10.0, 0.0)
              : Matrix4.translationValues(reqPosition.dx, reqPosition.dy, 0.0),
          child: Card(
            borderOnForeground: true,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.yellow),
                borderRadius: BorderRadius.circular(10.0)),
            shadowColor: Colors.orange,
            child: SingleChildScrollView(
              child: Column(children: [
                Stack(alignment: AlignmentDirectional.topStart, children: [
                  Container(
                    child: Image.asset(
                      fit: BoxFit.fill,
                      'assets/images/${request.assetName}.jpg',
                      scale: 0.1,
                    ),
                  ),
                  Container(
                    transform: Matrix4.translationValues(0.0, 215.0, 0),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0, top: 10),
                      child: Text("${request.num}. ${request.header}",
                          textAlign: TextAlign.left,
                          style: txtTheme.headlineLarge),
                    ),
                  ),
                  Container(
                    transform: Matrix4.translationValues(0.0, 260.0, 0),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [
                          0,
                          0.2
                        ],
                            colors: [
                          Color.fromRGBO(0, 0, 0, 0.2),
                          // Colors.red,
                          Colors.black
                        ])),
                    // color: Color.fromRGBO(0, 0, 0, 0.5),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 35.0, right: 30.0, top: 10, bottom: 20),
                      child: RichText(
                          text: TextSpan(
                              text: request.description,
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'OpenSans')
                              // style: txtTheme.bodyLarge

                              )),
                    ),
                  )
                ]),
              ]),
            ),
          ),
        ),
      );
    });
  }
}
