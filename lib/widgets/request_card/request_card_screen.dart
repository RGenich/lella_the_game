import 'package:flutter/material.dart';
import '../../model/request_data.dart';
import '../../service/request_keeper.dart';

class RequestCard extends StatelessWidget {
  // RequestData? requestData;

  // RequestCard();

  // RequestCard.withRealRequest(RequestData this.requestData);

  @override
  Widget build(BuildContext context) {
    var _request = defineRequest(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                  child: Stack(children: [
                Image.asset(
                  'assets/images/${_request.assetName}.jpg',
                  scale: 0.1,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                    child: Row(children: [
                      Icon(Icons.arrow_back_ios_rounded),
                      Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(47, 40, 40, 0.5)),
                        child: Text(
                          _request.header,
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
                  padding: EdgeInsets.all(24.0),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: RichText(
                      // textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: theme.textTheme.bodyLarge,
                        text: _request.description,
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

RequestData defineRequest(BuildContext context) {
  return ModalRoute.of(context)!.settings.arguments as RequestData;
}
