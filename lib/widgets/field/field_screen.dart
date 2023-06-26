import 'package:Leela/widgets/field/play_zone.dart';
import 'package:Leela/widgets/field/interraction.dart';
import 'package:Leela/widgets/field/overlay_data.dart';
import 'package:Leela/service/request_loader.dart';
import 'package:flutter/material.dart';

class FieldWidget extends StatefulWidget {
  @override
  State<FieldWidget> createState() => _FieldWidgetState();
}

class _FieldWidgetState extends State<FieldWidget> {
  List<GameRow> rows = [];
  var request;

  @override
  void initState() {
    super.initState();
    request = RequestsLoader.getRequests();
  }

  @override
  Widget build(BuildContext context) {
    context.widget.key;
    var futureBuilder = FutureBuilder<List<RequestData>>(
        future: request,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //жетская необходимость в рефакторинге
            var requestsData = snapshot.requireData;
            return Scaffold(
              body: Container(
                child: Column(
                  children: [
                    // OverlayInfo(),
                    PlayZone(requestsData),
                    PlayerInput()
                  ],
                  // mainAxisAlignment: MainAxisAlignment.end,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/god.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          } else {
            //TODO: Крутилка
            return Text("Loading...");
          }
        });

    return futureBuilder;
  }

}
