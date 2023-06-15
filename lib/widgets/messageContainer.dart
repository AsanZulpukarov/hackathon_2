import 'package:flutter/material.dart';

class MessageContainer extends StatefulWidget {
  final String message;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsets padding;

  MessageContainer({
    required this.message,
    required this.backgroundColor,
    required this.textColor,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.all(16.0),
  });

  @override
  State<MessageContainer> createState() => _MessageContainerState();
}

class _MessageContainerState extends State<MessageContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      width: 200,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Text(
        widget.message,
        style: TextStyle(
          color: widget.textColor,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
