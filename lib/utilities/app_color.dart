/**
 * Creating custom color palettes is part of creating a custom app. The idea is to create
 * your class of custom colors, in this case `AppColor` and then create a `ThemeData`
 * object with those colors you just defined.
 *
 * Resource:
 * A good resource would be this website: http://mcg.mbitson.com/
 * You simply need to put in the colour you wish to use, and it will generate all shades
 * for you. Your primary colour will be the `900` value.
 *
 * Colour Creation:
 * In order to create the custom colours you need to create a `Map<int, Color>` object
 * which will have all the shade values. `const Color(0xFF...)` will be how you create
 * the colours. The six character hex code is what follows. If you wanted the colour
 * #114488 or #D39090 as primary colours in your theme, then you would have
 * `const Color(0x114488)` and `const Color(0xD39090)`, respectively.
 *
 * Usage:
 * In order to use this newly created theme or even the colours in it, you would just
 * `import` this file in your project, anywhere you needed it.
 * `import 'path/to/theme.dart';`
 */
import 'package:flutter/material.dart';

class AppColor {
  AppColor._(); // this basically makes it so you can instantiate this class
  // Single Color Without Map
  // static const Color teal = const Color(0xFF098EA0);
  static const startingColor = Color(0xFF088ea0);
  static const endingColor = Color(0xFF14CFE8);
  static const failedTextColor = Color(0xFFFF922D);
  static const deleteColor = Color(0xFFF04D24);
  static const notificationUnreadColor = Color(0x1914CFE8);
  static const MaterialColor teal = MaterialColor(
    _tealPrimaryValue,
    <int, Color>{
      50: Color(0x1903B1E3),
      100: Color(0x3203B1E3),
      200: Color(0x5B03B1E3),
      300: Color(0x6403B1E3),
      400: Color(0x7D03B1E3),
      500: Color(0x9603B1E3),
      600: Color(0xAF03B1E3),
      700: Color(0xC803B1E3),
      800: Color(0xE103B1E3),
      900: Color(_tealPrimaryValue),
    },
  );
  static const int _tealPrimaryValue = 0xFF03B1E3;

  static const MaterialColor vermilion = MaterialColor(
    _vermilionPrimaryValue,
    <int, Color>{
      50: Color(0x19FF4500),
      100: Color(0x32FF4500),
      200: Color(0x5BFF4500),
      300: Color(0x64FF4500),
      400: Color(0x7DFF4500),
      500: Color(0x96FF4500),
      600: Color(0xAFFF4500),
      700: Color(0xC8FF4500),
      800: Color(0xE1FF4500),
      900: Color(_vermilionPrimaryValue),
    },
  );
  static const int _vermilionPrimaryValue = 0xFFFF4500;

  static const MaterialColor pictonBlue = MaterialColor(
    _pictonBluePrimaryValue,
    <int, Color>{
      50: Color(0x1948C6E8),
      100: Color(0x3248C6E8),
      200: Color(0x5B48C6E8),
      300: Color(0x6448C6E8),
      400: Color(0x7D48C6E8),
      500: Color(0x9648C6E8),
      600: Color(0xAF48C6E8),
      700: Color(0xC848C6E8),
      800: Color(0xE148C6E8),
      900: Color(_pictonBluePrimaryValue),
    },
  );
  static const int _pictonBluePrimaryValue = 0xFF48C6E8;

  static const MaterialColor pictonYellow = MaterialColor(
    _pictonYellowPrimaryValue,
    <int, Color>{
      50: Color(0x19FFBF00),
      100: Color(0x32FFBF00),
      200: Color(0x5BFFBF00),
      300: Color(0x64FFBF00),
      400: Color(0x7DFFBF00),
      500: Color(0x96FFBF00),
      600: Color(0xAFFFBF00),
      700: Color(0xC8FFBF00),
      800: Color(0xE1FFBF00),
      900: Color(_pictonBluePrimaryValue),
    },
  );
  static const int _pictonYellowPrimaryValue = 0xFFFFBF00;

