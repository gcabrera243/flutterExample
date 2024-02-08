import 'package:biblioteca/chat/models/document.dart';
import 'package:equatable/equatable.dart';

enum Role { user, system }

class Message extends Equatable {
  final String role;
  final String content;
  final List<Document>? documents;

  const Message({required this.role, required this.content, this.documents});

  Map<String, String> toJson() {
    return {
      'role': role.toString(),
      'content': content,
    };
  }

  @override
  List<Object?> get props => [role, content];
}
