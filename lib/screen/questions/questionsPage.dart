import 'package:flutter/material.dart';
import 'package:kodeks/colors.dart';
import 'package:kodeks/fetches/questions_fetch.dart';
import 'package:kodeks/model/questions_model.dart';
import 'package:kodeks/screen/questions/openQuestion.dart';
import 'package:kodeks/service/api_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../fetches/category_fetche.dart';
import '../../model/category_model.dart';
import '../doc/select_document/select_doc_provider.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({Key? key}) : super(key: key);

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  TextEditingController title = TextEditingController();
  TextEditingController question = TextEditingController();
  bool load = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Вопросы'),
      ),
      body: FutureBuilder(
        future: fetchQuestions(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            var path = snapshot.data!.data!;
            return Stack(
              children: [
                ListView.builder(
                  padding: EdgeInsets.all(12),
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context, int index) {
                    return Container(
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Ink(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                path[index].title!,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                path[index].question!,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.calendar_month,
                                      color: Theme.of(context).primaryColor),
                                  Text(path[index].updatedAt!.split('T').first),
                                ],
                              ),
                            ],
                          ),
                        ),
                        onTap: () async{
                          SharedPreferences pref = await SharedPreferences.getInstance();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OpenQuestionPage(
                                    id: path[index].id.toString(),pref: pref,),
                              ));
                        },
                      ),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20, bottom: 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: ((builder) {
                              return Padding(
                                padding: const EdgeInsets.all(20),
                                child: Container(
                                  height: 300,
                                  child: ListView(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: kGreenColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: TextField(
                                          controller: title,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          style: TextStyle(
                                            color: Color(0xFF225196),
                                            fontSize: 16,
                                          ),
                                          decoration: InputDecoration(
                                            hintStyle: TextStyle(
                                              color: Color(0xFF225196)
                                                  .withOpacity(0.5),
                                            ),
                                            hintText: 'Название',
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: kGreenColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: TextField(
                                          controller: question,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          style: TextStyle(
                                            color: Color(0xFF225196),
                                            fontSize: 16,
                                          ),
                                          decoration: InputDecoration(
                                            hintStyle: TextStyle(
                                              color: Color(0xFF225196)
                                                  .withOpacity(0.5),
                                            ),
                                            hintText: 'Задать вопрос',
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (builder) {
                                                return Container(
                                                  padding: EdgeInsets.all(10),
                                                  height: 300,
                                                  child: FutureBuilder<
                                                      CategoryModel>(
                                                    future: fetchCategory(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasError) {
                                                        return const Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      }
                                                      if (snapshot.hasData) {
                                                        var path = snapshot
                                                            .data!.data!;
                                                        return ListView
                                                            .separated(
                                                          separatorBuilder:
                                                              (context,
                                                                      index) =>
                                                                  SizedBox(
                                                            height: 10,
                                                          ),
                                                          itemCount:
                                                              path.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return InkWell(
                                                              onTap: () {
                                                                Provider.of<SelectCatProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .toggleSelect(
                                                                        path[index]
                                                                            .name!,
                                                                        path[index]
                                                                            .id!
                                                                            .toString());
                                                                Navigator.pop(
                                                                    context);
                                                                setState(() {});
                                                              },
                                                              child: Ink(
                                                                height: 65,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    width: 1,
                                                                    color:
                                                                        kGreenColor,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    path[index]
                                                                        .name!,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          0xFF225196),
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      }
                                                      return const Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    },
                                                  ),
                                                );
                                              });
                                        },
                                        child: Ink(
                                          height: 65,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: kGreenColor,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              Provider.of<SelectCatProvider>(
                                                              context)
                                                          .category ==
                                                      ''
                                                  ? 'Выберите категорию'
                                                  : Provider.of<
                                                              SelectCatProvider>(
                                                          context)
                                                      .category,
                                              style: TextStyle(
                                                color: Color(0xFF225196),
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      ElevatedButton(
                                          onPressed: () async {
                                            load = !load;
                                            setState(() {});
                                            bool ans;
                                            print(
                                                Provider.of<SelectCatProvider>(
                                                        context,
                                                        listen: false)
                                                    .categoryId);
                                            ans = await ApiService()
                                                .postCreateMyQuestion(
                                                    title: title.text,
                                                    myQuestion: question.text,
                                                    userId: '1',
                                                    categoryId: Provider.of<
                                                                SelectCatProvider>(
                                                            listen: false,
                                                            context)
                                                        .categoryId);
                                            if (ans) {
                                              load = !load;
                                              setState(() {});
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: load
                                              ? CircularProgressIndicator()
                                              : Text('Отправить'))
                                    ],
                                  ),
                                ),
                              );
                            }));
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                      elevation: 0,
                    ),
                  ),
                )
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget Select_doc_type(String queTitle, String question) {
    return InkWell(
      onTap: () {},
      child: Ink(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: kGreenColor,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(queTitle,
              style: TextStyle(color: Colors.black, fontSize: 18)),
          subtitle: Text(
            question,
          ),
        ),
      ),
    );
  }
}
