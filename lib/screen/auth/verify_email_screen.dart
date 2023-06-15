import 'dart:async';
import 'package:flutter/material.dart';

import '../../widgets/check_email_widget.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = false;
    // isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    // if (isEmailVerified == false) {
    //   sendVerificationEmail();
    //
    //   timer = Timer.periodic(
    //       const Duration(seconds: 1), (_) => checkEmailVerified());
    // }
  }

  // Future sendVerificationEmail() async {
  //   final user = FirebaseAuth.instance.currentUser!;
  //   await user.sendEmailVerification().then((value) {
  //     ToastMessage().toastMessage('Email sent!', Colors.green);
  //   }).onError((error, stackTrace) {
  //     ToastMessage().toastMessage(error.toString(), Colors.red);
  //   });
  // }

  // Future checkEmailVerified() async {
  //   await FirebaseAuth.instance.currentUser!.reload();
  //   setState(() {
  //     isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
  //   });
  //
  //   if (isEmailVerified == true) {
  //     timer?.cancel();
  //
  //     DatabaseReference splitRef =
  //         ref.child(user.uid.toString()).child('split');
  //     splitRef.set({
  //       'amount': 0,
  //       'need': 0,
  //       'expenses': 0,
  //       'savings': 0,
  //       'totalBalance': 0,
  //       'needAvailableBalance': 0,
  //       'expensesAvailableBalance': 0,
  //       'count': 1,
  //       'isEFenabled': false,
  //       'isCPenabled': false,
  //       'isAutopayOn': false,
  //       'targetEmergencyFunds': 0,
  //       'collectedEmergencyFunds': 0,
  //     });
  //   }
  // }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      // ? const UpdateAccountScreen()
      ? Container()
      : WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'A verification link has been\nsent to your email!',
                    style: TextStyle(
                        fontSize: 20, color: Theme.of(context).cardColor),
                    textAlign: TextAlign.center,
                  ),
                  CheckEmailWidget(
                    mailText:
                        'You will get automatically logged\nin once you verify your email',
                    btnText: 'Resend Email',
                    // onPressed: sendVerificationEmail),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        );
}
