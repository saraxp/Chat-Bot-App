import 'package:chat_bot/chat/presentation/chat_bubble.dart';
import 'package:chat_bot/chat/presentation/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ChatUi extends StatefulWidget {
  const ChatUi({super.key});

  @override
  State<ChatUi> createState() => _ChatUiState();
}

class _ChatUiState extends State<ChatUi> with SingleTickerProviderStateMixin {
  final _controller = TextEditingController();
  late AnimationController _controllerB;

  @override
  void initState() {
    super.initState();
    _controllerB = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controllerB.dispose();
    super.dispose();
  }

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
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              AnimatedBuilder(
                                animation: _controllerB,
                                builder: (context, child) {
                                  return ShaderMask(
                                    shaderCallback: (bounds) {
                                      return LinearGradient(
                                        colors: [Color(0xff63d9e9), Color(0xff173236), Color(0xff0a3c43)],
                                        begin: Alignment(-1 + 2 * _controllerB.value, 0),
                                        end: Alignment(1 + 2 * _controllerB.value, 0),
                                        tileMode: TileMode.mirror,
                                      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
                                    },
                                    child: const Text(
                                      'Anything',
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white, // Required for ShaderMask
                                      ),
                                    ),
                                  );
                                },
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


