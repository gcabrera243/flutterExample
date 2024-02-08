import 'dart:async';
import 'dart:convert';

import 'package:biblioteca/biography/bloc/biography_event.dart';
import 'package:biblioteca/biography/bloc/biography_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class BiographyBloc extends Bloc<BiographyEvent, BiographyState> {
  BiographyBloc() : super(const BiographyState.initial()) {
    on<FetchBiographyDataEvent>(_onFetchBiographyDataEvent);
  }

  Future<String> fetchData() async {
    final response = await http
        .get(Uri.parse('https://private-7696b-retoucu.apiary-mock.com/home'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(const Utf8Decoder().convert(response.bodyBytes));
      final String texto = data['text'];
      return texto;
    } else {
      throw Exception('Error al cargar el texto desde la API');
    }
  }

  FutureOr<void> _onFetchBiographyDataEvent(
      FetchBiographyDataEvent event, Emitter<BiographyState> emit) async {
    final texto = await fetchData();
    emit(state.copyWith(text: texto));
  }
}
