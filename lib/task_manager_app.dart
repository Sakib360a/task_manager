import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/screens/cancelled_task_screen.dart';
import 'package:task_manager/ui/screens/completed_task_screen.dart';
import 'package:task_manager/ui/screens/forgot_password_code_verification_screen.dart';
import 'package:task_manager/ui/screens/forgot_password_email_verification_screen.dart';
import 'package:task_manager/ui/screens/login_screen.dart';
import 'package:task_manager/ui/screens/main_navbar_holder_screen.dart';
import 'package:task_manager/ui/screens/new_tasks_screen.dart';
import 'package:task_manager/ui/screens/progress_task_screen.dart';
import 'package:task_manager/ui/screens/reset_password.dart';
import 'package:task_manager/ui/screens/signup_screen.dart';
import 'package:task_manager/ui/screens/splash_screen.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});
  static GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigator,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        textTheme: TextTheme(
          titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          bodySmall: TextStyle(fontSize: 12),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
            //borderSide: BorderSide.none
            borderSide: BorderSide(
              color: Color(0xffadadad).withOpacity(0.2),
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
            //borderSide: BorderSide.none,
            borderSide: BorderSide(
              color: Color(0xffadadad).withOpacity(0.5),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
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
      initialRoute: SplashScreen.name,
      routes: {
        SplashScreen.name: (_)=>SplashScreen(),
        LoginScreen.name: (_)=>LoginScreen(),
        SignupScreen.name: (_)=>SignupScreen(),
        MainNavbarHolderScreen.name: (_)=>MainNavbarHolderScreen(),
        NewTasksScreen.name: (_)=>NewTasksScreen(),
        ProgressTaskScreen.name: (_)=>ProgressTaskScreen(),
        ResetPassword.name: (_)=>ResetPassword(),
        UpdateProfileScreen.name: (_)=>UpdateProfileScreen(),
        CompletedTaskScreen.name: (_)=>CompletedTaskScreen(),
        CancelledTaskScreen.name: (_)=> CancelledTaskScreen(),
        AddNewTask.name: (_)=> AddNewTask(),
        ForgotPasswordEmailVerificationScreen.name: (_)=>ForgotPasswordEmailVerificationScreen(),
        ForgotPasswordCodeVerificationScreen.name: (_)=>ForgotPasswordCodeVerificationScreen(),
      },
    );
  }
}
