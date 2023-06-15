import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 812));

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 24.h),
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 80.w,
                    backgroundImage: AssetImage('assets/logo.png'),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Asan Zulpukarov',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              margin: EdgeInsets.only(top: 24.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.w),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text('@gmail.com'),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('+996 990 551 380'),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('Bishkek'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Реализуйте действие кнопки
                    },
                    child: Text('Выйти'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
