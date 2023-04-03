import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:insurance_mobile_app/shared/constant/theme.dart';

class AppProgressIndicator extends StatelessWidget {
  final double size;
  final Color color;
  const AppProgressIndicator({Key? key, this.size = 150.0, this.color = MainColors.primary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitSpinningLines(
          color: color,
          size: size,
            duration: Duration(milliseconds: 2000),
        )
    );
  }
}
