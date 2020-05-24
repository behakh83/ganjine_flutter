import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ganjine/constants/const_values.dart';
import 'package:ganjine/utilities/utility_ganjine_api.dart';
import 'package:ganjine/widgets/widget_rounded_tile.dart';
import 'package:ganjine/widgets/widget_sweet_sheet.dart';
import 'package:lottie/lottie.dart';
import 'package:soundpool/soundpool.dart';

class QuestionsScreen extends StatefulWidget {
  static const PATH = '/questions';
  static const ARGS_COLLECTION_ID = 'ARGS_COLLECTION_ID';

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  bool loading = true;
  Map<String, dynamic> response;
  PageController _pageController;
  List<int> answers;
  Map<String, dynamic> arguments;
  Soundpool pool = Soundpool(streamType: StreamType.notification);
  var correctSoundId;
  var wrongSoundId;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => onBuild());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onBuild() {
    GanjineAPI.collection(arguments[QuestionsScreen.ARGS_COLLECTION_ID])
        .then((response) async {
      correctSoundId = await rootBundle
          .load("assets/sounds/correct.wav")
          .then((ByteData soundData) {
        return pool.load(soundData);
      });
      wrongSoundId = await rootBundle
          .load("assets/sounds/wrong.wav")
          .then((ByteData soundData) {
        return pool.load(soundData);
      });
      setState(() {
        loading = false;
        this.response = response;
        answers = List.filled(response['questions_count'], 0);
      });
    }).catchError((error) {
      showNoConnectionBottomSheet(context, onBuild);
    });
  }

  Color getOptionBorderColor(int option, int index) {
    return answers[index] == option &&
            response['question_set'][index]['correct_option'] != option
        ? Colors.red
        : answers[index] == option &&
                response['question_set'][index]['correct_option'] == option
            ? Colors.green
            : answers[index] != 0 &&
                    answers[index] != option &&
                    response['question_set'][index]['correct_option'] == option
                ? Colors.green
                : Colors.grey;
  }

  void onOptionSelected(int option, int index) {
    answers[index] = option;
    if (response['question_set'][index]['correct_option'] == option)
      pool.play(correctSoundId);
    else
      pool.play(wrongSoundId);
  }

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_screen_questions.png'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          SafeArea(
            child: loading
                ? Center(
                    child: Lottie.asset('assets/lottie/lt_loading.json'),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 20.0, right: 20.0),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            response['name'],
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
                      ),
                      Flexible(
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: response['questions_count'],
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  AutoSizeText(
                                    response['question_set'][index]
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
                                  RoundedTile(
                                    feedback: false,
                                    title: response['question_set'][index]
                                        ['option1'],
                                    avatarText: 1.toString(),
                                    avatarColor: Colors.teal,
                                    onPressed: () {
                                      setState(() {
                                        onOptionSelected(1, index);
                                      });
                                    },
                                    borderColor: getOptionBorderColor(1, index),
                                  ),
                                  RoundedTile(
                                    feedback: false,
                                    title: response['question_set'][index]
                                        ['option2'],
                                    avatarText: 2.toString(),
                                    avatarColor: Colors.orange,
                                    onPressed: () {
                                      setState(() {
                                        onOptionSelected(2, index);
                                      });
                                    },
                                    borderColor: getOptionBorderColor(2, index),
                                  ),
                                  RoundedTile(
                                    feedback: false,
                                    title: response['question_set'][index]
                                        ['option3'],
                                    avatarText: 3.toString(),
                                    avatarColor: Colors.pink,
                                    onPressed: () {
                                      setState(() {
                                        onOptionSelected(3, index);
                                      });
                                    },
                                    borderColor: getOptionBorderColor(3, index),
                                  ),
                                  RoundedTile(
                                    feedback: false,
                                    title: response['question_set'][index]
                                        ['option4'],
                                    avatarText: 4.toString(),
                                    avatarColor: Colors.blue,
                                    onPressed: () {
                                      setState(() {
                                        onOptionSelected(4, index);
                                      });
                                    },
                                    borderColor: getOptionBorderColor(4, index),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                direction: Axis.horizontal,
                                spacing: 3.0,
                                alignment: WrapAlignment.center,
                                runAlignment: WrapAlignment.center,
                                children: [
                                  for (var i in answers)
                                    FaIcon(
                                      i == 0
                                          ? FontAwesomeIcons.solidCircle
                                          : i ==
                                                  response['question_set']
                                                          [answers.indexOf(i)]
                                                      ['correct_option']
                                              ? FontAwesomeIcons
                                                  .solidCheckCircle
                                              : i !=
                                                      response['question_set'][
                                                              answers
                                                                  .indexOf(i)]
                                                          ['correct_option']
                                                  ? FontAwesomeIcons
                                                      .solidTimesCircle
                                                  : FontAwesomeIcons
                                                      .solidCircle,
                                      color: i == 0
                                          ? Colors.blue
                                          : i ==
                                                  response['question_set']
                                                          [answers.indexOf(i)]
                                                      ['correct_option']
                                              ? Colors.green.shade700
                                              : i !=
                                                      response['question_set'][
                                                              answers
                                                                  .indexOf(i)]
                                                          ['correct_option']
                                                  ? Colors.redAccent
                                                  : Colors.blue,
                                    )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedContainer(
                                  duration: Duration(
                                    milliseconds: 300,
                                  ),
                                  curve: Curves.ease,
                                  width: !_pageController.hasClients
                                      ? 0
                                      : _pageController.hasClients &&
                                              _pageController.page.round() == 0
                                          ? 0
                                          : _pageController
                                                      .page
                                                      .roundToDouble() ==
                                                  response['questions_count'] -
                                                      1
                                              ? MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  30
                                              : _pageController.page
                                                          .roundToDouble() >
                                                      0
                                                  ? MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.5 -
                                                      30
                                                  : 0,
                                  child: FlatButton(
                                    color: Colors.red,
                                    textColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                    child: FittedBox(
                                      fit: BoxFit.fitHeight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          kStringPrevious,
                                          style: TextStyle(
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      _pageController.previousPage(
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.ease);
                                    },
                                  ),
                                ),
                                if (_pageController.hasClients &&
                                    _pageController.page.roundToDouble() > 0 &&
                                    _pageController.page.roundToDouble() <
                                        response['questions_count'] - 1)
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                  width: !_pageController.hasClients &&
                                          response['questions_count'] == 1
                                      ? 0
                                      : !_pageController.hasClients
                                          ? MediaQuery.of(context).size.width -
                                              30
                                          : response['questions_count'] == 1
                                              ? 0
                                              : _pageController.page
                                                          .roundToDouble() ==
                                                      0
                                                  ? MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      30
                                                  : _pageController.page
                                                              .roundToDouble() <
                                                          response[
                                                                  'questions_count'] -
                                                              1
                                                      ? MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5 -
                                                          30
                                                      : 0,
                                  child: FlatButton(
                                    color: Colors.green,
                                    textColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                    child: FittedBox(
                                      fit: BoxFit.fitHeight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          kStringNext,
                                          style: TextStyle(
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      _pageController.nextPage(
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.ease);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
