import 'package:flutter/material.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';

  static Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static Color mainColor() {
    return HexColor.hexToColor('#6e937c');
  }

  static Color mainSelectedColor() {
    return HexColor.hexToColor('#0083B3');
  }

  static Color colorGreen() {
    return HexColor.hexToColor('#aaf454');
  }

  static Color colorButton() {
    return HexColor.mainColor();
  }

  static Color colorSeparator() {
    return HexColor.hexToColor('#bebebe');
  }

  static Color colorAnswerNormal() {
    return HexColor.hexToColor('#c4cdc1');
  }

  static Color colorAnswerCorrect() {
    return HexColor.mainColor();
  }

  static Color colorAnswerSelected() {
    return Colors.red[500]!;
  }

  static Color colorAnswerFail() {
    return HexColor.hexToColor('#a02515');
  }

  static Color colorBackGround() {
    return HexColor.hexToColor('#bebebe');
  }

  static Color colorBackGroundResult() {
    return HexColor.hexToColor('#9f2e4b');
  }

  static getMultipleColorFromIndex(int index) {
    switch (index % 5) {
      case 0:
        return HexColor.hexToColor('#ef5362');
        break;
      case 1:
        return HexColor.hexToColor('#00aff0');
        break;
      case 2:
        return HexColor.hexToColor('#ffbe39');
        break;
      case 3:
        return HexColor.hexToColor('#90c357');
        break;
      case 4:
        return HexColor.hexToColor('#ea6eba');
        break;
      case 5:
        return HexColor.hexToColor('#32c09d');
        break;
    }
  }


}
