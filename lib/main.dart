import 'package:UUL_Gym/constants/color_constants.dart';
import 'package:UUL_Gym/models/app_state.dart';
import 'package:UUL_Gym/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/dimens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = ThemeData.light();
    return ChangeNotifierProvider<AppState>(
      create: (context) => AppState(),
      child: MaterialApp(
        theme: theme.copyWith(
          canvasColor: Colors.white,
          primaryColor: kAccentColor,
          accentColor: kAccentColor,
          brightness: Brightness.dark,
          bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(kLargeBorderRadius),
              ),
            ),
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}

/*

            primaryColor: kAccentColor,
            accentColor: kAccentColor,
            brightness: Brightness.dark,
 */
