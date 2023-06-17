import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kodeks/docx_document/document.dart';
import 'package:kodeks/screen/auth/forgot_password_screen.dart';
import 'package:kodeks/screen/auth/login_screen.dart';
import 'package:kodeks/screen/auth/signup_screen.dart';
import 'package:kodeks/screen/instruction/instruction_screen/instruction_screen.dart';
import 'package:kodeks/screen/instruction/select_topic_category_screen.dart';
import 'package:kodeks/screen/instruction/topic_category_screen.dart';
import 'package:kodeks/screen/chat/chat_screen.dart';
import 'package:kodeks/screen/doc/do_doc.dart';
import 'package:kodeks/screen/doc/select_document/select_doc_provider.dart';
import 'package:kodeks/screen/menu_page.dart';
import 'package:kodeks/screen/profile_screen/user_profile_screen.dart';
// import 'package:kodeks/screen/questions.dart';
import 'package:kodeks/themes.dart';
import 'package:provider/provider.dart';

import 'screen/questions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 812),
        builder: (context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => SelectCatProvider()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: KodeksThemes.lightTheme,
              initialRoute: '/',
              routes: {
                '/login': (context) => LoginScreen(),
                '/register': (context) => SignupScreen(),
                '/forgot_password': (context) => ForgotPasswordScreen(),
                '/user_profile': (context) => UserProfileScreen(),
                '/chat_screen': (context) => ChatScreen(),
                '/': (context) => MenuPage(),
                '/category': (context) => TopicCategoryScreen(),
                '/category/select_category': (context) => TopicCategoryScreen(),
                '/category/instructions': (context) {
                  return SelectTopicCategoryScreen(ModalRoute.of(context)!
                      .settings
                      .arguments as List<dynamic>);
                },
                '/category/instructions/id': (context) {
                  return InstructionScreen(
                      ModalRoute.of(context)!.settings.arguments as int);
                }
              },
            ),
          );
        });
  }
}
