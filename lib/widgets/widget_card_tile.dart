import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

class CardTile extends StatelessWidget {
  CardTile(
      {Key key,
      this.avatarText,
      this.avatarColor,
      this.title,
      this.borderColor,
      this.fillColor,
      this.onPressed})
      : super(key: key);

  final String avatarText;
  final Color avatarColor;
  final String title;
  final Color borderColor;
  final Color fillColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onPressed,
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
        elevation: 2,
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: this.fillColor ?? Colors.grey.withOpacity(0.5),
            border: Border(
              right:
                  BorderSide(color: this.borderColor ?? Colors.grey, width: 5),
              top: BorderSide(color: this.borderColor ?? Colors.grey, width: 5),
              left:
                  BorderSide(color: this.borderColor ?? Colors.grey, width: 5),
              bottom:
                  BorderSide(color: this.borderColor ?? Colors.grey, width: 5),
            ),
            borderRadius: BorderRadius.circular(60.0),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundColor: avatarColor != null
                      ? avatarColor
                      : RandomColor().randomColor(
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
              ),
              SizedBox(
                width: 5.0,
              ),
              AutoSizeText(
                this.title ?? '',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
