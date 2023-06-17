import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kodeks/service/api_service.dart';

import '../widgets/messageContainer.dart';
import 'chat/chat_message.dart';

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
      body: load
          ? Center(child: CircularProgressIndicator())
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
                          maxLines: null,
                          expands: true,
                          controller: questionController,
                          decoration: InputDecoration(
                            isDense: true,
                              hintText: "Пишите свой вопрос...",
                              border: InputBorder.none),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () async {
                          setState(() {
                            load = !load;
                          });

                          questions.add(ChatMessage(
                            text: questionController.text,
                            isUser: true,
                          ));
/*
                          messages.add(ChatMessage(
                            text: botResponse,
                            isUser: false,
                          ));*/
                          var ans = await ApiService()
                              .postSendQuestion(questionController.text);
                          answers.add(ChatMessage(
                            text: ans,
                            isUser: false,
                          ));
                          // await ApiService().getDoc();
                          setState(() {
                            load = !load;
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
