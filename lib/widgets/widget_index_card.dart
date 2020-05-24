import 'package:flutter/material.dart';
import 'package:ganjine/constants/const_values.dart';

class IndexCard extends StatelessWidget {
  IndexCard(
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
            padding: EdgeInsets.only(
              right: 20.0,
              left: 100.0,
              bottom: 5.0,
            ),
            margin: EdgeInsets.only(left: 40.0),
            decoration: BoxDecoration(
              color: Color(0xFF333366),
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.circular(8.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    this.title,
                    style: TextStyle(
                      color: kColorPrimaryLight,
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
        ),
      ],
    );
  }
}