  static const MaterialColor riverBed = MaterialColor(
    _priverBedPrimaryValue,
    <int, Color>{
      50: Color(0x1947525E),
      100: Color(0x3247525E),
      200: Color(0x5B47525E),
      300: Color(0x6447525E),
      400: Color(0x7D47525E),
      500: Color(0x9647525E),
      600: Color(0xAF47525E),
      700: Color(0xC847525E),
      800: Color(0xE147525E),
      900: Color(_priverBedPrimaryValue),
    },
  );
  static const int _priverBedPrimaryValue = 0xFF47525E;

  static const MaterialColor cumulus = MaterialColor(
    _cumulusPrimaryValue,
    <int, Color>{
      50: Color(0x19FEFFDB),
      100: Color(0x32FEFFDB),
      200: Color(0x5BFEFFDB),
      300: Color(0x64FEFFDB),
      400: Color(0x7DFEFFDB),
      500: Color(0x96FEFFDB),
      600: Color(0xAFFEFFDB),
      700: Color(0xC8FEFFDB),
      800: Color(0xE1FEFFDB),
      900: Color(_cumulusPrimaryValue),
    },
  );
  static const int _cumulusPrimaryValue = 0xFFFEFFDB;

  static const MaterialColor limedSpruce = MaterialColor(
    _limedSprucePrimaryValue,
    <int, Color>{
      50: Color(0x19343F4B),
      100: Color(0x32343F4B),
      200: Color(0x5B343F4B),
      300: Color(0x64343F4B),
      400: Color(0x7D343F4B),
      500: Color(0x96343F4B),
      600: Color(0xAF343F4B),
      700: Color(0xC8343F4B),
      800: Color(0xE1343F4B),
      900: Color(_limedSprucePrimaryValue),
    },
  );
  static const int _limedSprucePrimaryValue = 0xFF343F4B;

  static const MaterialColor bridalHeath = MaterialColor(
    _bridalHeathPrimaryValue,
    <int, Color>{
      50: Color(0x19FFFAF0),
      100: Color(0x32FFFAF0),
      200: Color(0x5BFFFAF0),
      300: Color(0x64FFFAF0),
      400: Color(0x7DFFFAF0),
      500: Color(0x96FFFAF0),
      600: Color(0xAFFFFAF0),
      700: Color(0xC8FFFAF0),
      800: Color(0xE1FFFAF0),
      900: Color(_bridalHeathPrimaryValue),
    },
  );
  static const int _bridalHeathPrimaryValue = 0xFFFFFAF0;

  static const MaterialColor alizarinCrimson = MaterialColor(
    _alizarinCrimsonPrimaryValue,
    <int, Color>{
      50: Color(0x19DC1428),
      100: Color(0x32DC1428),
      200: Color(0x5BDC1428),
      300: Color(0x64DC1428),
      400: Color(0x7DDC1428),
      500: Color(0x96DC1428),
      600: Color(0xAFDC1428),
      700: Color(0xC8DC1428),
      800: Color(0xE1DC1428),
      900: Color(_alizarinCrimsonPrimaryValue),
    },
  );
  static const int _alizarinCrimsonPrimaryValue = 0xFFDC1428;

  static const MaterialColor kleinBlue = MaterialColor(
    _kleinBluePrimaryValue,
    <int, Color>{
      50: Color(0x19034EA2),
      100: Color(0x32034EA2),
      200: Color(0x5B034EA2),
      300: Color(0x64034EA2),
      400: Color(0x7D034EA2),
      500: Color(0x96034EA2),
      600: Color(0xAF034EA2),
      700: Color(0xC8034EA2),
      800: Color(0xE1034EA2),
      900: Color(_kleinBluePrimaryValue),
    },
  );
  static const int _kleinBluePrimaryValue = 0xFF034EA2;

