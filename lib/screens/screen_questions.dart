import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ganjine/constants/const_strings.dart';
import 'package:ganjine/constants/conts_colors.dart';
import 'package:ganjine/helpers/helper_assets.dart';
import 'package:ganjine/helpers/helper_http.dart';
import 'package:ganjine/helpers/helper_sweet_sheet.dart';
import 'package:ganjine/widgets/widget_card_tile.dart';
import 'package:lottie/lottie.dart';

enum QuestionState {
  PENDING,
  NOT_SEEN,
  NO_ANSWER,
  RIGHT,
  WRONG,
}

class QuestionsScreen extends StatefulWidget {
  static const PATH = '/questions';

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int questionID;
  Map<String, dynamic> questionData;
  int currentQuestion = 0;
  List<QuestionState> answers;
  Widget mainLayout = Center(
    child: Lottie.asset(
      lottieAssetJSON('lt_loading'),
    ),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => onBuild());
  }

  void onBuild() {
    HttpHelper.collection(questionID).then((response) {
      setState(() {
        questionData = response;
        answers =
            List.filled(response['questions_count'], QuestionState.NOT_SEEN);
        answers[0] = QuestionState.PENDING;
        mainLayout = Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                questionData['name'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 50.0,
                  fontFamily: 'DimaKhabar2',
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: <Color>[
                        kColorPrimaryDark,
                        kColorPrimaryLight,
                      ],
                    ).createShader(
                      Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                    ),
                  shadows: [
                    Shadow(
                      blurRadius: 25.0,
                      color: Colors.black,
                      offset: Offset(5.0, 5.0),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    questionData['question_set'][currentQuestion]
                        ['question_text'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      shadows: [
                        Shadow(
                          blurRadius: 25.0,
                          color: Colors.black,
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                CardTile(
                  avatarText: kStringOption1,
                  avatarColor: Colors.teal,
                  title: questionData['question_set'][currentQuestion]
                      ['option1'],
                ),
                CardTile(
                  avatarText: kStringOption2,
                  avatarColor: Colors.pink,
                  title: questionData['question_set'][currentQuestion]
                      ['option2'],
                ),
                CardTile(
                  avatarText: kStringOption3,
                  avatarColor: Colors.amber,
                  title: questionData['question_set'][currentQuestion]
                      ['option3'],
                ),
                CardTile(
                  avatarText: kStringOption4,
                  avatarColor: Colors.deepOrange,
                  title: questionData['question_set'][currentQuestion]
                      ['option4'],
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 3.0,
                  runSpacing: 3.0,
                  alignment: WrapAlignment.center,
                  children: [
                    for (var i in answers)
                      FaIcon(
                        i == QuestionState.PENDING
                            ? FontAwesomeIcons.circleNotch
                            : i == QuestionState.NOT_SEEN
                                ? FontAwesomeIcons.solidCircle
                                : i == QuestionState.NO_ANSWER
                                    ? FontAwesomeIcons.solidCircle
                                    : i == QuestionState.RIGHT
                                        ? FontAwesomeIcons.checkCircle
                                        : FontAwesomeIcons.timesCircle,
                        size: 20.0,
                        color: i == QuestionState.PENDING
                            ? Colors.black
                            : i == QuestionState.NOT_SEEN
                                ? Colors.grey.withOpacity(0.5)
                                : i == QuestionState.NO_ANSWER
                                    ? Colors.blue
                                    : i == QuestionState.RIGHT
                                        ? Colors.green
                                        : Colors.red,
                      )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 50.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: FlatButton(
                          color: Colors.red,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Text(
                            kStringPrevious,
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: FlatButton(
                          color: Colors.green,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Text(
                            kStringNext,
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        );
      });
    }).catchError((error) {
      showNoConnectionDialog(context, onBuild);
    });
  }

  @override
  Widget build(BuildContext context) {
    questionID = ModalRoute.of(context).settings.arguments;
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
          SafeArea(
            child:
                Padding(padding: const EdgeInsets.all(8.0), child: mainLayout),
          ),
        ],
      ),
    );
  }
}
