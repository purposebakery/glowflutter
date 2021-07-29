import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Utils {
  /// ----------- ///
  /// DELAY UTILS ///
  /// ----------- ///
  static const int DURATION_SHORT_MILLIS = 150;
  static const int DURATION_MEDIUM_MILLIS = 300;
  static const int DURATION_LONG_MILLIS = 600;

  static const int DURATION_1SEC_MILLIS = 1000;

  static const Duration DURATION_SHORT = Duration(milliseconds: DURATION_SHORT_MILLIS);
  static const Duration DURATION_MEDIUM = Duration(milliseconds: DURATION_MEDIUM_MILLIS);
  static const Duration DURATION_LONG = Duration(milliseconds: DURATION_LONG_MILLIS);

  static const Duration DURATION_1SEC = Duration(milliseconds: DURATION_1SEC_MILLIS * 1);
  static const Duration DURATION_2SEC = Duration(milliseconds: DURATION_1SEC_MILLIS * 2);

  static void delay(Duration duration, Function function) {
    Future.delayed(duration, function as FutureOr<dynamic> Function()?);
  }

  static void delayShort(Function function) {
    delay(DURATION_SHORT, function);
  }

  static void delayMedium(Function function) {
    delay(DURATION_MEDIUM, function);
  }

  static void delayLong(Function function) {
    delay(DURATION_LONG, function);
  }

  /// ------------- ///
  /// DISPLAY UTILS ///
  /// ------------- ///
  static double getDisplaySizeWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getDisplaySizeWidthHalf(BuildContext context) {
    return getDisplaySizeWidth(context) / 2.0;
  }

  static double getDisplaySizeHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getDisplaySizeHeightHalf(BuildContext context) {
    return getDisplaySizeHeight(context) / 2.0;
  }

  static Size getDisplaySize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double getDisplayShortestSide(BuildContext context) {
    return getDisplaySize(context).shortestSide;
  }

  static double getDisplayShortestSideHalf(BuildContext context) {
    return getDisplayShortestSide(context) / 2.0;
  }

  /// ---------- ///
  /// FILE UTILS ///
  /// ---------- ///
  static Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }

  /// ----- ///
  /// SIZES ///
  /// ----- ///
  static const double SPACE0_25 = 4;
  static const double SPACE0_5 = 8;
  static const double SPACE1 = 16;
  static const double SPACE2 = 32;
  static const double SPACE3 = 48;
  static const double SPACE4 = 64;

  static double SPACE0_25_D = SPACE0_25; // ignore: non_constant_identifier_names
  static double SPACE0_5_D = SPACE0_5; // ignore: non_constant_identifier_names
  static double SPACE1_D = SPACE1; // ignore: non_constant_identifier_names
  static double SPACE2_D = SPACE2; // ignore: non_constant_identifier_names
  static double SPACE3_D = SPACE3; // ignore: non_constant_identifier_names
  static double SPACE4_D = SPACE4; // ignore: non_constant_identifier_names

  static const double ICON_SMALL = 24;
  static const double ICON_MEDIUM = 48;
  static const double ICON_LARGE = 64;

  static double ICON_SMALL_D = ICON_SMALL; // ignore: non_constant_identifier_names
  static double ICON_MEDIUM_D = ICON_MEDIUM; // ignore: non_constant_identifier_names
  static double ICON_LARGE_D = ICON_LARGE; // ignore: non_constant_identifier_names

  static void initializeDynamicSizes(BuildContext context) {
    var shortestSide = Utils.getDisplayShortestSide(context);
    var dynamicScale = 1.0;
    if (shortestSide <= 320) {
      dynamicScale = 1.0;
    } else if (shortestSide <= 480) {
      dynamicScale = 1.1;
    } else if (shortestSide <= 640) {
      dynamicScale = 1.25;
    } else if (shortestSide <= 800) {
      dynamicScale = 1.45;
    } else {
      dynamicScale = 1.75;
    }

    SPACE0_25_D = SPACE0_25 * dynamicScale;
    SPACE0_5_D = SPACE0_5 * dynamicScale;
    SPACE1_D = SPACE1 * dynamicScale;
    SPACE2_D = SPACE2 * dynamicScale;
    SPACE3_D = SPACE3 * dynamicScale;
    SPACE4_D = SPACE4 * dynamicScale;

    ICON_SMALL_D = ICON_SMALL * dynamicScale;
    ICON_MEDIUM_D = ICON_MEDIUM * dynamicScale;
    ICON_LARGE_D = ICON_LARGE * dynamicScale;
  }
}
