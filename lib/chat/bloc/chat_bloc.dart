import 'dart:async';
import 'dart:convert';

import 'package:biblioteca/chat/bloc/chat_event.dart';
import 'package:biblioteca/chat/bloc/chat_state.dart';
import 'package:biblioteca/chat/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(const ChatState.initial()) {
    on<ChatInputChanged>(_onChatInputChanged);
    on<ChatInputSent>(_onChatInputSent);
  }

  FutureOr<void> _onChatInputChanged(
      ChatInputChanged event, Emitter<ChatState> emit) {
    emit(state.copyWith(input: event.input));
  }

  FutureOr<void> _onChatInputSent(
      ChatInputSent event, Emitter<ChatState> emit) async {
    if (event.input.isNotEmpty) {
      final newMessage = Message(role: Role.user.name, content: event.input);
      final previousMessages = List<Message>.from(state.messages);
      final newMessages = List<Message>.from(state.messages)..add(newMessage);
      var genericErrorMessage = Message(
          role: Role.system.name,
          content:
              'Ups, parece que el sistema no está funcionando. No puedo realizar la búsqueda en este momento.');
      emit(state.copyWith(
          messages: newMessages, input: "", isWaitingForResponse: true));

      try {
        final body = {
          'prompt': event.input,
          'context': previousMessages.map((e) => e.toJson()).toList()
        };

        final response = await http.post(
            Uri.parse('https://biblioteca-flask.reto-ucu.net/api'),
            headers: {
              'Content-Type': 'text/plain'
            },
            body: jsonEncode(body));

        if (response.statusCode == 200) {
          final Map<String, dynamic> data =
              jsonDecode(const Utf8Decoder().convert(response.bodyBytes));

          final String res = data['res'];
          final List<dynamic> documentsAsJSON = data['documents'];

          final documents =
              documentsAsJSON.map((d) => Document.fromJson(d)).toList();
          final newMessage = Message(
              role: Role.system.name, content: res, documents: documents);
          final newMessages = List<Message>.from(state.messages)
            ..add(newMessage);
          emit(state.copyWith(
              messages: newMessages, isWaitingForResponse: false));
        } else {
          throw Exception('Error al enviar el mensaje');
        }
      } catch (e) {
        emit(state.copyWith(
            messages: state.messages..add(genericErrorMessage),
            isWaitingForResponse: false));

        print('Error: $e');
      }
    } else {
      print('Empty input; not emitting state with new message');
    }
  }
}
