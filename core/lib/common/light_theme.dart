import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightThemeData = ThemeData(
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  cardColor: Colors.blue,
  dividerColor: Colors.lightBlue[50],
  highlightColor: Colors.lightBlue[800],
  splashColor: Colors.lightBlue[900],
  selectedRowColor: Colors.red,
  unselectedWidgetColor: Colors.blueGrey[200],
  disabledColor: Colors.blueGrey[200],
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.accent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    color: Colors.blue[700],
    shape: const CircularNotchedRectangle(),
    elevation: 50.0,
  ),
  toggleButtonsTheme: ToggleButtonsThemeData(
    color: Colors.lightBlue[50],
    selectedColor: Colors.blue,
    disabledColor: Colors.blueGrey[200],
    fillColor: Colors.lightBlue[50],
    focusColor: Colors.lightBlue[200],
    hoverColor: Colors.lightBlue[200],
  ),
  secondaryHeaderColor: Colors.lightBlue[50],
  backgroundColor: Colors.blueGrey[900],
  dialogBackgroundColor: Colors.blueGrey[800],
  indicatorColor: Colors.lightBlue[50],
  hintColor: Colors.blueGrey[200],
  errorColor: Colors.red[500],
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blue[900],
    foregroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    headline1: TextStyle(
        fontSize: 72.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        color: Colors.black),
    headline2: GoogleFonts.getFont('Roboto', color: Colors.black, fontSize: 30),
    headline3: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        color: Colors.black),
    headline4: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        color: Colors.black),
    headline5: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        color: Colors.black),
    headline6: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Roboto',
        color: Colors.black),
    subtitle1:
        TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: 'Roboto'),
    subtitle2:
        TextStyle(fontSize: 14.0, color: Colors.black, fontFamily: 'Roboto'),
    bodyText1: TextStyle(fontSize: 16.0, fontFamily: 'Roboto'),
    bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Roboto'),
    caption:
        TextStyle(fontSize: 12.0, color: Colors.black, fontFamily: 'Roboto'),
    button:
        TextStyle(fontSize: 14.0, color: Colors.white, fontFamily: 'Roboto'),
    overline:
        TextStyle(fontSize: 12.0, color: Colors.black, fontFamily: 'Roboto'),
  ),
  colorScheme:
      ColorScheme.fromSwatch().copyWith(secondary: Colors.lightBlue[50]),
);
