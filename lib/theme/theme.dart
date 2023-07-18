import 'package:flutter/material.dart';

final theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(secondary: Colors.blue),
    textTheme: TextTheme(
        bodyLarge: TextStyle(fontSize: 20, ),
        bodyMedium: TextStyle(fontWeight: FontWeight.bold),
        bodySmall: TextStyle(fontSize: 14),
        headlineLarge: TextStyle(
            letterSpacing: 4.0,
            fontWeight: FontWeight.bold
        ),
    )
);
