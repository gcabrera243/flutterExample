import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class ChatInputChanged extends ChatEvent {
  final String input;

  const ChatInputChanged(this.input);

  @override
  get props => [input];
}

class ChatInputSent extends ChatEvent {
  final String input;

  const ChatInputSent(this.input);

  @override
  get props => [input];
}
