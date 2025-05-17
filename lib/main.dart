import 'package:flutter/material.dart';
import 'package:chat_bot/chat/presentation/chat_provider.dart';
import 'package:provider/provider.dart';
import 'package:chat_bot/chat/presentation/chat_ui.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ChatProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:ChatUi(),
    );
  }
}
