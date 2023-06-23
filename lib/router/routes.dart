import 'package:Leela/widgets/home_page/view/home.dart';
import 'package:Leela/widgets/request_card/request_card_screen.dart';
import 'package:Leela/widgets/request_list/view/requests_list_screen.dart';

final routes = {
          "/": (context) => HomePage(),
          "/requests": (context) => ListOfRequest(),
          "/card": (context) => RequestCard(),
        };