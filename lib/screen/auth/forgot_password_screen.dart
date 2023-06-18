import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kodeks/colors.dart';
import 'package:kodeks/widgets/button.dart';
import 'package:kodeks/widgets/text_field.dart';

import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  // void forgotPassword() {
  //   setState(() {
  //     loading = true;
  //   });
  //   _auth
  //       .sendPasswordResetEmail(email: emailController.text.toString())
  //       .then((value) {
  //     Navigator.pushReplacement(context,
  //         MaterialPageRoute(builder: (context) => const CheckMailScreen()));
  //     ToastMessage().toastMessage('Password reset email sent!', Colors.green);
  //     setState(() {
  //       loading = false;
  //     });
  //   }).onError((error, stackTrace) {
  //     ToastMessage().toastMessage(error.toString(), Colors.red);
  //     setState(() {
  //       loading = false;
  //     });
  //   });
  // }

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
                              vertical: 10, horizontal: 30),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: constraints.maxHeight * 0.015),
                                const Text(
                                  'Восстановить пароль',
                                  style: TextStyle(
                                    fontSize: 28,
                                  ),
                                ),
                                SizedBox(
                                  height: constraints.maxHeight * 0.03,
                                ),
                                Text(
                                  'Введите адрес электронной почты, связанный с вашей учетной записью, и мы вышлем вам ссылку для сброса пароля',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                                SizedBox(
                                  height: constraints.maxHeight * 0.03,
                                ),
                                CustomTextField(
                                  hint: 'Email',
                                  iconName: Icons.alternate_email,
                                  controller: emailController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Email';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: constraints.maxHeight * 0.04,
                                ),

                                // Container(child: TextB,)
                                TButton(
                                    loading: loading,
                                    constraints: constraints,
                                    btnColor: Theme.of(context).primaryColor,
                                    btnText: 'Сбросить пароль',
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        // forgotPassword();
                                      }
                                    }),
                                SizedBox(
                                  height: constraints.maxHeight * 0.03,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Вернуться в войти?',
                                      style: TextStyle(
                                          color: kGrayTextC,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginScreen()));
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