  static const MaterialColor christi = MaterialColor(
    _christiPrimaryValue,
    <int, Color>{
      50: Color(0x19369F0C),
      100: Color(0x32369F0C),
      200: Color(0x5B369F0C),
      300: Color(0x64369F0C),
      400: Color(0x7D369F0C),
      500: Color(0x96369F0C),
      600: Color(0xAF369F0C),
      700: Color(0xC8369F0C),
      800: Color(0xE1369F0C),
      900: Color(_christiPrimaryValue),
    },
  );
  static const int _christiPrimaryValue = 0xFF369F0C;

  static const MaterialColor regentGrey = MaterialColor(
    _regentGreyPrimaryValue,
    <int, Color>{
      50: Color(0x198492A6),
      100: Color(0x328492A6),
      200: Color(0x5B8492A6),
      300: Color(0x648492A6),
      400: Color(0x7D8492A6),
      500: Color(0x968492A6),
      600: Color(0xAF8492A6),
      700: Color(0xC88492A6),
      800: Color(0xE18492A6),
      900: Color(_regentGreyPrimaryValue),
    },
  );
  static const int _regentGreyPrimaryValue = 0xFF8492A6;

  static const MaterialColor azureRadiance = MaterialColor(
    _azureRadiancePrimaryValue,
    <int, Color>{
      50: Color(0x1900A6FF),
      100: Color(0x3200A6FF),
      200: Color(0x5D00A6FF),
      300: Color(0x6400A6FF),
      400: Color(0x7D00A6FF),
      500: Color(0x9600A6FF),
      600: Color(0xAF00A6FF),
      700: Color(0xC800A6FF),
      800: Color(0xE100A6FF),
      900: Color(_azureRadiancePrimaryValue),
    },
  );
  static const int _azureRadiancePrimaryValue = 0xFF00A6FF;

  static const MaterialColor mirage = MaterialColor(
    _miragePrimaryValue,
    <int, Color>{
      50: Color(0x191E2D3E),
      100: Color(0x321E2D3E),
      200: Color(0x5B1E2D3E),
      300: Color(0x641E2D3E),
      400: Color(0x7D1E2D3E),
      500: Color(0x961E2D3E),
      600: Color(0xAF1E2D3E),
      700: Color(0xC81E2D3E),
      800: Color(0xE11E2D3E),
      900: Color(_miragePrimaryValue),
    },
  );
  static const int _miragePrimaryValue = 0xFF1E2D3E;

  static const MaterialColor catskillWhite = MaterialColor(
    _catskillWhitePrimaryValue,
    <int, Color>{
      50: Color(0x19EFF2F7),
      100: Color(0x32EFF2F7),
      200: Color(0x5BEFF2F7),
      300: Color(0x64EFF2F7),
      400: Color(0x7DEFF2F7),
      500: Color(0x96EFF2F7),
      600: Color(0xAFEFF2F7),
      700: Color(0xC8EFF2F7),
      800: Color(0xE1EFF2F7),
      900: Color(_catskillWhitePrimaryValue),
    },
  );

  static const MaterialColor pink = MaterialColor(
    0xFFFF2B88,
    <int, Color>{
      50: Color(_pink),
      100: Color(_pink),
      200: Color(_pink),
      300: Color(_pink),
      400: Color(_pink),
      500: Color(_pink),
      600: Color(_pink),
      700: Color(_pink),
      800: Color(_pink),
      900: Color(_pink),
    },
  );
  static const MaterialColor fassTapColor = MaterialColor(
    _fassTapColor,
    <int, Color>{
      50: Color(_fassTapColor),
      100: Color(_fassTapColor),
      200: Color(_fassTapColor),
      300: Color(_fassTapColor),
      400: Color(_fassTapColor),
      500: Color(_fassTapColor),
      600: Color(_fassTapColor),
      700: Color(_fassTapColor),
      800: Color(_fassTapColor),
      900: Color(_fassTapColor),
    },
  );
  static const int _catskillWhitePrimaryValue = 0xFFEFF2F7;
  static const int _pink = 0xFFFF2B88;
  static const int _fassTapColor = 0xFF1384D6;
/* Rectangle */

}
