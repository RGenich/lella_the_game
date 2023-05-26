import 'package:Leela/features/home_page/view/home.dart';
import 'package:Leela/features/request_card/widgets/request_card.dart';
import 'package:Leela/features/request_list/view/requests_list_screen.dart';

final routes = {
          "/": (context) => HomePage(),
          "/requests": (context) => ListOfRequest(),
          "/card": (context) => RequestCard(),
        };