import 'package:flutter/material.dart';
import '../../../service/request_loader.dart';

class RequestCard extends StatelessWidget {
  RequestCard({Request? request});

  Request? _request;

  @override
  Widget build(BuildContext context) {
    _request = defineRequest(context);
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
                child: Stack(children: [
              Image.asset(
                'assets/push.jpg',
                scale: 0.1,
              ),
              Text(
                _request!.header,
                style: TextStyle(fontSize: 40),
              )
            ])),
          ),
          Container(
              transform: Matrix4.translationValues(0.0, -100.0, 0.0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color.fromRGBO(47, 40, 40, 0.5), Colors.black])),
              // color: Gradient.lerp(a, b, t),
              child: RichText(
                text: TextSpan(
                  text: _request!.description,
                ),
              ))
        ],
      ),
    );
  }

  Request? defineRequest(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    if (args != null && args is Request) return args;

    return Request(0, "header", "assetName", "description");
  }
}
