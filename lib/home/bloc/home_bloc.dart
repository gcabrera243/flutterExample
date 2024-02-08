import 'dart:async';
import 'dart:convert';

import 'package:biblioteca/home/bloc/home_event.dart';
import 'package:biblioteca/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState.initial()) {
    on<HomePageSelectedChanged>(_onPageSelectedChanged);
    on<HomeDataRequested>(_onDataRequested);
  }

  FutureOr<void> _onPageSelectedChanged(
      HomePageSelectedChanged event, Emitter<HomeState> emit) {
    emit(state.copyWith(pageSelected: event.pageSelected));
  }

  Future<String> fetchData() async {
    final response = await http
        .get(Uri.parse('https://private-7696b-retoucu.apiary-mock.com/home'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
      final String text = data['text'];
      return text;
    } else {
      throw Exception('Error al cargar el texto desde la API');
    }
  }

  FutureOr<void> _onDataRequested(
      HomeDataRequested event, Emitter<HomeState> emit) async {
    final text = await fetchData();
    emit(state.copyWith(text: text));
  }
}
