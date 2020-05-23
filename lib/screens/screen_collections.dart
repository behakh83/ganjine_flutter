import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ganjine/helpers/helper_assets.dart';
import 'package:ganjine/helpers/helper_http.dart';
import 'package:ganjine/helpers/helper_sweet_sheet.dart';
import 'package:ganjine/screens/screen_questions.dart';
import 'package:ganjine/widgets/widget_card_tile.dart';
import 'package:lottie/lottie.dart';

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
        listBuilder = (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CardTile(
                avatarText:
                    response['results'][index]['questions_count'].toString(),
                title: response['results'][index]['name'],
                onPressed: () {
                  Navigator.pushNamed(context, QuestionsScreen.PATH,
                      arguments: response['results'][index]['id']);
                },
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
