import 'package:biblioteca/biography/biography.dart';
import 'package:biblioteca/biography/bloc/biography_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BiographyView extends StatelessWidget {
  const BiographyView({super.key});

  @override
  Widget build(BuildContext context) {
    final text = context.select((BiographyBloc bloc) => bloc.state.text);
    return Scaffold(
      body: BlocBuilder<BiographyBloc, BiographyState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            'Biografía de Juana de Ibarbourou',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        const SizedBox(width: 10.0),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            text,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                    image: DecorationImage(
                      image: Image.asset(
                        'assets/Juana_de_Ibarbourou.jpg',
                      ).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
