import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ganjine/helpers/helper_assets.dart';
import 'package:ganjine/helpers/helper_http.dart';
import 'package:ganjine/helpers/helper_ui.dart';
import 'package:ganjine/screens/scree_questions.dart';
import 'package:lottie/lottie.dart';
import 'package:random_color/random_color.dart';

class CollectionsScreen extends StatefulWidget {
  static const PATH = '/collections';

  @override
  _CollectionsScreenState createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  var listCount = 1;
  Widget Function(int) listBuilder =
      (index) => Lottie.asset(lottieAssetJSON('lt_loading'));
  var grade;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => onBuild());
  }

  void onBuild() {
    HttpHelper.collectionList(grade).then((response) {
      setState(() {
        listCount = response['count'];
        listBuilder = (index) => InkWell(
              onTap: () {
                Navigator.pushNamed(context, QuestionsScreen.PATH,
                    arguments: response['results'][index]['id']);
              },
              child: Card(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
                elevation: 2,
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    border: Border(
                      right: BorderSide(color: Colors.grey, width: 5),
                      top: BorderSide(color: Colors.grey, width: 5),
                      left: BorderSide(color: Colors.grey, width: 5),
                      bottom: BorderSide(color: Colors.grey, width: 5),
                    ),
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundColor: RandomColor().randomColor(
                              colorSaturation:
                                  ColorSaturation.mediumSaturation),
                          child: Text(
                            response['results'][index]['questions_count']
                                .toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontFamily: 'DimaKhabar2',
                            ),
                          ),
                        ),
                      ),
                      AutoSizeText(
                        response['results'][index]['name'],
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      )
                    ],
                  ),
                ),
              ),
            );
      });
    }).catchError((error) {
      showNoConnectionDialog(context, onBuild);
    });
  }

  @override
  Widget build(BuildContext context) {
    grade = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage(imageAssetPNG('backgrounds/bg_screen_$grade')),
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
                    // Add this code
                    preferredSize: Size.fromHeight(40.0), // Add this code
                    child: Text(''), // Add this code
                  ),
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  floating: true,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      imageAssetPNG('txt_title_$grade'),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  expandedHeight: 150.0,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => listBuilder(index),
                    childCount: listCount,
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
