import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mudra/helper.dart';
import 'package:mudra/Screens/splash.dart';
import 'package:mudra/home.dart';
import 'package:provider/provider.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(MultiProvider(
      providers:[
        ChangeNotifierProvider<Helper>(create: (context) => Helper()),
      ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/home': (context) => const Home(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Mudra',
      theme: ThemeData(
        fontFamily: 'Noto',
      ),
      home: const SplashScreen(),
    );
  }
}


