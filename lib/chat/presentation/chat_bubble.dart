import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';
import '../model/message.dart';

class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Align(
        alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: message.isUser ? Color(0xff06282d) : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: message.isUser
              ? Text(
                message.content,
                style: TextStyle(color: Colors.white),
              )
                  : GptMarkdown(
                message.content,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
          ),
        ),
      ),
    );
  }
}
