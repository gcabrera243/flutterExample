import 'package:biblioteca/biography/biography.dart';
import 'package:biblioteca/biography/bloc/biography_event.dart';
import 'package:biblioteca/chat/chat.dart';
import 'package:biblioteca/home/home.dart';
import 'package:biblioteca/home/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final List<Widget> _views = [
    const HomeContentView(),
    BlocProvider(
      child: const BiographyView(),
      create: (context) => BiographyBloc()..add(FetchBiographyDataEvent()),
    ),
    BlocProvider(
      create: (context) => ChatBloc(),
      child: ChatView(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final pageSelected =
        context.select((HomeBloc bloc) => bloc.state.pageSelected);
    return Scaffold(appBar: const Navbar(), body: _views[pageSelected.index]);
  }
}
