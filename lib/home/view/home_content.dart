import 'package:biblioteca/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeContentView extends StatelessWidget {
  const HomeContentView({super.key});

  @override
  Widget build(BuildContext context) {
    final text = context.select((HomeBloc bloc) => bloc.state.text);

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: Image.asset(
          'assets/splash_screen.jpg',
        ).image,
        fit: BoxFit.fitWidth,
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 50),
          Text(
            "Bienvenidos",
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSecondary, fontSize: 50),
          ),
          const SizedBox(height: 20),
          Text(
            "Archivo General Universitario",
            textAlign: TextAlign.right,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Theme.of(context).colorScheme.onSecondary),
          ),
          const SizedBox(height: 50),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Theme.of(context).colorScheme.onSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
