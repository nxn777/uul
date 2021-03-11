import 'package:UUL_Gym/screens/home_screen.dart';
import 'package:common/common.dart';
import 'package:di/di.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_extension.dart';
import 'package:persistence_data/persistence_data.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:navigation/navigation.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var deepLinkProcessor = DeepLinkProcessor();
  var kvStore = DefaultKVStore(await SharedPreferences.getInstance());
  var globalDependencies = GlobalDependencies(deepLinkProcessor, kvStore: kvStore);
  await globalDependencies.dependenciesProvider.userModule.createUserRepo().logout();
  Translations.recordMissingKeys = false;
  Translations.recordMissingTranslations = false;
  runApp(MyApp(globalDependencies, deepLinkProcessor));
}

class MyApp extends StatelessWidget {
  final GlobalDependencies _globalDependencies;
  final DeepLinkDepRegisterer _deepLinkDepRegisterer;

  MyApp(this._globalDependencies, this._deepLinkDepRegisterer);

  @override
  Widget build(BuildContext context) {
    var theme = ThemeData.light();
    return Provider<GlobalDependencies>(
      create: (context) => _globalDependencies,
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('es'),
        ],
        theme: theme.copyWith(
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
        home: I18n(child: HomeScreen(_deepLinkDepRegisterer)),
      ),
    );
  }
}
