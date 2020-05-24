import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ganjine/constants/const_values.dart';
import 'package:ganjine/screens/screen_questions.dart';
import 'package:ganjine/utilities/utility_ganjine_api.dart';
import 'package:ganjine/widgets/widget_rounded_tile.dart';
import 'package:ganjine/widgets/widget_sweet_sheet.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:lottie/lottie.dart';

class CollectionsScreen extends StatefulWidget {
  static const PATH = '/collections';
  static const ARGS_COLLECTIONS_GRADE = 'ARGS_COLLECTIONS_GRADE';

  @override
  _CollectionsScreenState createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  bool loading = true;
  var listCount = 1;
  Map<String, dynamic> response;
  int grade;
  Map<String, dynamic> arguments;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => onBuild());
  }

  void onBuild() {
    GanjineAPI.collectionList(grade).then((response) {
      setState(() {
        loading = false;
        this.response = response;
      });
    }).catchError((error) {
      showNoConnectionBottomSheet(context, onBuild);
    });
  }

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments;
    grade = arguments[CollectionsScreen.ARGS_COLLECTIONS_GRADE];
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_screen_$grade.png'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(40.0),
                    child: Text(''),
                  ),
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  floating: true,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FittedBox(
                      fit: BoxFit.fitHeight,
                      child: GradientText(
                        grade == 7 ? 'هفتم' : grade == 8 ? 'هشتم' : 'نهم',
                        gradient: LinearGradient(
                          colors: [kColorPrimaryLight, kColorPrimaryDark],
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
                  expandedHeight: 150.0,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return loading
                          ? Lottie.asset('assets/lottie/lt_loading.json')
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: RoundedTile(
                                borderColor: Colors.grey,
                                avatarText: response['results'][index]
                                        ['questions_count']
                                    .toString(),
                                title: response['results'][index]['name'],
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, QuestionsScreen.PATH,
                                      arguments: {
                                        QuestionsScreen.ARGS_COLLECTION_ID:
                                            response['results'][index]['id']
                                      });
                                },
                              ),
                            );
                    },
                    childCount: loading == true ? 1 : response['count'],
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
