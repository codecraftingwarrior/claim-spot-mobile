import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainColors {
  static const Color black = Color(0xFF000000);

  static const Color white = Color(0xFFFFFFFF);

  static const Color defaultColor = Color.fromRGBO(136, 136, 136, 1.0);

  static const Color primary = Color.fromRGBO(16, 110, 234, 1.0);

  static const Color secondary = Color.fromRGBO(68, 68, 68, 1.0);

  static const Color label = Color.fromRGBO(254, 36, 114, 1.0);

  static const Color neutral = Color.fromRGBO(255, 255, 255, 0.2);

  static const Color tabs = Color.fromRGBO(222, 222, 222, 0.3);

  static const Color info = Color.fromRGBO(44, 168, 255, 1.0);

  static const Color error = Color.fromRGBO(255, 54, 54, 1.0);

  static const Color success = Color.fromRGBO(24, 206, 15, 1.0);

  static const Color warning = Color.fromRGBO(255, 178, 54, 1.0);

  static const Color text = Color.fromRGBO(44, 44, 44, 1.0);

  static const Color bgColorScreen = Color.fromRGBO(255, 255, 255, 1.0);

  static const Color border = Color.fromRGBO(231, 231, 231, 1.0);

  static const Color inputSuccess = Color.fromRGBO(27, 230, 17, 1.0);

  static const Color input = Color.fromRGBO(220, 220, 220, 1.0);

  static const Color inputError = Color.fromRGBO(255, 54, 54, 1.0);

  static const Color muted = Color.fromRGBO(136, 152, 170, 1.0);

  // static const Color text = Color.fromRGBO(50, 50, 93, 1.0);

  static const Color time = Color.fromRGBO(154, 154, 154, 1.0);

  static const Color priceColor = Color.fromRGBO(234, 213, 251, 1.0);

  static const Color active = Color.fromRGBO(249, 99, 50, 1.0);

  static const Color buttonColor = Color.fromRGBO(156, 38, 176, 1.0);

  static const Color placeholder = Color.fromRGBO(159, 165, 170, 1.0);

  static const Color switchON = Color.fromRGBO(249, 99, 50, 1.0);

  static const Color switchOFF = Color.fromRGBO(137, 137, 137, 1.0);

  static const Color gradientStart = Color.fromRGBO(107, 36, 170, 1.0);

  static const Color gradientEnd = Color.fromRGBO(172, 38, 136, 1.0);

  static const Color socialFacebook = Color.fromRGBO(59, 89, 152, 1.0);

  static const Color socialTwitter = Color.fromRGBO(91, 192, 222, 1.0);

  static const Color socialDribbble = Color.fromRGBO(234, 76, 137, 1.0);

  static const Color bgColorScreen2 = Color.fromRGBO(36, 31, 51, 1.0);
}

InputDecoration standardInputDecoration(
    {String? labelText,
    String? helperText,
    IconData? icon,
    String? hintText,
    bool hasIcon = true}) {
  return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: MainColors.primary),
      helperText: helperText,
      hintText: hintText,
      prefixIcon:
          hasIcon ? Icon(icon, color: MainColors.primary, size: 20.0) : null,
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: MainColors.primary, width: 2.0)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
}

Widget verticalSpace() {
  return SizedBox(
    height: 13.0,
  );
}

IconData? getIcon(String name) {
  Map<String, IconData> icons = {
    'bx bxs-car': FontAwesomeIcons.car,
    'fas fa-truck-moving': FontAwesomeIcons.truckMoving,
    'fas fa-shuttle-van': FontAwesomeIcons.shuttleVan,
    'bx bxs-bus-school': FontAwesomeIcons.bus,
    'fas fa-motorcycle': FontAwesomeIcons.motorcycle,
    'fas fa-car-side': FontAwesomeIcons.carSide
  };
  return icons.containsKey(name) ? icons[name] : null;
}
