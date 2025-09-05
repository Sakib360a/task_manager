import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
        inputDecorationTheme:  InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(
              borderSide: BorderSide.none
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none
          ),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide.none
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none
          )
      ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: Color(0xff21bf73),
            fixedSize: Size.fromWidth(double.maxFinite),
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
