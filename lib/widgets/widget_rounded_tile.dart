import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

class RoundedTile extends StatelessWidget {
  RoundedTile(
      {Key key,
      this.avatarText,
      this.avatarColor,
      this.title,
      this.borderColor,
      this.onPressed,
      this.feedback})
      : super(key: key);

  final String avatarText;
  final Color avatarColor;
  final String title;
  final Color borderColor;
  final VoidCallback onPressed;
  final bool feedback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: this.feedback ?? true,
      onTap: this.onPressed,
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.only(
            left: 5.0,
            right: 2.0,
          ),
          height: 70,
          decoration: BoxDecoration(
            color: this.borderColor.withOpacity(0.5),
            border: Border(
              right: BorderSide(color: this.borderColor, width: 5),
              top: BorderSide(color: this.borderColor, width: 5),
              left: BorderSide(color: this.borderColor, width: 5),
              bottom: BorderSide(color: this.borderColor, width: 5),
            ),
            borderRadius: BorderRadius.circular(60.0),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28.0,
                backgroundColor: avatarColor ??
                    RandomColor().randomColor(
                        colorSaturation: ColorSaturation.mediumSaturation),
                child: Text(
                  this.avatarText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontFamily: 'DimaKhabar2',
                  ),
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Flexible(
                child: AutoSizeText(
                  this.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
