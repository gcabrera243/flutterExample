import 'dart:async';

import 'package:biblioteca/chat/bloc/chat_bloc.dart';
import 'package:biblioteca/chat/bloc/chat_event.dart';
import 'package:biblioteca/chat/models/message.dart';
import 'package:biblioteca/package_ui/package_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key});

  static const preguntasFrecuentes = [
    "¿Quién es Dora Isella Russell?",
    "¿Quién es Juana de Ibarbourou?",
    "¿Cuál es la relación entre Dora Isella Russell y Juana de Ibarbourou?",
  ];

  final ScrollController scrollController = ScrollController();
  static int lastMessagesCount = 0;

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 50), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final messages = context.select((ChatBloc bloc) => bloc.state.messages);

    if (messages.length > lastMessagesCount) {
      scrollToBottom();
      lastMessagesCount = messages.length;
    }
    final isWaitingForResponse =
        context.select((ChatBloc bloc) => bloc.state.isWaitingForResponse);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 12, right: 24, left: 24),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 0.0),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        if (messages.isEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Hola, soy Iber-Chatbot, experto conocedor de la vida de Dora Isella Russell y Juana de Ibarbourou. Preguntame lo que quieras, si no te viene nada a la mente, aqui tienes algunas recomendaciones para romper el hielo.',
                              textAlign: TextAlign.justify,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        if (messages.isEmpty)
                          ...preguntasFrecuentes.map(
                            (faq) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SecondaryButton(
                                onPressed: () {
                                  context
                                      .read<ChatBloc>()
                                      .add(ChatInputSent(faq));
                                },
                                text: faq,
                              ),
                            ),
                          ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            return MessageBubble(
                              text: message.content,
                              isFromUser: message.role == Role.user.name,
                              documents: message.documents,
                            );
                          },
                        ),
                        if (isWaitingForResponse)
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 20),
        child: _Input(),
      ),
    );
  }
}

class _Input extends StatefulWidget {
  const _Input();

  @override
  State<_Input> createState() => _InputState();
}

class _InputState extends State<_Input> {
  final TextEditingController _controller = TextEditingController();
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = context.read<ChatBloc>().stream.listen((state) {
      if (state.input != _controller.text) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _controller.text = state.input;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isWaitingForResponse =
        context.watch<ChatBloc>().state.isWaitingForResponse;
    final disabled = _controller.text.isEmpty || isWaitingForResponse;

    return SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextInput(
              textEditingController: _controller,
              hintText: 'Ingrese su búsqueda...',
              maxLines: null,
            ),
          ),
          const SizedBox(width: 12.0),
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 36.0),
              child: PrimaryButton(
                disabled: disabled,
                text: 'Enviar',
                onPressed: () {
                  context
                      .read<ChatBloc>()
                      .add(ChatInputSent(_controller.text.trim()));
                  _controller.clear();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _subscription?.cancel();
    super.dispose();
  }
}
