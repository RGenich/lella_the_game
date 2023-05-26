import 'package:flutter/material.dart';
import '../../../service/request_loader.dart';

class ListOfRequest extends StatefulWidget {
  @override
  State<ListOfRequest> createState() => ListOfRequestState();
}

class ListOfRequestState extends State<ListOfRequest> {
  List<Request> requestList = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    loadRequests();
    print("InitState2");
    // () async {
      // var newVariable = await loadRequests();
      // requestList.addAll(newVariable);
      // setState(() {});
    // }();
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    
    var len = requestList.length;
    print("building with lent $len");
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        for (var req in requestList)
          ListTile(
            shape: Border(bottom: BorderSide(color: Colors.white, width: 0.1)),
            trailing: Icon(Icons.arrow_forward_ios),
            title: Text(req.header, style: textTheme.bodyMedium),
            contentPadding: EdgeInsets.all(5.0),
            subtitle: Text(
              req.description.substring(0,
                  req.description.length > 100 ? 100 : req.description.length),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            // hoverColor: Colors.amber.shade700,
            onTap: () {
              Navigator.of(context).pushNamed("/card", arguments: req);
            },
          )
      ],
    );
  }

  loadRequests() {
    var list =  Requests.deserialize();
    list.then((value)  {
      var len = requestList.length;
      requestList.addAll(value);
      setState(() {
    });
    
    print("setState with lent $len");
      });
    print("loadReq01");
    
  }
}
