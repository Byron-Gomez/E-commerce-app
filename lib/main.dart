import 'package:e_commerce/navigations/Tabbar.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 181, 182, 182),
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(
            fontSize: 15,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 15,
          ),
          selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey
        ),
      ),
      home: const Tabbar(),
    );
  }
}

