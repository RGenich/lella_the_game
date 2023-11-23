import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gif/gif.dart';

import '../bloc/dice_bloc/dice_bloc.dart';
import '../bloc/marker_bloc/marker_bloc.dart';

class Dice extends StatefulWidget {
  @override
  State<Dice> createState() => _DiceState();
}

class _DiceState extends State<Dice> with TickerProviderStateMixin {
  bool enabled = true;
  late GifController controller = GifController(vsync: this);
  late DiceBloc diceBloc;
  late MarkerBloc markerBloc;
  @override
  void initState() {
    diceBloc = BlocProvider.of<DiceBloc>(context);
    markerBloc = BlocProvider.of<MarkerBloc>(context);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        markerBloc..add(IsShouldMarkerMoveEvent());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _throw() {
      diceBloc..add(ThrowDiceStartEvent());
      controller.reset();
      controller.forward();
    }

    return BlocBuilder<DiceBloc, DiceBlocState>(
      builder: (context, state) {
        // if (state is DiceThrowedState) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: AbsorbPointer(
                absorbing: state.isDiceBlocked,
                child: InkWell(
                    onTap: _throw,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Ink(
                        // width: 70,
                        // height: 70,
                        child: Gif(
                          duration: Duration(milliseconds: 1500),
                          controller: controller,
                          image: AssetImage(
                              "assets/images/cube${state.diceResult}.gif"),
                        ),
                      ),
                    ))),
          );
      },
    );
  }
}
