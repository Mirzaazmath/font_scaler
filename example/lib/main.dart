import 'package:example/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_scaler/font_scaler.dart';

void main() {
  // Need to Wrap MyApp with FontScaler
  runApp(FontScaler(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Need to Add FontScalerProvider.of(context).builder to reflect the changes
      builder: FontScalerProvider.of(context).builder,
      home: HomeScreen(),
    );
  }
}
