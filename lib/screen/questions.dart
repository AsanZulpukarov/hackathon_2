import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kodeks/service/api_service.dart';

import '../widgets/messageContainer.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController questionController = TextEditingController();
  bool load = false;
  List<String> answers = [];
  List<String> questions = [];

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
                        Align(
                          alignment: Alignment.topRight,
                          child: MessageContainer(
                            backgroundColor: Theme.of(context).primaryColor,
                            message: questions[i],
                            textColor: Colors.white,
                            padding: EdgeInsets.all(6),
                            borderRadius: 10.r,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Align(
                          alignment: Alignment.topLeft,
                          child: MessageContainer(
                            backgroundColor: Colors.white,
                            message: answers[i],
                            textColor: Theme.of(context).primaryColor,
                            padding: EdgeInsets.all(6),
                            borderRadius: 10,
                          ),
                        ),
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
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 80.h,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: questionController,
                          decoration: InputDecoration(
                              hintText: "Пишите свой вопрос...",
                              border: InputBorder.none),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () async {
                          setState(() {
                            load = !load;
                          });

                          questions.add(questionController.text);
                          var ans = await ApiService()
                              .postSendQuestion(questionController.text);
                          answers.add(ans);
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
