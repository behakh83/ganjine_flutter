import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ganjine/constants/const_values.dart';
import 'package:ganjine/screens/screen_collections.dart';
import 'package:ganjine/utilities/utility_ganjine_api.dart';
import 'package:ganjine/widgets/widget_index_card.dart';
import 'package:ganjine/widgets/widget_sweet_sheet.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const ARGS_COLLECTIONS_COUNT = 'ARGS_COLLECTIONS_COUNT';
  static const PATH = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> arguments;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => onBuild());
  }

  Future<void> onBuild() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool welcome = (prefs.getBool('welcome') ?? true);
    if (welcome) {
      showAboutUsBottomSheet();
      await prefs.setBool('welcome', false);
    }
  }

  void showAboutUsBottomSheet() {
    GanjineAPI.aboutUs().then((response) {
      SweetSheet().show(
        context: context,
        isDismissible: true,
        description: Text(
          response['about_us'],
          style: TextStyle(
            fontFamily: 'DimaFred',
          ),
        ),
        color: SweetSheetColor.NICE,
        positive: SweetSheetAction(
          title: kStringOk,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        negative: SweetSheetAction(
          title: kStringDevelopers,
          onPressed: () {
            Navigator.pop(context);
            SweetSheet().show(
              context: context,
              isDismissible: true,
              description: Text(
                response['developers'],
                style: TextStyle(
                  fontFamily: 'DimaFred',
                ),
              ),
              color: SweetSheetColor.SUCCESS,
              positive: SweetSheetAction(
                title: kStringOk,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                kStringDevelopers,
                style: TextStyle(
                  fontFamily: 'DimaFred',
                ),
              ),
              icon: FontAwesomeIcons.info,
            );
          },
        ),
        title: Text(
          kStringAboutUs,
          style: TextStyle(
            fontFamily: 'DimaFred',
          ),
        ),
        icon: FontAwesomeIcons.info,
      );
    }).catchError((error) {
      showNoConnectionBottomSheet(context, showAboutUsBottomSheet);
    });
  }

  Future<bool> _onWillPopUp() async {
    showExitBottomSheet(context);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    var collectionsCount = arguments[HomeScreen.ARGS_COLLECTIONS_COUNT];
    return WillPopScope(
      onWillPop: _onWillPopUp,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg_screen_home.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 70.0,
                              bottom: 10.0,
                              right: 30.0,
                              left: 30.0,
                            ),
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: GradientText(
                                'گنجینه',
                                gradient: LinearGradient(
                                  colors: [
                                    kColorPrimaryLight,
                                    kColorPrimaryDark
                                  ],
                                ),
                                style: TextStyle(
                                  fontFamily: 'DimaKhabar2',
                                  color: Colors.black,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 15.0,
                                      color: Colors.black,
                                      offset: Offset(0.3, 0.3),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: IndexCard(
                            avatarText: '7',
                            avatarColor: Colors.amber,
                            title: kStringSeventhQuestions,
                            subTitle: collectionsCount['seventh'] == 0
                                ? kStringNoCollections
                                : collectionsCount['seventh'].toString() +
                                    ' ' +
                                    kStringQuestionCollection,
                            onPressed: collectionsCount['seventh'] == 0
                                ? null
                                : () {
                                    Navigator.pushNamed(
                                        context, CollectionsScreen.PATH,
                                        arguments: {
                                          CollectionsScreen
                                              .ARGS_COLLECTIONS_GRADE: 7
                                        });
                                  },
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Expanded(
                          child: IndexCard(
                            avatarText: '8',
                            avatarColor: Colors.teal,
                            title: kStringEighthQuestions,
                            subTitle: collectionsCount['eighth'] == 0
                                ? kStringNoCollections
                                : collectionsCount['eighth'].toString() +
                                    ' ' +
                                    kStringQuestionCollection,
                            onPressed: collectionsCount['eighth'] == 0
                                ? null
                                : () {
                                    Navigator.pushNamed(
                                        context, CollectionsScreen.PATH,
                                        arguments: {
                                          CollectionsScreen
                                              .ARGS_COLLECTIONS_GRADE: 8
                                        });
                                  },
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Expanded(
                          child: IndexCard(
                            avatarText: '9',
                            avatarColor: Colors.pinkAccent,
                            title: kStringNinthQuestions,
                            subTitle: collectionsCount['ninth'] == 0
                                ? kStringNoCollections
                                : collectionsCount['ninth'].toString() +
                                    ' ' +
                                    kStringQuestionCollection,
                            onPressed: collectionsCount['ninth'] == 0
                                ? null
                                : () {
                                    Navigator.pushNamed(
                                        context, CollectionsScreen.PATH,
                                        arguments: {
                                          CollectionsScreen
                                              .ARGS_COLLECTIONS_GRADE: 9
                                        });
                                  },
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: FlatButton(
                        onPressed: () {
                          showAboutUsBottomSheet();
                        },
                        child: Text(
                          kStringAboutUs,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
