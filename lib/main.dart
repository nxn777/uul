import 'package:UUL_Gym/common/kv_store.dart';
import 'package:common/common.dart';
import 'package:UUL_Gym/data/repo/user_repo.dart';
import 'package:UUL_Gym/di/global_dependencies.dart';
import 'package:UUL_Gym/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var kvStore = KVStore(await SharedPreferences.getInstance());
  var globalDependencies = GlobalDependencies(kvStore: kvStore);
  await UserRepo(kvStore).deleteAll();
  runApp(MyApp(globalDependencies));
}

class MyApp extends StatelessWidget {
  final GlobalDependencies _globalDependencies;

  MyApp(this._globalDependencies);

  @override
  Widget build(BuildContext context) {
    var theme = ThemeData.light();
    return Provider<GlobalDependencies>(
      create: (context) => _globalDependencies,
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
