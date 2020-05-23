import 'package:flutter/material.dart';
import 'package:ganjine/constants/const_strings.dart';
import 'package:sweetsheet/sweetsheet.dart';

void showNoConnectionDialog(BuildContext context, VoidCallback callback) {
  SweetSheet().show(
    context: context,
    description: Text(kStringRequiredInternet),
    color: SweetSheetColor.DANGER,
    positive: SweetSheetAction(
      title: kStringRetry,
      onPressed: () {
        Navigator.pop(context);
        callback();
      },
    ),
    title: Text(kStringNoInternet),
    icon: Icons.signal_wifi_off,
  );
}
