import 'package:flutter/material.dart';
import 'package:ganjine/constants/conts_colors.dart';

class IndexTile extends StatelessWidget {
  IndexTile(
      {this.avatarText,
      this.avatarColor,
      this.title,
      this.subTitle,
      this.onPressed});

  final String avatarText;
  final Color avatarColor;
  final String title;
  final String subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: this.onPressed,
          child: Container(
            padding: EdgeInsets.only(right: 20.0),
            height: 124.0,
            margin: new EdgeInsets.only(left: 40.0),
            decoration: new BoxDecoration(
              color: new Color(0xFF333366),
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    this.title,
                    style: TextStyle(
                      color: kColorPrimaryLight,
                      fontSize: 30.0,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    this.subTitle,
                    style: TextStyle(
                      color: kColorPrimaryDark,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: CircleAvatar(
            radius: 40.0,
            backgroundColor: this.avatarColor,
            child: Text(
              this.avatarText,
              style: TextStyle(
                fontFamily: 'DimaKhabar2',
                fontSize: 40.0,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
