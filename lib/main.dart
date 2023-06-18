import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kodeks/screen/GPTProvider.dart';
import 'package:kodeks/screen/auth/forgot_password_screen.dart';
import 'package:kodeks/screen/auth/login_screen.dart';
import 'package:kodeks/screen/auth/signup_screen.dart';
import 'package:kodeks/screen/instruction/instruction_screen/instruction_screen.dart';
import 'package:kodeks/screen/instruction/select_topic_category_screen.dart';
import 'package:kodeks/screen/instruction/topic_category_screen.dart';
import 'package:kodeks/screen/chat/chat_screen.dart';
import 'package:kodeks/screen/doc/select_document/select_doc_provider.dart';
import 'package:kodeks/screen/splash_screen.dart';
import 'package:kodeks/themes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs));
}

class MyApp extends StatelessWidget {
  SharedPreferences _preferences;
  MyApp(this._preferences) {}
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 812),
        builder: (context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => SelectCatProvider()),
              ChangeNotifierProvider(create: (_) => GPTProvider()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: KodeksThemes.lightTheme,
              initialRoute: '/splash_screen',
              routes: {
                '/login': (context) => LoginScreen(),
                '/register': (context) => SignupScreen(),
                '/forgot_password': (context) => ForgotPasswordScreen(),
                '/chat_screen': (context) => ChatScreen(),
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
                },
                '/splash_screen': (context) =>
                    SplashScreen(prefs: _preferences),
              },
            ),
          );
        });
  }
}
