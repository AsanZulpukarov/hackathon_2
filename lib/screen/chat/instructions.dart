import 'package:flutter/material.dart';
import 'package:kodeks/colors.dart';

class InstructionsMessage extends StatefulWidget {
  final String text;
  final bool isUser;

  InstructionsMessage({required this.text, required this.isUser});

  @override
  State<InstructionsMessage> createState() => _InstructionsMessageState();
}

class _InstructionsMessageState extends State<InstructionsMessage> {
  var styleTextCircular = TextStyle(color: Colors.white, fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.isUser
              ? Expanded(
                  child: Container(),
                )
              : Expanded(
                  child: Container(),
                ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: widget.isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: widget.isUser
                        ? Theme.of(context).primaryColor
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    widget.text,
                    style: TextStyle(
                        fontSize: 16.0,
                        decoration: TextDecoration.underline,
                        color: widget.text == 'Актуальные вопросы:'
                            ? kDarkCardC
                            : widget.text == 'Инструкции:'
                                ? kDarkCardC
                                : Colors.blue),
                  ),
                ),
              ],
            ),
          ),
          widget.isUser
              ? Container(
                  margin: EdgeInsets.only(left: 16.0),
                  child: CircleAvatar(
                    child: Text(
                      'U',
                      style: styleTextCircular,
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                )
              : Expanded(
                  child: Container(),
                ),
        ],
      ),
    );
  }
}
