import 'package:Leela/bloc/request_bloc/request_bloc.dart';
import 'package:Leela/service/request_keeper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/request_data.dart';

class ListOfRequest extends StatefulWidget {
  @override
  State<ListOfRequest> createState() => _ListOfRequestState();
}

class _ListOfRequestState extends State<ListOfRequest> {

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme
        .of(context)
        .textTheme;

    return BlocBuilder<RequestBloc, RequestState>(
      builder: (context, state) {
        if (state is RequestLoadedState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                for (var request in state.requests)
                  ListTile(
                    shape: Border(
                        bottom: BorderSide(color: Colors.white, width: 0.1)),
                    trailing: Icon(Icons.arrow_forward_ios),
                    title: Text('${request.num}. ${request.header}',
                        style: textTheme.bodyMedium),
                    contentPadding: EdgeInsets.all(5.0),
                    subtitle: Text(
                      request.description.substring(
                          0,
                          request.description.length > 100
                              ? 100
                              : request.description.length),
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodySmall,
                    ),
                    // hoverColor: Colors.amber.shade700,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          "/card",
                          arguments: Future<RequestData>.value(request));
                    },
                    // },
                  )
              ],
            ),
          );
        } else return CircularProgressIndicator();
      },
    );
  }
}
