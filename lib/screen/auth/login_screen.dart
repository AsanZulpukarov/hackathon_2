import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kodeks/colors.dart';
import 'package:kodeks/service/api_service.dart';
import 'package:kodeks/widgets/button.dart';
import 'package:kodeks/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final innController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    innController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return OrientationBuilder(
              builder: (BuildContext context, Orientation orientation) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      Center(
                        child: Image.asset(
                          'assets/logo.png',
                          width: 150,
                          height: 150,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 30),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              // color: Colors.white,
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height: constraints.maxHeight * 0.015),
                                    const Text(
                                      'Войти\nв свой аккаунт',
                                      style: TextStyle(
                                        fontSize: 30,
                                      ),
                                    ),
                                    SizedBox(
                                      height: constraints.maxHeight * 0.025,
                                    ),
                                    CustomTextField(
                                      hint: 'ИНН',
                                      iconName: Icons.numbers,
                                      controller: innController,
                                      obscureText: false,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter Email';
                                        }
                                        if (value.length != 14) {
                                          return "Длина ИНН должно быть 14 символов";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.number,
                                    ),
                                    SizedBox(
                                      height: constraints.maxHeight * 0.025,
                                    ),
                                    CustomTextField(
                                      hint: 'Пароль',
                                      iconName: Icons.lock,
                                      controller: passwordController,
                                      obscureText: true,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter Password';
                                        }
                                        return null;
                                      },
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                    ),
                                    SizedBox(
                                      height: constraints.maxHeight * 0.025,
                                    ),

                                    // Container(child: TextB,)
                                    TButton(
                                      loading: loading,
                                      constraints: constraints,
                                      btnColor: Theme.of(context).primaryColor,
                                      btnText: 'Войти',
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          print(ApiService().postSingIn(
                                              innController.text,
                                              passwordController.text));
                                          Navigator.pushNamed(
                                              context, "/user_profile");
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: constraints.maxHeight * 0.01,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'У вас нет аккунта?',
                                          style: TextStyle(
                                              color: kGrayTextC,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        TextButton(
                                          child: Text(
                                            'Регистрация',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 16),
                                          ),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, "/register");
                                          },
                                        ),
                                      ],
                                    ),
                                    TextButton(
                                      child: Text(
                                        'Восстановить пароль?',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 16),
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, "/forgot_password");
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
