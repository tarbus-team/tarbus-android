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
  static Color primaryColorDark = Color(0xff4f7acf);
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
      color: Colors.black,
      fontWeight: FontWeight.w700,
    ),
    bodyText1: GoogleFonts.roboto(
      color: Colors.black,
      fontSize: 15.0,
    ),
    bodyText2: TextStyle(
      fontSize: 15.0,
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
  primaryColor: Palette.primaryColorDark,
  textTheme: TextTheme(
    headline1: GoogleFonts.roboto(
      color: Colors.white,
      fontSize: 24.0,
      fontWeight: FontWeight.w700,
    ),
    headline2: TextStyle(fontSize: 16),
    headline3: GoogleFonts.poppins(
      fontSize: 12.0,
      color: Color(0xffffffff),
      fontWeight: FontWeight.w700,
    ),
    bodyText1: GoogleFonts.roboto(
      color: Colors.white,
      fontSize: 15.0,
    ),
    bodyText2: TextStyle(
      fontSize: 15.0,
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
          color: Palette.primaryColorDark,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Palette.primaryColorDark),
      textStyle: MaterialStateProperty.all(
        GoogleFonts.poppins(
          fontSize: 14.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
  tabBarTheme: TabBarTheme(
    labelColor: Palette.primaryColorDark,
    unselectedLabelColor: Colors.white,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xff212121),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    actionsIconTheme: IconThemeData(
      color: Palette.primaryColorDark,
    ),
  ),
);

//cupertino themes
CupertinoThemeData cupertinoTheme = CupertinoThemeData(
  primaryColor: Palette.primaryColor,
);
