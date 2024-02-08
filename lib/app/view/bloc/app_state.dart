import 'package:equatable/equatable.dart';

class AppState extends Equatable {
  const AppState();

  const AppState.initial() : this();

  @override
  List<Object?> get props => [];

  AppState copyWith() {
    return const AppState();
  }
}
