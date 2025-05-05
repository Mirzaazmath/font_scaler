import 'package:flutter/material.dart';

/// This Package is develop by MIRZA AZMATHULLAH BAIG.
/// This is the FontScalerProvider class extends with  InheritedWidget which will
/// store the data and can be access from any where.
///
///
/// _FontScalerState is a stateWidget from another class where we have wrote all the logic
/// we can access of code of FontScaler class by _FontScalerState.
/// This play an important role in this package.

/////////// ******* FontScalerProvider Class ******** //////////
class FontScalerProvider extends InheritedWidget {
  /// here we are taking stateWidget as required parameter to access all of the code od that class.
  final _FontScalerState stateWidget;

  /// Constructor
  const FontScalerProvider({
    /// Key
    super.key,

    /// child is the default parameter.
    required super.child,
    required this.stateWidget,
  });

  /// updateShouldNotify this method always notify whenever there is any change.
  @override
  bool updateShouldNotify(FontScalerProvider oldWidget) {
    /// true for always notifying
    return true;
  }

  ///  here is the OF method from which we can access all code from this class and FontScaler.
  static _FontScalerState of(BuildContext context) {
    /// Here we are checking the condition to ensure root widget must be wrap with FontScaler
    if (context
            .dependOnInheritedWidgetOfExactType<FontScalerProvider>()
            ?.stateWidget ==
        null) {
      /// Throwing the custom Error with Solution
      throw ArgumentError(MirzaAppString.initializeError);
    }
    return context
        .dependOnInheritedWidgetOfExactType<FontScalerProvider>()!
        .stateWidget;
  }
}

/////////// ******* FontScaler Class ******** //////////

/// This is the Main Class of where all logic is written.
class FontScaler extends StatefulWidget {
  /// This savePermanent is bool value that define whether we have to store the fontScale locally or not.
  /// if pass true then only it will include the Storage logic.
  final bool? savePermanent;

  ///This savePermanent will help this package to store the fontScale in locally.
  /// Need to pass SharedPreferences Instance here.
  final prefs;

  /// Root Widget need to be pass here.
  final Widget child;

  /// Constructor
  const FontScaler({
    super.key,

    /// To use this package we need to wrap this with root widget.
    required this.child,

    /// bool value
    this.savePermanent,

    /// SharedPreferences Instance.
    this.prefs,
  });

  @override
  State<FontScaler> createState() => _FontScalerState();
}

class _FontScalerState extends State<FontScaler> {
  /// _textScale is the variable that will have the fontScale value.
  /// By default  _textScale value always 1.
  double _textScale = 1;

  /// Default value variable
  final double _default = 1.0;

  /// Created a currentFontScale variable of type FontScale with default value
  FontScale currentFontScale = FontScale.fDefault;

  @override
  void initState() {
    /// This _initScale will  handle the textScale of the our from local Storage .
    _initScale();
    super.initState();
  }

  /////// ****** _initScale ****** //////////
  Future<void> _initScale() async {
    /// At First  checking  savePermanent == true or not.
    if (widget.savePermanent == true) {
      ///
      ////////// ****** Condition ******* /////////////
      ///
      /// Condition Explain :
      /// if User don't want to store the value locally then No Need to use any properties of FontScaler
      /// just Wrap the FontScaler with root Widget that it.
      ///
      /// if User want the font Scale to saved and reuse everyTime then
      /// user need to pass  SharedPreferences Instance in prefs
      /// and savePermanent need to set as true
      /// by doing all this it will store set and and save the font scale
      ///
      ///  At Second checking the  prefs is null or not .
      /// Because SharedPreferences Instance is needed to store the value locally.
      if (widget.prefs == null) {
        /// User forgot to pass the SharedPreferences Instance while setting savePermanent as true
        /// then an error will thrown here with a proper solution to that error.
        /// When ever this error thrown just see the print solution in logs.
        throw FlutterError.fromParts([
          /// Avoid Mess in code all Strings are in different Class MirzaAppString
          /// MirzaAppString to Avoid unnecessary conflicts
          ///
          ///
          /// ErrorSummary contains Error Summary
          ErrorSummary(MirzaAppString.errorSummary),

          /// ErrorSummary contains Error Description
          ErrorDescription(MirzaAppString.errorDescription),

          /// ErrorHint contains Solution to that Error
          ErrorHint(MirzaAppString.errorHint),
        ]);
      } else {
        /// if all conditions Meet like presences of SharedPreferences Instance and  savePermanent == true.
        /// then here  _textScale will change with last saved value instead of default .
        /// if the user did not saved the font Scale then default value automatically assigned
        /// again MirzaAppString.localKey use to avoid conflicts
        _textScale =
            widget.prefs.getDouble(MirzaAppString.localKey) ?? _default;

        /// here we are getting the currentFontScale enum  based on the stored value
        currentFontScale = getFontScaleFromValue(_textScale);
      }
    }
    /// End of savePermanent condition
    else {
      /// If user don't use savePermanent  this code will execute
      /// here no need to reassign that same value but ensure the code must error proof
      /// here _textScale is setting to default

      _textScale = _default;

      /// here setting the currentFontScale  to default
      currentFontScale = FontScale.fDefault;
    }
    setState(() {});
  }

  /////// ****** _saveInLocal ****** //////////
  ///
  /// here _saveInLocal method executes whenever there is new changes in the font Scale
  /// it will save that font Scale into  Local Storage

