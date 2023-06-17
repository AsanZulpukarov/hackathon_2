import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isUser
              ? Expanded(
                  child: Container(),
                )
              : Container(
                  margin: EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(child: Text('B')),
                ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: isUser ? Colors.blue : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
          isUser
              ? Container(
                  margin: EdgeInsets.only(left: 16.0),
                  child: CircleAvatar(child: Text('U')),
                )
              : Expanded(
                  child: Container(),
                ),
        ],
      ),
    );
  }
}
