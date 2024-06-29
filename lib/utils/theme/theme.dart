import 'package:bu_edmrs/utils/theme/custom_themes/appbar_theme.dart';
import 'package:bu_edmrs/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:bu_edmrs/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:bu_edmrs/utils/theme/custom_themes/chip_theme.dart';
import 'package:bu_edmrs/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:bu_edmrs/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:bu_edmrs/utils/theme/custom_themes/text_theme.dart';
import 'package:bu_edmrs/utils/theme/custom_themes/textfield_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: MyTextTheme.lightTextTheme,
    elevatedButtonTheme: elevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: MyAppBarTheme.lightAppBarTheme,
    bottomSheetTheme: BottomSheetTheme.lightBottomSheet,
    checkboxTheme: CheckBoxTheme.lightCheckboxTheme,
    outlinedButtonTheme: MyOutlinedButtonTheme.lightOutlineButton,
    inputDecorationTheme: TextFieldTheme.lightInputField,
    chipTheme: MyChipTheme.lightChipTheme
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: MyTextTheme.dartTextTheme,
    elevatedButtonTheme: elevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: MyAppBarTheme.darkAppBarTheme,
    bottomSheetTheme: BottomSheetTheme.darkBottomSheet,
    checkboxTheme: CheckBoxTheme.darkCheckboxTheme,
    outlinedButtonTheme: MyOutlinedButtonTheme.darkOutlineButton,
    inputDecorationTheme: TextFieldTheme.darkInputField,
    chipTheme: MyChipTheme.darkChipTheme
  );
}