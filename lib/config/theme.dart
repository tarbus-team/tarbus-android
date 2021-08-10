import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

final systemUiOverlayStyle = SystemUiOverlayStyle(
    // statusBarColor: Colors.black,
    // statusBarBrightness: Brightness.light,
    // statusBarIconBrightness: Brightness.light,
    // systemNavigationBarDividerColor: Colors.black,
    // systemNavigationBarIconBrightness: Brightness.light,
    // systemNavigationBarColor: Colors.black,
    );

MaterialAppData getMaterialAppData(_, __) => MaterialAppData(
      theme: lightTheme,
      darkTheme: darkTheme,
    );

CupertinoAppData getCupertinoAppData(context, __) => CupertinoAppData(
      theme: cupertinoTheme,
    );

class Palette {
  static Color primaryColor = Color(0xff014F9D);
}

class Dimensions {
  static const double gutterVerySmall = 4.0;
  static const double gutterSmall = 8.0;
  static const double gutterMedium = 16.0;
  static const double gutterLarge = 24.0;
  static const double gutterHuge = 32.0;
  static const double gutterVeryHuge = 40.0;

  static const double screenPadding = 16.0;
  static const double refreshDisplacement = 80.0;
  static const double cupertinoBottomPadding = 52.0;
}

// material themes
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Palette.primaryColor,
  textTheme: TextTheme(
    headline1: GoogleFonts.roboto(
      color: Colors.black,
      fontSize: 24.0,
      fontWeight: FontWeight.w700,
    ),
    headline2: TextStyle(fontSize: 16),
    headline3: GoogleFonts.poppins(
      fontSize: 12.0,
      color: Color(0xff767676),
      fontWeight: FontWeight.w700,
    ),
    bodyText1: GoogleFonts.roboto(
      color: Colors.black,
      fontSize: 14.0,
    ),
    bodyText2: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
    ),
    button: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    ),
    subtitle2: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(
        TextStyle(
          fontSize: 14.0,
          color: Palette.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Palette.primaryColor),
      textStyle: MaterialStateProperty.all(
        GoogleFonts.poppins(
          fontSize: 14.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
  tabBarTheme: TabBarTheme(
    labelColor: Palette.primaryColor,
    unselectedLabelColor: Colors.black,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    actionsIconTheme: IconThemeData(
      color: Palette.primaryColor,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Palette.primaryColor,
  textTheme: TextTheme(
    headline1: TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
    ),
    headline2: TextStyle(fontSize: 16),
    headline3: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    ),
    bodyText1: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    ),
    bodyText2: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
    ),
    button: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    ),
    subtitle2: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
    ),
  ),
);

//cupertino themes
CupertinoThemeData cupertinoTheme = CupertinoThemeData(
  primaryColor: Palette.primaryColor,
);
