// ignore_for_file: unused_import

import 'package:Leela/bloc/marker_bloc/marker_bloc.dart';
import 'package:Leela/leela_app.dart';
import 'package:Leela/service/request_keeper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../model/request_data.dart';

class MiniCard extends StatefulWidget {
  final RequestData request;

  MiniCard(RequestData this.request, {super.key});

  @override
  State<MiniCard> createState() => _MiniCardState(request);
}

class _MiniCardState extends State<MiniCard> {
  _MiniCardState(this.request);

  bool expanded = false;
  RequestData request;

  initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300)).then((value) =>
        setState(() {
          expanded = !expanded;
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    var txtTheme = Theme
        .of(context)
        .textTheme;
    // appState = context.watch<LeelaAppState>();
    final Offset reqPosition = request.position;

    return BlocBuilder<MarkerBloc, MarkerState>(
      builder: (context, state) {
        return LayoutBuilder(builder: (context, constraints) {
          Size currentCellSize = state.size;
          var expandedHeight = constraints.maxHeight / 100 * 99;
          var spaceByTop = expandedHeight / 100 * 80;
          return Align(
            alignment: Alignment.topLeft,
            child: AnimatedContainer(
              curve: Curves.decelerate,
              // height: expanded ? 700.0 : 400.0 ,
              height: expanded ? expandedHeight : currentCellSize.height,
              // width: expanded ? expandedWidth : currentCellSize.width,
              width: expanded ? expandedHeight * 1.5 : currentCellSize.width,
              duration: Duration(milliseconds: 1700),
              transform: expanded
                  ? Matrix4.translationValues(
                  constraints.maxWidth / 10, 10.0, 0.0)
                  : Matrix4.translationValues(
                  reqPosition.dx, reqPosition.dy, 0.0),
              child: Card(
                borderOnForeground: true,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.yellow),
                    borderRadius: BorderRadius.circular(10.0)),
                shadowColor: Colors.orange,
                child: SingleChildScrollView(
                  child: Stack(children: [
                    ImageWidget(request: request),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: spaceByTop),
                        Header(request: request, txtTheme: txtTheme),
                        Description(request: request)
                      ],
                    ),
                  ]),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}

class Description extends StatelessWidget {
  const Description({
    super.key,
    required this.request,
  });

  final RequestData request;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0.2],
              colors: [Color.fromRGBO(0, 0, 0, 0.2), Colors.black])),
      child: Padding(
        padding:
        const EdgeInsets.only(left: 35.0, right: 30.0, top: 10, bottom: 20),
        child: RichText(
            text: TextSpan(
                text: request.description,
                style: TextStyle(fontSize: 16, fontFamily: 'OpenSans'))),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.request,
  });

  final RequestData request;

  @override
  Widget build(BuildContext context) {
    return Container(
      // transform: Matrix4.translationValues(0.0, -200, 0),
      child: Image.asset(
        fit: BoxFit.fill,
        'assets/images/${request.assetName}.jpg',
        scale: 0.1,
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.request,
    required this.txtTheme,
  });

  final RequestData request;
  final TextTheme txtTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      // transform: Matrix4.translationValues(0.0, 215.0, 0),
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0, top: 10),
        child: Text("${request.num}. ${request.header}",
            textAlign: TextAlign.left, style: txtTheme.headlineLarge),
      ),
    );
  }
}
