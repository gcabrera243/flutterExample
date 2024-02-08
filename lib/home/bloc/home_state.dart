import 'package:equatable/equatable.dart';

enum PageSelected {
  home,
  bibliography,
  chat,
  ;

  bool get isHome => this == home;
  bool get isChat => this == chat;
  bool get isBibliography => this == bibliography;
}

class HomeState extends Equatable {
  const HomeState({required this.pageSelected, required this.text});

  const HomeState.initial() : this(pageSelected: PageSelected.home, text: '');

  final PageSelected pageSelected;
  final String text;

  @override
  List<Object?> get props => [pageSelected, text];

  HomeState copyWith({
    PageSelected? pageSelected,
    String? text,
  }) {
    return HomeState(
        pageSelected: pageSelected ?? this.pageSelected,
        text: text ?? this.text);
  }
}
