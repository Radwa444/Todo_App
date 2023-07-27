import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo/ui/provider/AuthProvider.dart';
import 'package:todo/ui/screen/register/Register_screen.dart';
import 'package:todo/ui/screen/Login/Login_Screen.dart';
import 'package:todo/ui/theme/MyThemeData.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:todo/ui/screen/home/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/ui/provider/LanganeProvider.dart';
Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => AuthProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var proveter=Provider.of<AuthProvider>(context,);
    return MaterialApp(
      routes: {
        Register_screen.routeName: (_) => Register_screen(),
        login_screen.routeName: (_) => login_screen(),
        Home_screen.routeName: (_) => Home_screen()
      },
      initialRoute: login_screen.routeName,
      theme: MyThemeData.LigthTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // Spanish
      ],

      locale:  Locale(proveter.locale),

    );
  }
}
