import 'package:biblioteca/app/view/bloc/app_event.dart';
import 'package:biblioteca/app/view/bloc/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState.initial());
}
