import 'package:biblioteca/biography/biography.dart';
import 'package:biblioteca/chat/chat.dart';
import 'package:biblioteca/home/home.dart';
import 'package:biblioteca/package_ui/style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter _router = GoRouter(
  initialLocation: HomePage.path,
  routes: [
    GoRoute(
      path: HomePage.path,
      pageBuilder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: BiographyPage.path,
      pageBuilder: (context, state) => const BiographyPage(),
    ),
    GoRoute(
      path: ChatPage.path,
      pageBuilder: (context, state) => const ChatPage(),
    ),
  ],
);

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: appTheme,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
