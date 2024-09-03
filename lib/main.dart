import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login/splachScreen.dart';
import 'package:provider/provider.dart';
import 'setting/theme_provider.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  tz.initializeTimeZones();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: First_page(),
    ),
  );
}


class First_page extends StatelessWidget {
  const First_page({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart_Home',
      theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: SplashScreen(),
      routes: {
        '/First_page': (context) => First_page(),
      },
    );
  }
}