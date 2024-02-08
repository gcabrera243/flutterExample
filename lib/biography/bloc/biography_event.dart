import 'package:equatable/equatable.dart';

abstract class BiographyEvent extends Equatable {
  const BiographyEvent();
}

class FetchBiographyDataEvent extends BiographyEvent {
  @override
  List<Object> get props => [];
}
