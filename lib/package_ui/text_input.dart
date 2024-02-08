import 'package:biblioteca/chat/bloc/chat_bloc.dart';
import 'package:biblioteca/chat/bloc/chat_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextInput extends StatelessWidget {
  final String? hintText;
  final int? maxLines;
  final TextEditingController textEditingController;

  const TextInput({
    Key? key,
    this.hintText,
    this.maxLines,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(),
      child: TextField(
        maxLength: 500,
        onChanged: (value) {
          context.read<ChatBloc>().add(ChatInputChanged(value));
        },
        style: Theme.of(context).textTheme.bodyMedium,
        controller: textEditingController,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
