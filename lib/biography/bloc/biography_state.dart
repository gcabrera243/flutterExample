import 'package:equatable/equatable.dart';

class BiographyState extends Equatable {
  const BiographyState({required this.text});

  const BiographyState.initial() : this(text: '');

  final String text;

  @override
  List<Object?> get props => [text];

  BiographyState copyWith({String? text}) {
    return BiographyState(text: text ?? this.text);
  }
}
