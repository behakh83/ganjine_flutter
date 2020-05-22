import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ganjine/utilitis.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
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
