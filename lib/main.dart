import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ganjine/constants/const_theme.dart';
import 'package:ganjine/screens/screen_asplsh.dart';

main() => runApp(GanjineApp());

class GanjineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Init app locale
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('fa', 'IR'),
      ],
      locale: Locale('fa', 'IR'),

      theme: kThemeApp,

      home: SplashScreen(),
    );
  }
}
