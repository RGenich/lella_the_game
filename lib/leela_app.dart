
import 'package:Leela/bloc/dice_bloc/dice_bloc.dart';
import 'package:Leela/bloc/marker_bloc/marker_bloc.dart';
import 'package:Leela/bloc/request_bloc/request_bloc.dart';
import 'package:Leela/repository/repository.dart';
import 'package:Leela/router/routes.dart';
import 'package:Leela/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';


class LeelaApp extends StatefulWidget {
  LeelaApp() {}

  @override
  State<LeelaApp> createState() => _LeelaAppState();
}

class _LeelaAppState extends State<LeelaApp> {
  final Repository repository = Repository();
  late final MarkerBloc markerBloc = MarkerBloc(repository);
  late final RequestBloc requestBloc = RequestBloc(repository);
  late final DiceBloc diceBloc = DiceBloc(repository);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return RepositoryProvider(
      create: (context) => repository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => requestBloc..add(InitializingRequestsEvent())),
          BlocProvider(create: (context) => diceBloc..add(InitialDiceEvent())),
          BlocProvider(create: (context) => markerBloc/*..add(MarkerInitialEvent())*/)
        ],
        child: ChangeNotifierProvider(
          create: (context) => LeelaAppState(),
          child: MaterialApp(
            title: 'Leela',
            theme: theme,
            routes: routes,
          ),
        ),
      ),
    );
  }
}

class LeelaAppState extends ChangeNotifier {

  //Последовательность выпавших очков
  List<int> _diceScores = [];
  get getLastDiceScore => _diceScores.isNotEmpty ? _diceScores.last : 0;

  // void refreshCellPositions() {
  //   for (var req in RequestsKeeper.requests) {
  //     if (req.cellKey != null) {
  //       var newPosition = getPositionByKey(req.cellKey);
  //       req.position = newPosition;
  //       setTransfersPosition(newPosition, req.num);
  //     }
  //   }
  // }

}
