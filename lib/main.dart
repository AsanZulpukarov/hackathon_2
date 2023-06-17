import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kodeks/docx_document/document.dart';
import 'package:kodeks/screen/auth/forgot_password_screen.dart';
import 'package:kodeks/screen/auth/login_screen.dart';
import 'package:kodeks/screen/auth/signup_screen.dart';
import 'package:kodeks/screen/chat/chat_screen.dart';
import 'package:kodeks/screen/doc/do_doc.dart';
import 'package:kodeks/screen/profile_screen/user_profile_screen.dart';
// import 'package:kodeks/screen/questions.dart';
import 'package:kodeks/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: KodeksThemes.lightTheme,
            initialRoute: '/',
            routes: {
              '/login': (context) => LoginScreen(),
              '/register': (context) => SignupScreen(),
              '/forgot_password': (context) => ForgotPasswordScreen(),
              '/user_profile': (context) => UserProfileScreen(),
              '/chat_screen': (context) => ChatScreen(),
              '/': (context) => DocumentGenerationPage(),
            },
          );
        });
  }
}
