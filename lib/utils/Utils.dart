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

  static double DYNAMIC_SCALE = 1.0; // ignore: non_constant_identifier_names
  static double DYNAMIC_SCALE_CUBED = DYNAMIC_SCALE * DYNAMIC_SCALE; // ignore: non_constant_identifier_names

  static const double TEXT_SMALL = 12;
  static const double TEXT_MEDIUM = 14;
  static const double TEXT_LARGE = 16;

  static double TEXT_SMALL_D = TEXT_SMALL; // ignore: non_constant_identifier_names
  static double TEXT_MEDIUM_D = TEXT_MEDIUM; // ignore: non_constant_identifier_names
  static double TEXT_LARGE_D = TEXT_LARGE; // ignore: non_constant_identifier_names

  static double lastShortestSide = -1;

  static void initializeDynamicSizes(BuildContext context) {
    var shortestSide = Utils.getDisplayShortestSide(context);
    if (lastShortestSide == shortestSide) {
      return;
    }
    lastShortestSide = shortestSide;

    DYNAMIC_SCALE = 1.0;
    if (shortestSide <= 320) {
      DYNAMIC_SCALE = 1.0;
    } else if (shortestSide <= 480) {
      DYNAMIC_SCALE = 1.1;
    } else if (shortestSide <= 640) {
      DYNAMIC_SCALE = 1.25;
    } else if (shortestSide <= 800) {
      DYNAMIC_SCALE = 1.45;
    } else {
      DYNAMIC_SCALE = 1.75;
    }
    DYNAMIC_SCALE_CUBED = DYNAMIC_SCALE * DYNAMIC_SCALE;

    SPACE0_25_D = SPACE0_25 * DYNAMIC_SCALE;
    SPACE0_5_D = SPACE0_5 * DYNAMIC_SCALE;
    SPACE1_D = SPACE1 * DYNAMIC_SCALE;
    SPACE2_D = SPACE2 * DYNAMIC_SCALE;
    SPACE3_D = SPACE3 * DYNAMIC_SCALE;
    SPACE4_D = SPACE4 * DYNAMIC_SCALE;

    ICON_SMALL_D = ICON_SMALL * DYNAMIC_SCALE;
    ICON_MEDIUM_D = ICON_MEDIUM * DYNAMIC_SCALE;
    ICON_LARGE_D = ICON_LARGE * DYNAMIC_SCALE;

    TEXT_SMALL_D = TEXT_SMALL * DYNAMIC_SCALE;
    TEXT_MEDIUM_D = TEXT_MEDIUM * DYNAMIC_SCALE;
    TEXT_LARGE_D = TEXT_LARGE * DYNAMIC_SCALE;
  }
}
