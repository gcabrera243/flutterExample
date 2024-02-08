import 'package:biblioteca/chat/bloc/chat_bloc.dart';
import 'package:biblioteca/chat/view/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends Page<void> {
  const ChatPage({super.key});

  static const path = '/chat';

  @override
  Route<void> createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (ctx) {
        return BlocProvider(
          create: (_) => ChatBloc(),
          child: ChatView(),
        );
      },
    );
  }
}
