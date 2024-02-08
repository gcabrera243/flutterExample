import 'package:biblioteca/biography/bloc/biography_bloc.dart';
import 'package:biblioteca/biography/bloc/biography_event.dart';
import 'package:biblioteca/biography/view/biography_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BiographyPage extends Page<void> {
  const BiographyPage({super.key});

  static const path = '/Bibliografia';

  @override
  Route<void> createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (ctx) {
        return BlocProvider(
          create: (_) => BiographyBloc()..add(FetchBiographyDataEvent()),
          child: const BiographyView(),
        );
      },
    );
  }
}
