import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ganjine/constants/const_strings.dart';
import 'package:ganjine/helpers/helper_assets.dart';
import 'package:ganjine/screens/screen_collections.dart';
import 'package:ganjine/widgets/widget_index_tile.dart';
import 'package:sweetsheet/sweetsheet.dart';

class HomeScreen extends StatefulWidget {
  static const PATH = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> _onWillPopUp() async {
    SweetSheet().show(
      context: context,
      description: Text(''),
      color: SweetSheetColor.WARNING,
      positive: SweetSheetAction(
        title: kStringYes,
        onPressed: () {
          SystemNavigator.pop(animated: true);
        },
      ),
      negative: SweetSheetAction(
        title: kStringNo,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(kStringExit),
      icon: Icons.exit_to_app,
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var collectionsCount =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return WillPopScope(
      onWillPop: _onWillPopUp,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage(imageAssetPNG('backgrounds/bg_screen_home')),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
            SafeArea(
              child: Column(
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
                      child: Image.asset(
                        imageAssetPNG('txt_typography'),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: IndexTile(
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
                                    arguments: 7);
                              },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: IndexTile(
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
                                    arguments: 8);
                              },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: IndexTile(
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
                                    arguments: 9);
                              },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
