import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kodeks/fetches/fetch_all_petition.dart';
import 'package:kodeks/model/petition_model.dart';
import 'package:kodeks/screen/petition_screen/select_petition_screen.dart';
import 'package:kodeks/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListPetition extends StatefulWidget {
  const ListPetition({Key? key}) : super(key: key);

  @override
  State<ListPetition> createState() => _ListPetitionState();
}

class _ListPetitionState extends State<ListPetition> {
  List<XFile> imageFile = [];
  late XFile imageFileCamera;
  final ImagePicker _picker = ImagePicker();
  late Future<PetitionModel> futurePetitions;

  @override
  void initState() {
    super.initState();
    futurePetitions = fetchPetitions();
  }

  void showAddPetitionDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    GlobalKey key;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Petition'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheet(context)));
                  },
                  child: Text("Загрузить фото"))
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                String title = titleController.text.trim();
                String description = descriptionController.text.trim();

                if (title.isNotEmpty && description.isNotEmpty) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  ApiService().postAddPetition(
                      imageFile[0], title, description, prefs.getInt("idKey")!);
                }

                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Петиции')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: futurePetitions,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height *
                          0.7, // Set a fixed height for the container
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, _) => SizedBox(width: 5),
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectPetitionScreen(
                                      snapshot.data!.data![index].id!)),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 450,
                                width: MediaQuery.of(context).size.width * 0.7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        "http://${ApiService.ip}:2323/storage/${snapshot.data?.data![index].photo ?? ""}"),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                color: Colors.grey[200],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      snapshot.data!.data![index].title ??
                                          "Пусто",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                        snapshot.data!.data![index]
                                                .description ??
                                            "Пусто",
                                        style: TextStyle(fontSize: 14)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            ElevatedButton(
              onPressed: () => showAddPetitionDialog(context),
              child: Text("Добавить свою петицию"),
            ),
          ],
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
                    'Сохранить',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
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
