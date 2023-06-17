import 'package:flutter/material.dart';
import 'package:kodeks/fetches/fetchComment.dart';
import 'package:kodeks/fetches/fetchOpenQuestion.dart';
import 'package:kodeks/model/commentModel.dart';
import 'package:kodeks/model/likesQuestionModel.dart';
import 'package:kodeks/model/openQuestionModel.dart';
import 'package:kodeks/screen/chat/chat_message.dart';
import 'package:kodeks/service/api_service.dart';
import 'package:provider/provider.dart';

import '../../fetches/fetchLikesQuestion.dart';
import '../doc/select_document/select_doc_provider.dart';

class OpenQuestionPage extends StatefulWidget {
  final id;

  const OpenQuestionPage({Key? key, required this.id}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Вопрос'),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            SizedBox(height: 40),
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
                      Text(path.title!,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w400)),
                      SizedBox(height: 20),
                      Text(path.question!,
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                      SizedBox(height: 60)
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
                      .userId),
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
                                            listen: false)
                                        .userId);

                              if (path.isLiked!)
                                await ApiService().deleteLikesQuestion(
                                    widget.id,
                                    Provider.of<SelectCatProvider>(context,
                                            listen: false)
                                        .userId);
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.thumb_up,
                              color: path.isLiked! ? Colors.red : Colors.grey,
                            )),
                        Text(path.count.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
            SizedBox(height: 20),
            Divider(height: 1, color: Colors.black),
            SizedBox(height: 20),
            Text('Комментарии',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400)),
            SizedBox(height: 20),
            FutureBuilder<CommentModel>(
              future: fetchComment(widget.id),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  var path = snapshot.data!.data!;
                  return ListView(
                    children: [
                      for (var i = 0; i < path.length!; i++)
                        ChatMessage(text: path[i].comment!, isUser: false)
                    ],
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
