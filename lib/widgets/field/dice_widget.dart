import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif/gif.dart';
import 'package:provider/provider.dart';

import '../../bloc/dice_bloc/dice_bloc.dart';
import '../../leela_app.dart';

class Dice extends StatefulWidget {
  @override
  State<Dice> createState() => _DiceState();
}

class _DiceState extends State<Dice> with TickerProviderStateMixin {
  int number = 0;
  bool enabled = true;
  late GifController controller = GifController(vsync: this);

  @override
  void initState() {
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        var state = Provider.of<LeelaAppState>(context, listen: false);
        state.claculateMoves();
        state.addNewMarkerPosition();
        state.notifyListeners();
      }
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

    void pause() {
      Future.delayed(Duration(milliseconds: 1700)).then((value) => setState(() {
            enabled = true;
          }));
    }

    var diceBloc = DiceBloc();
    return MultiBlocProvider(
        
        providers: [
          BlocProvider(create: (context) => diceBloc..add(InitialDiceEvent()))
        ],
        child: Container(
          child: BlocBuilder<DiceBloc, DiceBlocState>(
            builder: (context, state) {
              return AbsorbPointer(
                  absorbing: !enabled,
                  // state is DiceUnthrowedState
                  child: InkWell(
                      onTap: () {
                        controller.reset();
                        enabled = false;
                        controller.forward();
                        diceBloc.add(ThrowDiceEvent());
                        // throwDice();
                        appState.defineCellSize();
                        pause();
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
                            image:
                                AssetImage("assets/images/cube${number}.gif"),
                          ),
                        ),
                      )));
            },
          ),
        ));
  }
}
