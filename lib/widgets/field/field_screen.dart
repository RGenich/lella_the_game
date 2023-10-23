import 'package:Leela/widgets/field/play_zone.dart';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:provider/provider.dart';

import '../../leela_app.dart';

class FieldWidget extends StatefulWidget {
  @override
  State<FieldWidget> createState() => _FieldWidgetState();
}

class _FieldWidgetState extends State<FieldWidget>
    with TickerProviderStateMixin {
  List<GameRow> rows = [];
  var number = 0;
  bool enabled = true;
  late GifController controller = GifController(vsync: this);

  @override
  void initState() {
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        var state = Provider.of<LeelaAppState>(context, listen: false);
        state.claculateMoves();
        state.addNewMarkerPosition();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      var state = Provider.of<LeelaAppState>(context, listen: false);
      state.refreshCellPositions();
      // state.notify();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<LeelaAppState>();

    int throwDice() {
      setState(() {
        number = appState.throwRandom();
      });
      return number;
    }

    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Column(children: [
              // OverlayInfo(),
              Expanded(
                  // flex: 5,
                  child: PlayZone()),
              // PlayerInput()
            ]),
            Column(
              children: [
                Expanded(
                    // flex: 1,
                    child: Container(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: AbsorbPointer(
                              absorbing: !enabled,
                              child: InkWell(
                                  onTap: () {
                                    controller.reset();
                                    enabled = false;
                                    controller.forward();
                                    int moveCount = throwDice();
                                    appState.defineCellSize();
                                    // appState.checkUnvisitedMarkerPositions();
                                    pause(moveCount);
                                  },
                                  // width: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Ink(
                                      width: 70,
                                      height: 70,
                                      child: Gif(
                                        // autostart: Autostart.once,
                                        // fps: 60,
                                        duration: Duration(milliseconds: 1500),
                                        controller: controller,
                                        image: AssetImage(
                                            "assets/images/cube${number}.gif"),
                                        // "assets/images/dice5.gif"),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        )))
              ],
            )
          ],
          // mainAxisAlignment: MainAxisAlignment.end,
        ),
      ), // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage("assets/images/god.jpg"),
      //     fit: BoxFit.cover,
      //   ),
      // ),
    );
  }

  void pause(int moveCount) {
    Future.delayed(Duration(milliseconds: 1700)).then((value) => setState(() {
          enabled = true;
        }));
  }
}
