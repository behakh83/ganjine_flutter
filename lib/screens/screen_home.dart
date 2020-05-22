import 'package:flutter/material.dart';
import 'package:ganjine/constants/const_strings.dart';
import 'package:ganjine/helpers/helper_assets.dart';
import 'package:ganjine/widgets/widget_index_tile.dart';

class HomeScreen extends StatefulWidget {
  static const PATH = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageAssetPNG('backgrounds/bg_screen_home')),
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
                      subTitle: '' + kStringQuestionCollection,
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
                      subTitle: '' + kStringQuestionCollection,
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
                      subTitle: '' + kStringQuestionCollection,
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
    );
  }
}
