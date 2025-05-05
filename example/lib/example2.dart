import 'package:example/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_scaler/font_scaler.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main()async{ // Make this Async
  // Add this Line
  WidgetsFlutterBinding.ensureInitialized();
  // Create SharedPreferences Instance
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  // Need to Wrap MyApp with FontScaler
  runApp(FontScaler(
    // savePermanent will save the selected fontScale locally
    // savePermanent work with  SharedPreferences Instance
    // So Whenever the app reopens the font Scale will be same as user selected last time
    savePermanent: true,
      // Need to pass SharedPreferences Instance that will use in storing the data locally
      prefs: prefs,
      child: MyApp()));
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
