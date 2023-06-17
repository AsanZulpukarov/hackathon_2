import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';


class SendFormData extends StatefulWidget {
  const SendFormData({Key? key}) : super(key: key);

  @override
  _SendFormDataState createState() => _SendFormDataState();
}

class _SendFormDataState extends State<SendFormData> {
  late String emailGet;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String hintText = 'Введите описания';

  List<XFile> imageFile = [];
  late XFile imageFileCamera;
  final ImagePicker _picker = ImagePicker();
  int select = 0;

  TextEditingController price = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  Widget bottomSheet() {
    return Container(
      height: 100.0,
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
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            InkWell(
              onTap: () {
                print('Camera');
                takePhotoCamera();
                print(imageFileCamera.path);
              },
              child: Ink(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
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
                print('Galery');
                await takePhotoGalery();
                print(imageFile[0].path);
              },
              child: Ink(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.image),
                    const SizedBox(height: 10),
                    const Text("Гелерея")
                  ],
                ),
              ),
            ),
          ])
        ],
      ),
    );
  }

  Future<void> takePhotoGalery() async {
    /*final pickedFile = await _picker.getImage(
      source: source
    );*/
    final List<XFile> images = await _picker.pickMultiImage();
    setState(() {
      imageFile.addAll(images);
    });
  }

  void takePhotoCamera() async {
    /*final pickedFile = await _picker.getImage(
      source: source
    );*/
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      imageFile.add(photo!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Подать объявление',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w400)),
          ),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.only(left: 39.0),
            child: Text('Загрузите фото',
                style: TextStyle(
                    color: Color(0xFF515151),
                    fontSize: 16,
                    fontWeight: FontWeight.w400)),
          ),
          const SizedBox(height: 7),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (imageFile.isNotEmpty)
                  Container(
                    height: 80,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, _) =>
                      const SizedBox(width: 5),
                      itemCount: imageFile.length,
                      itemBuilder: (context, index) => Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.blue,
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(imageFile[index].path)),
                            )),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 90),
        ],
      ),
    );
  }
}