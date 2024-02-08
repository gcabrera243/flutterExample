import 'package:biblioteca/chat/models/message.dart';
import 'package:equatable/equatable.dart';

class ChatState extends Equatable {
  const ChatState({
    required this.input,
    required this.messages,
    required this.isWaitingForResponse,
  });

  final String input;
  final List<Message> messages;
  final bool isWaitingForResponse;

  const ChatState.initial()
      : this(
            input: "",
            messages: const <Message>[],
            isWaitingForResponse: false);

  @override
  List<Object?> get props => [input, messages, isWaitingForResponse];

  ChatState copyWith({
    String? input,
    List<Message>? messages,
    bool? isWaitingForResponse,
  }) {
    return ChatState(
      input: input ?? this.input,
      messages: messages ?? this.messages,
      isWaitingForResponse: isWaitingForResponse ?? this.isWaitingForResponse,
    );
  }
}
