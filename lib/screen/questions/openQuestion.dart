import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kodeks/fetches/fetchComment.dart';
import 'package:kodeks/fetches/fetchOpenQuestion.dart';
import 'package:kodeks/model/commentModel.dart';
import 'package:kodeks/model/likesQuestionModel.dart';
import 'package:kodeks/model/openQuestionModel.dart';
import 'package:kodeks/screen/chat/chat_message.dart';
import 'package:kodeks/service/api_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../fetches/fetchLikesQuestion.dart';
import '../doc/select_document/select_doc_provider.dart';

class OpenQuestionPage extends StatefulWidget {
  final String id;
  final pref;
  const OpenQuestionPage({Key? key, required this.id,required this.pref}) : super(key: key);

  @override
  _OpenQuestionPageState createState() => _OpenQuestionPageState();
}

class _OpenQuestionPageState extends State<OpenQuestionPage> {

  List<ChatMessage> comments = [
    ChatMessage(
        text:
        'Саламатсынарбы Саламатсынарбы Саламатсынарбы Саламатсынарбы Саламатсынарбы ',
        isUser: false),
    ChatMessage(
        text:
        'Саламатсынарбы Саламатсынарбы Саламатсынарбы Саламатсынарбы Саламатсынарбы ',
        isUser: false),
    ChatMessage(
        text:
        'Саламатсынарбы Саламатсынарбы Саламатсынарбы Саламатсынарбы Саламатсынарбы ',
        isUser: false),
    ChatMessage(
        text:
        'Саламатсынарбы Саламатсынарбы Саламатсынарбы Саламатсынарбы Саламатсынарбы ',
        isUser: false),
    ChatMessage(
        text:
        'Саламатсынарбы Саламатсынарбы Саламатсынарбы Саламатсынарбы Саламатсынарбы ',
        isUser: false),
    ChatMessage(
        text:
        'Саламатсынарбы Саламатсынарбы Саламатсынарбы Саламатсынарбы Саламатсынарбы ',
        isUser: false),
  ];

  TextEditingController _commentController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Вопрос'),
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              FutureBuilder<OpenQuestionModel>(
                future: fetchOpenQuestion(widget.id),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    var path = snapshot.data!.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          path.title!,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          path.question!,
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        SizedBox(height: 60),
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              FutureBuilder<LikesQuestionModel>(
                future: fetchLikesQuestion(
                  widget.id,
                  Provider.of<SelectCatProvider>(context, listen: false)
                      .userId,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    var path = snapshot.data!.data!;
                    return Container(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              if (!path.isLiked!)
                                await ApiService().postLikeQuestion(
                                  questionId: widget.id,
                                  userId: Provider.of<SelectCatProvider>(
                                    context,
                                    listen: false,
                                  ).userId,
                                );

                              if (path.isLiked!)
                                await ApiService().deleteLikesQuestion(
                                  widget.id,
                                  Provider.of<SelectCatProvider>(context,
                                    listen: false,
                                  ).userId,
                                );
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.thumb_up,
                              color: path.isLiked! ? Colors.red : Colors.grey,
                            ),
                          ),
                          Text(
                            path.count.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              widget.pref.getString("roleKey") == "ROLE_LAWYER" ? getCommentAndButton() : Container(),
              SizedBox(height: 20),
              Divider(height: 1, color: Colors.black),
              SizedBox(height: 20),
              Text(
                'Комментарии',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(

                  child: FutureBuilder<CommentModel>(
                    future: fetchComment(widget.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasData) {
                        var path = snapshot.data!.data!;
                        return ListView(
                          children: [
                            for (var i = 0; i < path.length; i++)
                              ChatMessage(
                                text: path[i].comment!,
                                isUser: false,
                              ),
                          ],
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCommentAndButton(){
    return Column(
      children: [
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: 'Ответ на вопрос',
                ),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () async {
                String comment = _commentController.text.trim();
                if (comment.isNotEmpty) {
                  if (widget.pref.getString("roleKey") == "ROLE_LAWYER") {
                    // Send the comment to the server
                    // Replace `sendCommentToServer` with your actual function to send the comment
                    if(await sendCommentToServer(widget.pref.getInt("idKey"),comment)){
                      _commentController.clear();
                      setState(() {
                      });
                    }
                    // Clear the comment text field after sending
                  } else {
                    // User is not a lawyer, show a message or handle the scenario accordingly
                    // Replace `showUserRoleErrorMessage` with your actual error handling logic
                    showUserRoleErrorMessage();
                  }
                }
              },
              child: Text('Отправить'),
            ),
          ],
        ),],
    );
  }

  Future<bool> sendCommentToServer(int? userId,String comment) async {
    return await ApiService().postNewComment(widget.id,userId!,comment);
  }

  void showUserRoleErrorMessage() {
    // Replace this with your actual error handling or notification logic
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Access Denied'),
        content: Text('Only lawyers can reply to comments.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
