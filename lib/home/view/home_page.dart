import 'package:biblioteca/chat/chat.dart';
import 'package:biblioteca/home/bloc/home_event.dart';
import 'package:biblioteca/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends Page<void> {
  const HomePage({super.key});

  static const path = '/home';

  @override
  Route<void> createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (ctx) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              key: GlobalKey(),
              create: (_) => HomeBloc()..add(HomeDataRequested()),
            ),
            BlocProvider(
              create: (context) => ChatBloc(),
            ),
          ],
          child: HomeView(),
        );
      },
    );
  }
}
