import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kodeks/colors.dart';
import 'package:kodeks/service/api_service.dart';
import 'package:kodeks/widgets/button.dart';
import 'package:kodeks/widgets/text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fioController = TextEditingController();
  final innController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    fioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          'assets/profile.png',
                          width: 150,
                          height: 150,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 30),

                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                          ),
                          // color: Colors.white,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: constraints.maxHeight * 0.01),
                                const Text(
                                  'Создать аккаунт',
                                  style: TextStyle(
                                    fontSize: 28,
                                  ),
                                ),
                                SizedBox(
                                  height: constraints.maxHeight * 0.02,
                                ),
                                CustomTextField(
                                  hint: 'ФИО',
                                  iconName: Icons.person,
                                  controller: fioController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter ФИО';
                                    }
                                    if (value != fioController.text) {
                                      return 'Password does not match';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: constraints.maxHeight * 0.02,
                                ),
                                CustomTextField(
                                  hint: 'ИНН',
                                  iconName: Icons.numbers,
                                  controller: innController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter ИНН';
                                    }
                                    if (value.length != 14) {
                                      return "Длина ИНН должно быть 14 символов";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                ),
                                SizedBox(
                                  height: constraints.maxHeight * 0.02,
                                ),
                                CustomTextField(
                                  controller: emailController,
                                  hint: 'Email',
                                  iconName: Icons.alternate_email,
                                  obscureText: false,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Email';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: constraints.maxHeight * 0.02,
                                ),
                                CustomTextField(
                                  hint: 'Пароль',
                                  iconName: Icons.lock,
                                  obscureText: true,
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Password';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: constraints.maxHeight * 0.02,
                                ),

                                const Center(
                                  child: Text(
                                    'Регистрируясь, вы соглашаетесь с нашей Политикой конфиденциальности и Условиями использования',
                                    style: TextStyle(
                                        fontSize: 14, color: kGrayTextC),
                                  ),
                                ),

                                SizedBox(
                                  height: constraints.maxHeight * 0.02,
                                ),

                                // Container(child: TextB,)
                                TButton(
                                  loading: loading,
                                  constraints: constraints,
                                  btnColor: Theme.of(context).primaryColor,
                                  btnText: 'Регистрация',
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      var jsonSignUp = {
                                        "name": fioController.text,
                                        "inn": innController.text,
                                        "email": emailController.text,
                                        "password": passwordController.text
                                      };
                                      print(
                                          ApiService().postSingUp(jsonSignUp));
                                      Navigator.pushNamed(context, "/login");
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: constraints.maxHeight * 0.01,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Вернуть в войти?',
                                      style: TextStyle(
                                          color: kGrayTextC,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, "/login");
                                        },
                                        child: Text('Войти',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 16,
                                            )))
                                  ],
                                ),
                              ],
                            ),
                          ),
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
