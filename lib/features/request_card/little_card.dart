import 'package:Leela/leela_app.dart';
import 'package:Leela/service/request_loader.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../theme/theme.dart';

class LittleCard extends StatefulWidget {
  final Future<RequestData>? request;

  LittleCard(Future<RequestData> this.request, {super.key});

  @override
  State<LittleCard> createState() => _LittleCardState();
}

class _LittleCardState extends State<LittleCard> {
  bool expanded = false;
  double opacityLevel = 1.0;

  initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 2600)).then((value) => setState(() {
          expanded = !expanded;
          opacityLevel = opacityLevel == 0 ? 1.0 : 0.0;
          // Future.delayed(Duration(seconds: 3))
          //     .then((value) => _changeOpacity());
          // }))
          // ;
        }));
  }

  // void _changeOpacity() {
  //   setState(() => );
  // }

  @override
  Widget build(BuildContext context) {
    var futureChild = FutureBuilder<RequestData>(
      future: this.widget.request,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var requestData = snapshot.requireData;
          return Center(
            child: AnimatedContainer(
              height: expanded ? 650.0 : 400.0,
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
                        Stack(children: [
                          Image.asset(
                            // opacity: const AlwaysStoppedAnimation(0.1),
                            'assets/images/${requestData.asset_name}.jpg',
                            scale: 0.1,
                          ),
                          AnimatedOpacity(
                              opacity: opacityLevel,
                              duration: Duration(seconds: 2),
                              child: Lottie.asset('assets/dice.json',
                                  repeat: false)),
                        ]),
                        Container(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(requestData.description),
                        )),
                      ]),
                    )),
              ),
            ),
          );
        } else {
          return Text('Loading...');
        }
      },
    );
    return futureChild;
  }
}
