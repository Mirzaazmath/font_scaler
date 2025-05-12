<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->
 # FontScaler – Dynamic Text Scaling for Flutter

 FontScaler is a lightweight Flutter package that allows you to dynamically adjust the text scale across your entire app. It supports predefined scale levels (like small, medium, large) and a custom mode for user-defined scaling. Optional persistent storage using SharedPreferences lets you retain the user’s preference across sessions.

## Features

<ul>
    <li>✅ Supports Android,IOS,Web</li>
    <li>✅  Predefined scale levels: micro, small, medium, default, large, xl, etc.</li>
    <li>✅  Custom font scaling (e.g., customValue: 2.25)</li>
    <li>✅ Persist user settings using SharedPreferences</li>
    <li>✅ MediaQuery-aware text scaling</li>
   <li>✅ Easy integration with global access using FontScalerProvider.of(context)</li>
  
</ul>

## Result
<img src ="https://github.com/Mirzaazmath/font_scaler/blob/main/ss/result.gif" height ="400">


## Getting started

In the pubspec.yaml of your flutter project, add the following dependency:

```dart
dependencies:
  ...
  font_scaler: ^1.0.0

```
Import it:

```dart
import 'package:font_scaler/font_scaler.dart';

```


## Usage

1.Initialize in main.dart

```dart
void main()  {
  // Need to Wrap MyApp with FontScaler
  runApp(FontScaler(
    child: MyApp(),
  ));
}

```
2. Pass Builder in Material App
   
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Need to Add FontScalerProvider.of(context).builder to reflect the changes
      builder: FontScalerProvider.of(context).builder,
      home: HomeScreen(),
    );
  }
}
```
3. Update the text scale from anywhere
   
```dart
// default Option
FontScalerProvider.of(context).updateTextScale(FontScale.large);
// Custom option with customValue
FontScalerProvider.of(context).updateTextScale(FontScale.custom, customValue: 2.4);

```

4. Get the current Selected Font Scale type 
   
```dart
// This will return the currentFontScale 
FontScalerProvider.of(context).currentFontScale;

```
   
## Example Use Case

   Let users control font sizes from settings:
   
```dart
ElevatedButton(
  onPressed: () {
    FontScalerProvider.of(context)
        .updateTextScale(FontScale.custom, customValue: 1.25);
  },
  child: Text("Increase Font Size"),
);


```
## Usage With SharedPreferences 

Using SharedPreferences user can save the selected font Scale locally whenever app
restarts it will take the value from local storage 


In the pubspec.yaml of your flutter project, add the following dependency:

```dart
dependencies:
  ...
  font_scaler: ^1.0.0
  shared_preferences: any

```
Import it:

```dart
import 'package:font_scaler/font_scaler.dart';
import 'package:shared_preferences/shared_preferences.dart';

```


1.Initialize in main.dart

```dart
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

```
2. Pass Builder in Material App
   
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Need to Add FontScalerProvider.of(context).builder to reflect the changes
      builder: FontScalerProvider.of(context).builder,
      home: HomeScreen(),
    );
  }
}
```
3. Update the text scale from anywhere
   
```dart
// default Option
FontScalerProvider.of(context).updateTextScale(FontScale.large);
// Custom option with customValue
FontScalerProvider.of(context).updateTextScale(FontScale.custom, customValue: 1.4);

```
4. You can clear the saved font Scale and set it to default
      
```dart
 //  This Will Clear the change and remove from local storage and set back to default fontScale
  FontScalerProvider.of(context).clear();

```

## Support

<a href="https://www.buymeacoffee.com/Mirza_Azmathullah_Baig" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

Star project on  <a href="https://github.com/Mirzaazmath/font_scaler">Github</a>

## Author

<a href="https://github.com/Mirzaazmath" target="_blank"><img src="https://github.com/Mirzaazmath/flutter_60_ui_challange/blob/main/ui_4_watch_store/assets/profile.jpeg" height="60" width ="60"  > </a>

