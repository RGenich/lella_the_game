import 'package:Leela/service/request_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MiniCard extends StatefulWidget {
  final RequestData request;

  MiniCard(RequestData this.request, {super.key});

  @override
  State<MiniCard> createState() => _MiniCardState(request);
}

class _MiniCardState extends State<MiniCard> {
  _MiniCardState(this.request);

  bool expanded = false;
  double opacityLevel = 1.0;
  double opacityHeaderLevel = 0.0;
  RequestData request;

  initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 2800)).then((value) => setState(() {
          expanded = !expanded;
          opacityLevel = opacityLevel == 0 ? 1.0 : 0.0;
          opacityHeaderLevel = opacityHeaderLevel == 0 ? 1.0 : 0.0;
        }));
  }

  @override
  Widget build(BuildContext context) {
    var txtTheme = Theme.of(context).textTheme;

    return LayoutBuilder(builder: (context, constraints) {
      var nonExpanded = constraints.maxHeight / 100 * 30;
      var expandedHeight = constraints.maxHeight / 100 * 85;
      return Center(
        child: AnimatedContainer(
          // height: expanded ? 700.0 : 400.0 ,
          height: expanded ? expandedHeight : nonExpanded,
          width: expanded ? constraints.maxWidth : nonExpanded,
          duration: Duration(seconds: 3),
          child: Card(
            borderOnForeground: true,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.yellow),
                borderRadius: BorderRadius.circular(50.0)),
            shadowColor: Colors.orange,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Image.asset(
                            fit: BoxFit.fill,
                            // opacity: const AlwaysStoppedAnimation(0.1),
                            'assets/images/${request.assetName}.jpg',
                            scale: 0.1,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("${request.num}. ${request.header}",
                                textAlign: TextAlign.justify,
                                style: txtTheme.headlineLarge),
                          ),
                          AnimatedOpacity(
                              opacity: opacityLevel,
                              duration: Duration(milliseconds: 3000),
                              child: Container(
                                // color: Colors.black,
                                width: double.infinity,
                                height: nonExpanded,
                                child: Lottie.asset('assets/lotties/dice.json',
                                    repeat: false,
                                    alignment: Alignment.topCenter),
                              )),
                        ]),
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(request.description,
                            textAlign: TextAlign.justify,
                            style: txtTheme.bodyLarge),
                      )
                    ]),
                  ]),
                )),
          ),
        ),
      );
    });
  }
}
