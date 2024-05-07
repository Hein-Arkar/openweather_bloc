import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:open_weather_cubit/models/custom_error.dart';

import '../../models/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherState.initial()) {
    on<WeatherEvent>((event, emit) {});
  }
}
