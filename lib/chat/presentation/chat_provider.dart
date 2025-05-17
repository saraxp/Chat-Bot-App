import 'package:chat_bot/chat/data/gemini_api_service.dart';
import 'package:flutter/material.dart';
import '../model/message.dart';

class ChatProvider with ChangeNotifier {
  // gemini api service
  final _apiService = GeminiApiService();

  //messages and loading
  final List<Message> _messages = [];
  bool _isLoading = false;

  //getters
  List<Message> get messages => _messages;
  bool get isLoading => _isLoading;

  //send message
  Future<void> sendMessage(String content) async {
    //prevent empty sends
    if (content.trim().isEmpty) return;

    //user message
    final userMessage = Message(
        content: content,
        isUser: true,
        timeStamp: DateTime.now(),
    );

    //add user message to chat
    _messages.add(userMessage);

    //update screen
    notifyListeners();

    //start loading
    _isLoading = true;

    //update screen
    notifyListeners();

    // send message and receive response
    try{
      final response = await _apiService.sendMessage(content);

      //response message from AI
      final responseMessage = Message(
        content: response,
        isUser: false,
        timeStamp: DateTime.now(),
      );

      //add ai message to chat
      _messages.add(responseMessage);
    }
    catch(e){
      //error message
      final errorMessage = Message(
          content: "Oops, it looks like I encountered an issue!",
          isUser: false,
          timeStamp: DateTime.now(),
      );

      //add ai error msg to the add
      _messages.add(errorMessage);
    }

    //finished loading
    _isLoading = false;

    //update screen
    notifyListeners();

  }
}