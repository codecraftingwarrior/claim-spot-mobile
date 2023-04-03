import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notifier {
  final BuildContext _context;
  final double snackBarWidth = MediaQueryData.fromWindow(window).size.width - 93;

  Notifier.of(BuildContext context) : _context = context;

  error({required String message, GlobalKey<ScaffoldMessengerState>? messengerKey}) {
    var messenger = messengerKey != null ? messengerKey.currentState : ScaffoldMessenger.of(_context);
    messenger!.showSnackBar(SnackBar(
        content: Row(
          children: <Widget>[
            Icon(Icons.report, color: Colors.white, size: 30.0),
            SizedBox(width: 10.0),
            Container(
              width: snackBarWidth,
              child: Text(
                message,
                style: TextStyle(fontSize: 17.0, overflow: TextOverflow.clip),
              ),
            )
          ],
        ),
        backgroundColor: Colors.red[600],
        elevation: 5.0,
        behavior: SnackBarBehavior.floating,
        padding:
            EdgeInsets.only(top: 3.0, bottom: 3.0, left: 11.0, right: 11.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        )));
  }

  success({required String message, GlobalKey<ScaffoldMessengerState>? messengerKey}) {
    var messenger = messengerKey != null ? messengerKey.currentState : ScaffoldMessenger.of(_context);
    messenger!.showSnackBar(SnackBar(
        content: Row(
          children: <Widget>[
            Icon(Icons.check_circle, color: Colors.white, size: 30.0),
            SizedBox(width: 10.0),
            Container(
              width: snackBarWidth,
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17.0, overflow: TextOverflow.clip),
              ),
            )
          ],
        ),
        backgroundColor: Colors.green[600],
        elevation: 5.0,
        behavior: SnackBarBehavior.floating,
        padding:
            EdgeInsets.only(top: 3.0, bottom: 3.0, left: 11.0, right: 11.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        )));
  }

  warning({required String message, GlobalKey<ScaffoldMessengerState>? messengerKey}) {
    var messenger = messengerKey != null ? messengerKey.currentState : ScaffoldMessenger.of(_context);
    messenger!.showSnackBar(SnackBar(
        content: Row(
          children: <Widget>[
            Icon(Icons.warning, color: Colors.white, size: 30.0),
            SizedBox(width: 10.0),
            Container(
              width: snackBarWidth,
              child: Text(
                message,
                style: TextStyle(fontSize: 17.0, overflow: TextOverflow.clip),
              ),
            )
          ],
        ),
        backgroundColor: Colors.yellow[800],
        elevation: 5.0,
        behavior: SnackBarBehavior.floating,
        padding:
            EdgeInsets.only(top: 3.0, bottom: 3.0, left: 11.0, right: 11.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        )));
  }
}
