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
      appBar: AppBar(),
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
                            backgroundColor: Colors.grey,
                            message: questions[i],
                            textColor: Colors.white,
                            padding: EdgeInsets.all(6),
                            borderRadius: 10,
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.topLeft,
                          child: MessageContainer(
                            backgroundColor: Colors.grey,
                            message: answers[i],
                            textColor: Colors.white,
                            padding: EdgeInsets.all(6),
                            borderRadius: 10,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  SizedBox(
                    height: 80,
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 60.h,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: questionController,
                          decoration: InputDecoration(
                              hintText: "Write message...",
                              hintStyle: TextStyle(color: Colors.black54),
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
