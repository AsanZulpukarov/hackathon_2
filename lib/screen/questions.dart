import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kodeks/fetches/fetchGPT.dart';
import 'package:kodeks/model/GPTModel.dart';
import 'package:kodeks/screen/questions/openQuestion.dart';
import 'package:kodeks/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/messageContainer.dart';
import 'chat/chat_message.dart';
import 'chat/instructions.dart';

class ChatScreenGPT extends StatefulWidget {
  const ChatScreenGPT({Key? key}) : super(key: key);

  @override
  State<ChatScreenGPT> createState() => _ChatScreenGPTState();
}

class _ChatScreenGPTState extends State<ChatScreenGPT> {
  TextEditingController questionController = TextEditingController();
  bool load = false;
  List<ChatMessage> answers = [];
  List<ChatMessage> questions = [];
  String tempAns = '';

  List<Instructions> instructions = [];

  @override
  void dispose() {
    questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Чат"),
      ),
      body: questions.length > 0
          ? FutureBuilder<GPTModel>(
              future: fetchGPT(questions.last.text),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  var path = snapshot.data!.data!;
                  if (tempAns == path.answer!) {
                    return Center(child: CircularProgressIndicator());
                  } else
                    return Stack(children: [
                      ListView(
                        padding: EdgeInsets.all(20),
                        children: <Widget>[
                          Column(
                            children: [
                              questions.last,
                              SizedBox(height: 15.h),
                              ChatMessage(
                                  text: path.answer!.replaceAll('\n', ''),
                                  isUser: false),
                              SizedBox(height: 10.h),
                              Divider(height: 1, color: Colors.grey),
                              if (path.instructions!.length > 0)
                                InstructionsMessage(
                                    text: 'Инструкции:', isUser: false),
                              if (path.instructions!.length > 0)
                                for (var j = 0;
                                    j < path.instructions!.length;
                                    j++)
                                  GestureDetector(
                                    onTap: () {
                                      print(path.instructions![j].id);
                                      Navigator.pushNamed(
                                          context, "/category/instructions/id",
                                          arguments: path.instructions![j].id);
                                    },
                                    child: InstructionsMessage(
                                        text: path.instructions![j].title!,
                                        isUser: false),
                                  ),
                              SizedBox(height: 10.h),
                              Divider(height: 1, color: Colors.grey),
                              if (path.popularQuestions!.length > 0)
                                InstructionsMessage(
                                    text: 'Актуальные вопросы:', isUser: false),
                              if (path.popularQuestions!.length > 0)
                                for (var j = 0;
                                    j < path.popularQuestions!.length;
                                    j++)
                                  GestureDetector(
                                    onTap: () async {
                                      SharedPreferences pref =
                                          await SharedPreferences.getInstance();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                OpenQuestionPage(
                                              id: path.popularQuestions![j].id
                                                  .toString(),
                                              pref: pref,
                                            ),
                                          ));
                                    },
                                    child: InstructionsMessage(
                                        text:
                                            path.popularQuestions![j].question!,
                                        isUser: false),
                                  ),
                            ],
                          ),
                          SizedBox(
                            height: 80.h,
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 80.h,
                          width: double.infinity,
                          color: Colors.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              /*IconButton(
                        icon: Icon(Icons.category),
                        onPressed: () {
                          // Действие при нажатии на кнопку выбора категории
                          // Можете открыть диалоговое окно с выбором категории или
                          // перейти на отдельную страницу для выбора категории.
                        },
                      ),*/
                              Expanded(
                                child: TextField(
                                  controller: questionController,
                                  decoration: InputDecoration(
                                      hintText: "Пишите свой вопрос...",
                                      border: InputBorder.none),
                                ),
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  questions.add(ChatMessage(
                                    text: questionController.text,
                                    isUser: true,
                                  ));
                                  questionController.clear();
                                  tempAns = path.answer!;
                                  setState(() {});

/*
                          messages.add(ChatMessage(
                            text: botResponse,
                            isUser: false,
                          ));*/

                                  // await ApiService().getDoc();
                                },
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: 18.sp,
                                ),
                                backgroundColor: Theme.of(context).primaryColor,
                                elevation: 0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]);
                }
                return const Center(child: CircularProgressIndicator());
              },
            )
          : Stack(children: [
              ListView(
                padding: EdgeInsets.all(20),
                children: <Widget>[
                  for (var i = 0; i < answers.length; i++)
                    Column(
                      children: [
                        questions[i],
                        SizedBox(height: 15.h),
                        answers[i],
                        SizedBox(height: 10.h),
                      ],
                    ),
                  SizedBox(
                    height: 80.h,
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 80.h,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      /*IconButton(
                        icon: Icon(Icons.category),
                        onPressed: () {
                          // Действие при нажатии на кнопку выбора категории
                          // Можете открыть диалоговое окно с выбором категории или
                          // перейти на отдельную страницу для выбора категории.
                        },
                      ),*/
                      Expanded(
                        child: TextField(
                          controller: questionController,
                          decoration: InputDecoration(
                              hintText: "Пишите свой вопрос...",
                              border: InputBorder.none),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          questions.add(ChatMessage(
                            text: questionController.text,
                            isUser: true,
                          ));
/*
                          messages.add(ChatMessage(
                            text: botResponse,
                            isUser: false,
                          ));*/

                          // await ApiService().getDoc();

                          setState(() {
                            questionController.clear();
                          });
                        },
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                        elevation: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
    );
  }
}
