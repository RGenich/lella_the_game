import 'package:flutter/material.dart';

final theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(background: Color.fromRGBO(1, 1, 6, 1),secondary: Colors.blue),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 20,
      ),
      bodyMedium: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold
          ),
      bodySmall: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 14
      ),
      headlineLarge: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 18,
          color: Colors.white,
          letterSpacing: 2.0,
          fontWeight: FontWeight.bold
      ),
    ));
