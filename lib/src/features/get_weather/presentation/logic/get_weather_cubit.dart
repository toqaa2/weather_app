import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled5/src/core/network/api_service.dart';
import 'package:untitled5/src/features/get_weather/domain/modela/city_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'get_weather_state.dart';

class GetWeatherCubit extends Cubit<GetWeatherState> {
  GetWeatherCubit() : super(GetWeatherInitial());


  final TextEditingController controller = TextEditingController();
  City city = City(name: '', temperature: '', humidity: '', cloudiness: '');

  void getCity(String cityName) async {
    print('get city data');
    try {
      final response = await ApiService.getData(
        endPoint: "current.json",
        queryParameters: {'key': dotenv.env['APIKEY'], 'q': cityName},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        city = City.fromJson(responseData);
        emit( GetWeatherSuccess());
      } else {
        emit(GetWeatherError(errorMessae: 'Error with server'));
      }
    } catch (e) {
      print("Error: $e");
      emit(GetWeatherError(errorMessae: e.toString()));

    }
  }

  void searchWeather() {
    print('search weather');
     emit(GetWeatherLoading());
    if (controller.text.isNotEmpty) {
      getCity(controller.text);
    } else {
      emit(GetWeatherError(errorMessae: "Please insert a city name"));
    }
  }
}
