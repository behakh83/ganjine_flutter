import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ganjine/constants/const_values.dart';
import 'package:ganjine/screens/screen_home.dart';
import 'package:ganjine/utilities/utility_ganjine_api.dart';
import 'package:ganjine/widgets/widget_sweet_sheet.dart';
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
    GanjineAPI.testConnection().then(
      (response) async {
        if (response['status']) {
          if (DateTime.now()
              .subtract(Duration(seconds: 3))
              .isBefore(timeStart)) {
            await Future.delayed(Duration(seconds: 1));
          }
          GanjineAPI.collectionsCount().then(
            (response) async {
              Navigator.popAndPushNamed(context, HomeScreen.PATH,
                  arguments: {HomeScreen.ARGS_COLLECTIONS_COUNT: response});
            },
          ).catchError((error) {
            throw NoConnectionException(error);
          });
        } else {
          SweetSheet().show(
            context: context,
            isDismissible: false,
            description: Text(response['message']),
            color: SweetSheetColor.WARNING,
            positive: SweetSheetAction(
              title: kStringExitMessage,
              onPressed: () {
                SystemNavigator.pop(animated: true);
              },
            ),
            title: Text(kStringNoInternet),
            icon: Icons.exit_to_app,
            onBackPressed: () async {
              SystemNavigator.pop(animated: true);
              return false;
            },
          );
        }
      },
    ).catchError((error) {
      showNoConnectionBottomSheet(context, onBuild, onBackExit: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_screen_splash.png'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Lottie.asset(
                'assets/lottie/lt_loading.json',
                height: 150.0,
                width: 150.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                kStringSplashScreenDeveloper,
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Roboto',
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
