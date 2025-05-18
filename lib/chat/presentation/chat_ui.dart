import 'package:chat_bot/chat/presentation/chat_bubble.dart';
import 'package:chat_bot/chat/presentation/chat_provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChatUi extends StatefulWidget {
  const ChatUi({super.key});

  @override
  State<ChatUi> createState() => _ChatUiState();
}

class _ChatUiState extends State<ChatUi> with SingleTickerProviderStateMixin {
  final _controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(
        child: Column(
          children:[
            //Top section: chat messages
            Expanded(
                child: Consumer<ChatProvider>(
                    builder: (context, chatProvider, child){
                      //empty
                      if (chatProvider.messages.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Chat to know',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              AnimatedTextKit(
                                animatedTexts: [
                                  ColorizeAnimatedText(
                                    'Anything',
                                    textStyle: const TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    colors: [
                                      Color(0xff173236),
                                      Color(0xff63d9e9),
                                      Color(0xff0a3c43),
                                    ],
                                    speed: const Duration(milliseconds: 1000),
                                  ),
                                ],
                                isRepeatingAnimation: true,
                                repeatForever: true,
                                pause: Duration(milliseconds: 0),
                                  displayFullTextOnTap: false,
                                  stopPauseOnTap: false
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: chatProvider.messages.length,
                        itemBuilder: (context, index) {
                          //fetch each msg
                          final message = chatProvider.messages[index];
        
                          //return message
                          return ChatBubble(message: message);
                        }
                      );
                  },
            ),
            ),

            //loading indicator
            Consumer<ChatProvider>(
                builder: (context, chatProvider, child) {
                  if (chatProvider.isLoading) {
                    return const LinearProgressIndicator();
                  }
                  return const SizedBox();
                }
            ),

            //user input box
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff173236), // Shadow color
                    blurRadius: 12,        // How soft the shadow is
                    offset: Offset(0, 5),  // Horizontal & vertical movement
                    spreadRadius: 1,       // How big the shadow spreads
                  ),
                ],
                color: Color(0xffe7e7e7),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                  child: Row(
                      children: [
                      // left - text box
                        Expanded(child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                                hintText: 'Ask Away',
                                hintStyle: TextStyle(color: Color(0xff173236)),
                                border: InputBorder.none,
                            ),
                        )),

                      //right - send button
                        IconButton(
                            onPressed: () {
                              if(_controller.text.isNotEmpty){
                               final chatProvider = context.read<ChatProvider>();
                               chatProvider.sendMessage(_controller.text);
                               _controller.clear();
                              }
                            },
                            icon: const Icon(Icons.send_rounded, color: Color(0xff173236),)),

                    ],
                  ),
                ),
            ),
          ],
        ),
      )
    );
  }
}


