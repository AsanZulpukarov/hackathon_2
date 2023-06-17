import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kodeks/colors.dart';
import 'package:kodeks/fetches/fetch_user_info.dart';
import 'package:kodeks/model/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LawyerProfileScreen extends StatefulWidget {
  @override
  State<LawyerProfileScreen> createState() => _LawyerProfileScreenState();
}

class _LawyerProfileScreenState extends State<LawyerProfileScreen> {
  late Future<UserEntity> futureUserEntity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureUserEntity = fetchUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 812));

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Layer'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: futureUserEntity,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 24.h),
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 80.w,

                            backgroundColor: kGreenColor,
                            backgroundImage: AssetImage('assets/profile.png'),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            snapshot.data?.data?.name ?? "Пусто",
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 24.h),
                      margin: EdgeInsets.only(top: 24.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.w),
                      ),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.email,color: Theme.of(context).primaryColor,),
                            title: Text(
                              snapshot.data?.data?.email ?? "Пусто",),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone,color: Theme.of(context).primaryColor,),
                            title: Text(
                              snapshot.data?.data?.phoneNumber ?? "Пусто",),
                          ),
                          ListTile(
                            leading: Icon(Icons.layers,color: Theme.of(context).primaryColor,),
                            title: Text(snapshot.data?.data?.status == 1 ? "Вас одобрили как юриста!": "Идет проверка сертификата"),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.clear();
                              Navigator.popAndPushNamed(context, "/login");
                            },
                            child: Text('Выйти'),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            else if(snapshot.hasError){
              return Center(child: Text("hasError"),);
            }
            else{
              return Center(child: CircularProgressIndicator(),);
            }
          },
        ),
      ),
    );
  }

}
