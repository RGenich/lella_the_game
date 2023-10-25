import 'package:Leela/bloc/request_bloc/request_bloc.dart';
import 'package:Leela/leela_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'transfer_widget.dart';

enum TransferType { ARROW, SNAKE }

class Transfer {
  int startNum;
  Offset startPos = Offset.zero;
  int endNum;
  Offset endPos = Offset.zero;
  GlobalKey? startCellKey;
  GlobalKey? endCellKey;
  TransferType type;
  bool isVisible = false;

  Transfer(this.startNum, this.endNum, this.type,
      {Offset? startPos, Offset? endPos, bool? isVisible});
}

class Snakes extends StatefulWidget {
  const Snakes({super.key});

  @override
  State<Snakes> createState() => _SnakesState();
}

class _SnakesState extends State<Snakes> {
  @override
  Widget build(BuildContext context) {
    // List<Transfer> allTransfers = context.watch<LeelaAppState>().allTransfers;
    // List<Transfer> allTransfers = context
    //     .watch<LeelaAppState>()
    //     .allTransfers;
    var reqbloc = RequestBloc();
    return BlocProvider(
      create: (context) => reqbloc,
      child: BlocBuilder<RequestBloc, RequestState>(
        builder: (context, state) {
          if (state is AllTransferDefinedEvent) {
            return Stack( children: [
                for (Transfer transfer in state.allTransfers)
                TransferWidget(key: UniqueKey(), transferData: transfer)
                ]);
          }
          else return CircularProgressIndicator(color: Colors.deepOrange);
        },
      ),
    );
  }
}
