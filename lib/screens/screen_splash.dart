import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ganjine/helpers/helper_assets.dart';
import 'package:ganjine/helpers/helper_http.dart';
import 'package:ganjine/helpers/helper_sweet_sheet.dart';
import 'package:ganjine/screens/screen_home.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  static const PATH = '/';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => onBuild());
  }

  void onBuild() {
    var timeStart = DateTime.now();
    HttpHelper.testConnection().then(
      (status) async {
        if (status) {
          if (DateTime.now()
              .subtract(Duration(seconds: 5))
              .isBefore(timeStart)) {
            await Future.delayed(Duration(seconds: 3));
          }
          HttpHelper.collectionsCount().then(
            (response) async {
              Navigator.popAndPushNamed(context, HomeScreen.PATH,
                  arguments: response);
            },
          ).catchError((error) {
            showNoConnectionDialog(context, onBuild, exitApp: true);
          });
        } else {
          showNoConnectionDialog(context, onBuild, exitApp: true);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage(imageAssetPNG('backgrounds/bg_screen_splash')),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Lottie.asset(
                lottieAssetJSON('lt_loading'),
                height: 100.0,
                width: 100.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
