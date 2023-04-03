import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomProgressIndicator extends StatefulWidget {

  @override
  _CustomProgressIndicatorState createState() => _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitSpinningLines(
          color: Colors.white,
          size: 150.0,
          duration: Duration(milliseconds: 1500),
        )
    );
  }
}
