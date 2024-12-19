import 'package:flutter/material.dart';
import 'Screens/pages/landing_page.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title:'Shopping App',
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSeed(
            seedColor:Color.fromARGB(255, 255, 255, 255),
            primary: Color.fromARGB(255, 255, 255, 255),
          ),
          appBarTheme: AppBarTheme(
            
            titleTextStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16, 
            ),
            prefixIconColor: Color.fromRGBO(119,119,119,1),
          ),
          textTheme: TextTheme(
            titleLarge: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
              ),
            titleMedium: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            bodySmall: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          useMaterial3: true,
        ),
    
        home: LandingPage(),
    
    );
  }
}