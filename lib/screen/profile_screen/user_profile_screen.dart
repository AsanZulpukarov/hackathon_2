import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kodeks/colors.dart';
import 'package:kodeks/fetches/fetch_user_info.dart';
import 'package:kodeks/model/user_entity.dart';
import 'package:kodeks/screen/profile_screen/lawyer_profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/api_service.dart';
import '../doc/select_document/select_doc_provider.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late Future<UserEntity> futureUserEntity;

  List<XFile> imageFile = [];

  late XFile imageFileCamera;

  final ImagePicker _picker = ImagePicker();

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
        title: Text('ProfileUser'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: futureUserEntity,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data?.data?.name);
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
                          SizedBox(
                            height: 16.h,
                          ),
                          if(Provider.of<SelectCatProvider>(context, listen: false)
                              .buttonView)
                          ElevatedButton(
                            onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) => bottomSheet(context)));
                            },
                            child: Text('Стать юристом'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 12.h),
                      margin: EdgeInsets.only(top: 24.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.w),
                      ),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(
                              Icons.email,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text(
                              snapshot.data?.data?.email ?? "Пусто",
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.phone,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text(
                              snapshot.data?.data?.phoneNumber ?? "Пусто",
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.location_on,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text('Bishkek'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.clear();
                              Navigator.popAndPushNamed(context, "/login");
                            },
                            child: Text('Выйти'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("hasError"),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            children: <Widget>[
              const Text(
                "Выберите фото",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Чтобы получить роль юриста вы должны загрузить фото сертификата об окончании образования.",
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      print('Camera');
                      takePhotoCamera(setState);
                      print(imageFileCamera.path);
                    },
                    child: Ink(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.camera),
                          const SizedBox(height: 10),
                          const Text("Камера")
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () async {
                      print('Gallery');
                      await takePhotoGallery(setState);
                      print(imageFile[0].path);
                    },
                    child: Ink(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.image),
                          const SizedBox(height: 10),
                          const Text("Галерея")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(20),
                height: 100,
                width: 100,
                child: imageFile.isNotEmpty
                    ? Image.file(File(imageFile[0].path))
                    : Placeholder(
                  fallbackHeight: 100,
                  fallbackWidth: 100,
                  color: Colors.grey,
                ),
              ),
              Center(
                child: ElevatedButton(
                  child: Text(
                    'Отправить',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  onPressed: () async{
                    SharedPreferences pref = await SharedPreferences.getInstance();
                    bool ans=await ApiService().postCheckCertificate(imageFile[0], pref.getInt("idKey")!);
                    if(ans) {
                      Provider.of<SelectCatProvider>(context, listen: false)
                          .buttonFalse();
                      pref.setString("role", "ROLE_LAWYER");
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> takePhotoGallery(StateSetter setState) async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      setState(() {
        imageFile = images;
      });
    }
  }

  void takePhotoCamera(StateSetter setState) async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        imageFile = [photo];
      });
    }
  }

}
