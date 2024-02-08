import 'package:biblioteca/home/bloc/home_state.dart';
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomePageSelectedChanged extends HomeEvent {
  const HomePageSelectedChanged({required this.pageSelected});

  final PageSelected pageSelected;

  @override
  List<Object?> get props => [pageSelected];
}

class HomeDataRequested extends HomeEvent {
  @override
  List<Object> get props => [];
}
