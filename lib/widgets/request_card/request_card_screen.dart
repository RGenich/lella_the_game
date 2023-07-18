import 'package:flutter/material.dart';
import '../../service/request_loader.dart';

class RequestCard extends StatelessWidget {
  RequestData? requestData;

  RequestCard();
  RequestCard.withRealRequest(RequestData this.requestData);

  @override
  Widget build(BuildContext context) {
    dynamic _request = defineRequest(context);
    final theme = Theme.of(context);

    var fb = FutureBuilder<RequestData>(
        future: _request,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            RequestData realRequest = snapshot.requireData;
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                          child: Stack(children: [
                            Image.asset(
                              'assets/images/${realRequest.assetName}.jpg',
                              scale: 0.1,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20, 40, 20, 20),
                                child: Row(children: [
                                  Icon(Icons.arrow_back_ios_rounded),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(47, 40, 40, 0.5)),
                                    child: Text(
                                      realRequest.header,
                                      style: theme.textTheme.headlineMedium,
                                    ),
                                  )
                                ]),
                              ),
                            ),
                          ])),
                    ),
                    Container(
                        transform: Matrix4.translationValues(0.0, -100.0, 0.0),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromRGBO(47, 40, 40, 0.5),
                                  Colors.black
                                ])),
                        // color: Gradient.lerp(a, b, t),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                style: theme.textTheme.bodyLarge,
                                text: realRequest.description,
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            );
          }
          else {
            return Text('Loading');
          }
        });
    return fb;
  }
}


Future<RequestData> defineRequest(BuildContext context) {
  var args = ModalRoute.of(context)!
      .settings.arguments;
  if (args != null && args is Future<RequestData>)
    return args;
  else
    throw Exception('Unable to define request of user');
}
