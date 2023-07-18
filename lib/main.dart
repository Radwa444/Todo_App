import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/ui/screen/register/Register_screen.dart';
import 'package:todo/ui/screen/Login/Login_Screen.dart';
import 'firebase_options.dart';
Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    routes: {Register_screen.routeName:(_)=>Register_screen(),
    login_screen.routeName:(_)=>login_screen()},
      initialRoute: login_screen.routeName,

    );
  }
}
