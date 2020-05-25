import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ganjine/screens/screen_questions.dart';
import 'package:ganjine/screens/screen_collections.dart';
import 'package:ganjine/screens/screen_splash.dart';
import 'package:ganjine/screens/screen_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(GanjineApp());
}

class GanjineApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('fa', 'IR'),
      ],
      locale: Locale('fa', 'IR'),
      theme: ThemeData(
        fontFamily: 'DimaFred',
      ),
      initialRoute: '/',
      routes: {
        SplashScreen.PATH: (context) => SplashScreen(),
        HomeScreen.PATH: (context) => HomeScreen(),
        CollectionsScreen.PATH: (context) => CollectionsScreen(),
        QuestionsScreen.PATH: (context) => QuestionsScreen(),
      },
    );
  }
}
