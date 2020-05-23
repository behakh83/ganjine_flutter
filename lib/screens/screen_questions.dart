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
  List<QuestionState> answersStatus;
  List<int> answers;
  Widget mainLayout = Center(
    child: Lottie.asset(
      lottieAssetJSON('lt_loading'),
    ),
  );
  PageController _questionPageController;

  @override
  void initState() {
    super.initState();
    _questionPageController = PageController();
    WidgetsBinding.instance.addPostFrameCallback((_) => onBuild());
  }

  @override
  void dispose() {
    super.dispose();
    _questionPageController.dispose();
  }

  void onOptionSelected(int option) {
    answers[currentQuestion] = option;
    answersStatus[currentQuestion] = questionData['question_set']
                [currentQuestion]['correct_option'] ==
            option
        ? QuestionState.RIGHT
        : QuestionState.WRONG;
    rebuildMainLayout();
  }

  void rebuildMainLayout() {
    setState(() {
      mainLayout = Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
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
          Expanded(
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  if (answersStatus[currentQuestion] != QuestionState.RIGHT &&
                      answersStatus[currentQuestion] != QuestionState.WRONG) {
                    answersStatus[currentQuestion] = QuestionState.NO_ANSWER;
                  }
                  if (answersStatus[index] != QuestionState.RIGHT &&
                      answersStatus[index] != QuestionState.WRONG) {
                    answersStatus[index] = QuestionState.PENDING;
                  }
                  currentQuestion = index;
                  rebuildMainLayout();
                });
              },
              controller: _questionPageController,
              itemCount: questionData['questions_count'],
              itemBuilder: (context, index) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        questionData['question_set'][index]['question_text'],
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
                      borderColor: answers[index] == 0
                          ? Colors.grey
                          : questionData['question_set'][index]
                                      ['correct_option'] ==
                                  1
                              ? Colors.green
                              : answers[index] == 1 &&
                                      answers[index] !=
                                          questionData['question_set'][index]
                                              ['correct_option']
                                  ? Colors.red
                                  : Colors.grey,
                      title: questionData['question_set'][index]['option1'],
                      onPressed: () {
                        onOptionSelected(1);
                      },
                    ),
                    CardTile(
                      avatarText: kStringOption2,
                      avatarColor: Colors.pink,
                      borderColor: answers[index] == 0
                          ? Colors.grey
                          : questionData['question_set'][index]
                                      ['correct_option'] ==
                                  2
                              ? Colors.green
                              : answers[index] == 2 &&
                                      answers[index] !=
                                          questionData['question_set'][index]
                                              ['correct_option']
                                  ? Colors.red
                                  : Colors.grey,
                      title: questionData['question_set'][index]['option2'],
                      onPressed: () {
                        onOptionSelected(2);
                      },
                    ),
                    CardTile(
                      avatarText: kStringOption3,
                      borderColor: answers[index] == 0
                          ? Colors.grey
                          : questionData['question_set'][index]
                                      ['correct_option'] ==
                                  3
                              ? Colors.green
                              : answers[index] == 3 &&
                                      answers[index] !=
                                          questionData['question_set'][index]
                                              ['correct_option']
                                  ? Colors.red
                                  : Colors.grey,
                      avatarColor: Colors.amber,
                      title: questionData['question_set'][index]['option3'],
                      onPressed: () {
                        onOptionSelected(3);
                      },
                    ),
                    CardTile(
                      avatarText: kStringOption4,
                      borderColor: answers[index] == 0
                          ? Colors.grey
                          : questionData['question_set'][index]
                                      ['correct_option'] ==
                                  4
                              ? Colors.green
                              : answers[index] == 4 &&
                                      answers[index] !=
                                          questionData['question_set'][index]
                                              ['correct_option']
                                  ? Colors.red
                                  : Colors.grey,
                      avatarColor: Colors.deepOrange,
                      title: questionData['question_set'][index]['option4'],
                      onPressed: () {
                        onOptionSelected(4);
                      },
                    ),
                  ],
                ),
              ),
            ),
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
                  for (var i in answersStatus)
                    FaIcon(
                      i == QuestionState.NOT_SEEN
                          ? FontAwesomeIcons.solidCircle
                          : i == QuestionState.NO_ANSWER
                              ? FontAwesomeIcons.solidCircle
                              : i == QuestionState.RIGHT
                                  ? FontAwesomeIcons.checkCircle
                                  : i == QuestionState.WRONG
                                      ? FontAwesomeIcons.timesCircle
                                      : FontAwesomeIcons.circleNotch,
                      size: 20.0,
                      color: i == QuestionState.NOT_SEEN
                          ? Colors.grey.withOpacity(0.5)
                          : i == QuestionState.NO_ANSWER
                              ? Colors.blue
                              : i == QuestionState.RIGHT
                                  ? Colors.green
                                  : i == QuestionState.WRONG
                                      ? Colors.red
                                      : Colors.black,
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
                    if (currentQuestion > 0)
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
                          onPressed: () {
                            _questionPageController.previousPage(
                                duration: Duration(seconds: 1),
                                curve: Curves.ease);
                          },
                        ),
                      ),
                    if (currentQuestion > 0 &&
                        currentQuestion < questionData['questions_count'] - 1)
                      SizedBox(
                        width: 10.0,
                      ),
                    if (currentQuestion < questionData['questions_count'] - 1)
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
                          onPressed: () {
                            _questionPageController.nextPage(
                                duration: Duration(seconds: 1),
                                curve: Curves.ease);
                          },
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
  }

  void onBuild() {
    HttpHelper.collection(questionID).then((response) {
      setState(() {
        questionData = response;
        answersStatus =
            List.filled(response['questions_count'], QuestionState.NOT_SEEN);
        answers = List.filled(response['questions_count'], 0);
        answersStatus[0] = QuestionState.PENDING;
        rebuildMainLayout();
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
