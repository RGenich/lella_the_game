import 'package:Leela/widgets/request_card/mini_card.dart';
import 'package:Leela/leela_app.dart';
import 'package:Leela/service/request_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListOfRequest extends StatefulWidget {
  @override
  State<ListOfRequest> createState() => _ListOfRequestState();
}

class _ListOfRequestState extends State<ListOfRequest> {
  var req;

  @override
  void initState() {
    super.initState();
    req = RequestsLoader.getRequests();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme
        .of(context)
        .textTheme;
    var futureBuilder = new FutureBuilder(
        future: req,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView(
              scrollDirection: Axis.vertical,
              children: [
                for (var realReq in snapshot.requireData)
                  ListTile(
                    shape: Border(
                        bottom: BorderSide(color: Colors.white, width: 0.1)),
                    trailing: Icon(Icons.arrow_forward_ios),
                    title: Text(realReq.header, style: textTheme.bodyMedium),
                    contentPadding: EdgeInsets.all(5.0),
                    subtitle: Text(
                      realReq.description.substring(
                          0,
                          realReq.description.length > 100
                              ? 100
                              : realReq.description.length),
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodySmall,
                    ),
                    // hoverColor: Colors.amber.shade700,
                    onTap: () {
                      Navigator.of(context).pushNamed("/card", arguments: Future<RequestData>.value(realReq));
                    },
                    // },
                  )
              ],
            );
          }
        if (snapshot.hasError)
    {
      return Text("Error");
    } else {
    return Text("waiting");
    }
  }

  ,

  );

  // var state = context.watch<LeelaAppState>();
  return

  new

  Scaffold

  (

  body

      :

  futureBuilder

  ,

  );
}}

//
//
//
//     var textTheme = Theme.of(context).textTheme;
//     var state = context.watch<LeelaAppState>();
//     List<RequestModel> requests =  loadAsync();
//     // List<RequestData> requests = [];
//     return Scaffold(
//       body: ListView(
//         scrollDirection: Axis.vertical,
//         children: [
//           for (var req in requests)
//             ListTile(
//               shape:
//                   Border(bottom: BorderSide(color: Colors.white, width: 0.1)),
//               trailing: Icon(Icons.arrow_forward_ios),
//               title: Text(req.header, style: textTheme.bodyMedium),
//               contentPadding: EdgeInsets.all(5.0),
//               subtitle: Text(
//                 req.description.substring(
//                     0,
//                     req.description.length > 100
//                         ? 100
//                         : req.description.length),
//                 style: Theme.of(context).textTheme.bodySmall,
//               ),
//               // hoverColor: Colors.amber.shade700,
//               onTap: () {
//                 Navigator.of(context).pushNamed("/card", arguments: req);
//               },
//             )
//         ],
//       ),
//     );
//   }
// }
