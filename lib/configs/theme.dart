import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static showToast(final String messages) {
    Fluttertoast.showToast(
        msg: messages,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundBaseBlue,
        textColor: baseTextWhite,
        fontSize: 14.0);
  }

  static Color colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  static int randomInt() {
    return Random().nextInt(99);
  }
}

final fontFamily = GoogleFonts.poppins().fontFamily;

const Color baseAppBasic = Color(0xFFFFFFFF);
const Color baseAppPremium = Color(0xFFFFFFFF);

const Color navigationMenuDefault = Color(0xFF999999);
const Color navigationMenuSelected = Color(0xFF1dba9d);

const Color baseTextBlackDark = Color(0xFF161819);
const Color baseTextBlackLight = Color(0xFF474747);
const Color baseTextWhite = Color(0xFFFFFFFF);
const Color baseTextApp = Color(0xFFFF0000);

const Color backgroundBaseWhite = Color(0xFFFFFFFF);
const Color backgroundBaseBlue = Color(0xFF0876fd);
const Color backgroundBaseApp = Color(0xFFFF0000);
const Color backgroundBaseDark = Color(0xFFcccccc);
const Color backgroundBaseLight = Color(0xFFf2f2f2);

const Color backgroundBaseOrangeGradientBottom = Color(0xFFF45F0B);
const Color backgroundBaseOrangeGradientCenter = Color(0x33F45F0B);
const Color backgroundBaseOrangeGradientTop = Color(0x00F45F0B);

const double paddingSize = 28.0;
const double spaceIcon = 18.0;
const double witdhIcon = 80.0;
const double tabIconSize = 18.0;
const double paddingDefault = 8.0;
const double paddingNormal = 12.0;
const double paddingWide = 16.0;
const double paddingExtraWide = 24.0;
const double paddingXXWide = 32.0;
const double paddingLarge = 48.0;

const double heightDivider12 = 12.0;
const double radiusInput = 20.0;
const double iconSize = 19.0;
const int ratioSize = 25;
const int ratioSmallSize = 20;
const int ratioSmallerSize = 15;

const EdgeInsets padding5 = EdgeInsets.all(5);
const EdgeInsets padding6 = EdgeInsets.all(6);
const EdgeInsets padding8 = EdgeInsets.all(8);
const EdgeInsets padding10 = EdgeInsets.all(10);
const EdgeInsets padding12 = EdgeInsets.all(12);
const EdgeInsets padding16 = EdgeInsets.all(16);
const EdgeInsets padding20 = EdgeInsets.all(20);
const EdgeInsets padding24 = EdgeInsets.all(24);
const EdgeInsets padding32 = EdgeInsets.all(32);
const EdgeInsets padding48 = EdgeInsets.all(48);

const SizedBox spaceHeight2 = SizedBox(height: 2);
const SizedBox spaceHeight4 = SizedBox(height: 4);
const SizedBox spaceHeight5 = SizedBox(height: 5);
const SizedBox spaceHeight6 = SizedBox(height: 6);
const SizedBox spaceHeight8 = SizedBox(height: 8);
const SizedBox spaceHeight10 = SizedBox(height: 10);
const SizedBox spaceHeight12 = SizedBox(height: 12);
const SizedBox spaceHeight15 = SizedBox(height: 15);
const SizedBox spaceHeight16 = SizedBox(height: 16);
const SizedBox spaceHeight20 = SizedBox(height: 20);
const SizedBox spaceHeight24 = SizedBox(height: 24);
const SizedBox spaceHeight32 = SizedBox(height: 32);
const SizedBox spaceHeight48 = SizedBox(height: 48);
const SizedBox spaceHeight50 = SizedBox(height: 50);

const SizedBox spaceWidth2 = SizedBox(width: 2);
const SizedBox spaceWidth4 = SizedBox(width: 4);
const SizedBox spaceWidth5 = SizedBox(width: 5);
const SizedBox spaceWidth6 = SizedBox(width: 6);
const SizedBox spaceWidth8 = SizedBox(width: 8);
const SizedBox spaceWidth10 = SizedBox(width: 10);
const SizedBox spaceWidth12 = SizedBox(width: 12);
const SizedBox spaceWidth15 = SizedBox(width: 15);
const SizedBox spaceWidth16 = SizedBox(width: 16);
const SizedBox spaceWidth20 = SizedBox(width: 20);
const SizedBox spaceWidth24 = SizedBox(width: 24);
const SizedBox spaceWidth32 = SizedBox(width: 32);
const SizedBox spaceWidth48 = SizedBox(width: 48);
const SizedBox spaceWidth50 = SizedBox(width: 50);

const TextStyle textBold = TextStyle(fontWeight: FontWeight.bold);
const TextStyle textBig = TextStyle(fontSize: 20);
const TextStyle textTitle = TextStyle(fontSize: 18);
const TextStyle textNormal = TextStyle(fontSize: 14);
const TextStyle textSuperSmall = TextStyle(fontSize: 9);
const TextStyle textSmall8 = TextStyle(fontSize: 8);
const TextStyle textSmall = TextStyle(fontSize: 11);
const TextStyle textSmallGrey = TextStyle(fontSize: 12, color: Colors.grey);
