import 'package:flutter/material.dart';
import 'package:ganjine/helpers/helper_assets.dart';
import 'package:lottie/lottie.dart';

class QuestionsScreen extends StatefulWidget {
  static const PATH = '/questions';

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  bool visibilityLoading = true;
  int questionId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => onBuild());
  }

  void onBuild() {}

  @override
  Widget build(BuildContext context) {
    questionId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    imageAssetPNG('backgrounds/bg_screen_questions')),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          Visibility(
            visible: visibilityLoading,
            child: Center(
              child: Expanded(
                child: Lottie.asset(
                  lottieAssetJSON('lt_loading'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
