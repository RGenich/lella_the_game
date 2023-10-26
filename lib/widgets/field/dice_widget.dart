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
  bool enabled = true;
  late GifController controller = GifController(vsync: this);
  late DiceBloc diceBloc;

  @override
  void initState() {
    diceBloc = BlocProvider.of<DiceBloc>(context);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        diceBloc.add(ThrowDiceEndEvent());
        // var state = Provider.of<LeelaAppState>(context, listen: false);
        // state.claculateMoves();
        // state.addNewMarkerPosition();
        // state.notifyListeners();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _makeDeal() {

      controller.reset();
      controller.forward();
      // controller.
      diceBloc.add(ThrowDiceStartEvent());
    }

    return Builder(
      builder: (context) {
        return Container(
          child: BlocBuilder<DiceBloc, DiceBlocState>(
            builder: (context, state) {
              return AbsorbPointer(
                  absorbing: state.diceStatus.isDiceBlocked,
                  child: InkWell(
                      onTap: _makeDeal,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Ink(
                          width: 70,
                          height: 70,
                          child: Gif(
                            duration: Duration(milliseconds: 1500),
                            controller: controller,
                            image: AssetImage(
                                "assets/images/cube${state.diceStatus.diceResult}.gif"),
                          ),
                        ),
                      )));
            },
          ),
        );
      }
    );
  }
}