  void _saveInLocal() async {
    /// checking the condition here if widget.savePermanent == true && widget.prefs!=null  then only
    /// it will store the font scale value locally
    if (widget.savePermanent == true && widget.prefs != null) {
      /// here setting the font Scale in local Storage with localKey to ensure whenever the
      /// app will reopen again with the saved font Scale
      widget.prefs.setDouble(MirzaAppString.localKey, _textScale);
    }
  }

  /////// ****** builder ****** //////////

  /// the builder will automatically get refresh with new font Scale value
  /// whenever there any change happened
  Widget Function(BuildContext, Widget?) get builder {
    /// It will return Widget Function type builder for material App builder
    return (BuildContext context, Widget? widgetChild) {
      final mediaQueryData = MediaQuery.of(context);

      /// All Magic happened here
      return MediaQuery(
        /// here we are updating the TextScaler factor of our mediaQueryData
        data: mediaQueryData.copyWith(
          textScaler: TextScaler.linear(_textScale),
        ),
        child: widgetChild ?? const SizedBox.shrink(),
      );
    };
  }

  /////// ****** updateFontScale ****** //////////
  /// updateFontScale method updates _textScale and force the builder to get rebuild to adapt the changes
  ///  updateFontScale takes to parameters one is for FontScale and other for customValue
  ///  customValue is need only when user select the FontScale type of Custom
  void updateFontScale(FontScale scale, {double? customValue}) {
    setState(() {
      /// Condition checked here if user select Custom type from enum then must need to provide customValue as double
      if (scale == FontScale.custom) {
        if (customValue == null) {
          /// trowing ArgumentError with solution in it
          /// again MirzaAppString is used to avoid conflicts
          throw ArgumentError(MirzaAppString.customValueError);
        }

        /// Setting the customValue
        _textScale = customValue;

        /// Setting the currentFontScale to FontScale.custom
        currentFontScale = FontScale.custom;
      } else {
        /// Setting the FontScale from fontScaleMap which hold the actual value of that enum
        /// fontScaleMap is map with type <FontScale, double> it return the double value of the given  enum
        _textScale = fontScaleMap[scale]!;

        /// Setting the currentFontScale with given Scale
        currentFontScale = scale;
      }
    });

    /// Calling the _saveInLocal method  to store the fontScale  locally
    _saveInLocal();
  }

  /////// ****** clear ****** //////////
  /// clear method will clear all setting and set _textScale default
  void clear() async {
    _textScale = _default;
    currentFontScale = FontScale.fDefault;

    /// if the user select the savePermanent then here we are clearing the widget.prefs
    if (widget.prefs != null && widget.savePermanent == true) {
      await widget.prefs.remove(MirzaAppString.localKey);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    /////// ****** Return Widget ****** //////////
    /// here FontScalerProvider it return with the given child {root Widget} and passes stateWidget for FontScalerProvider
    /// to Access all the code from this class also
    return FontScalerProvider(stateWidget: this, child: widget.child);
  }
}

/////// ****** String Class ****** //////////

class MirzaAppString {
  static final String errorSummary = "Missing SharedPreferences instance";
  static final String errorDescription =
      "You must provide a SharedPreferences instance when using savePermanent: true.";
  static final String errorHint =
      'Solution :\n'
      'void main() async {      // add async \n'
      '  WidgetsFlutterBinding.ensureInitialized();    // add this line here \n'
      '  final prefs = await SharedPreferences.getInstance();    // create SharedPreferences Instance  \n'
      '  runApp(FontScaler(\n'
      '    prefs: prefs,      // pass here  \n'
      '    savePermanent: true,      // only when savePermanent== true \n'
      '    child: MyApp(),\n'
      '  ));\n'
      '}';
  static final String localKey = "MirzaTextScale";
  static final String initializeError =
      "The root class must be wrap with FontScaler\nSolution:\n"
      'void main(){\n'
      '  runApp(FontScaler(\n'
      '    child: MyApp(),\n'
      '  ));\n'
      '}';
  static final String customValueError =
      "customValue must be provided when using FontScale.custom\n Ex: == FontScalerProvider.of(context).updateTextScale(FontScale.custom,customValue:2.0);";
}

/////// ****** enum ****** //////////
/// here one enum has created for fontScaling the with predefined values below in map
/// and also have the custom for customization of the font Scale from userEnd
enum FontScale {
  ultraMicro,
  micro,
  extraSmall,
  small,
  medium,
  fDefault,
  large,
  extraLarge,
  doubleXL,
  ultraXL,
  custom,
}

/////// ****** Value Map ****** //////////
/// fontScaleMap will store the value of the Font Scale
Map<FontScale, double> fontScaleMap = {
  FontScale.ultraMicro: 0.4,
  FontScale.micro: 0.5,
  FontScale.extraSmall: 0.6,
  FontScale.small: 0.8,
  FontScale.medium: 0.9,
  FontScale.fDefault: 1.0,
  FontScale.large: 1.4,
  FontScale.extraLarge: 1.6,
  FontScale.doubleXL: 1.8,
  FontScale.ultraXL: 2.0,
};
/////// ****** getFontScaleFromValue ****** //////////
/// this will return the key based on  the value if the value not exist then it return custom
FontScale getFontScaleFromValue(double value) {
  return fontScaleMap.entries
      .firstWhere(
        (entry) => entry.value == value,
        orElse: () => const MapEntry(FontScale.custom, -1),
      )
      .key;
}
