
import 'package:get_it/get_it.dart';
import 'package:untitled5/src/core/network/api_service.dart';
import 'package:untitled5/src/features/get_weather/presentation/logic/get_weather_cubit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

GetIt getIt=GetIt.instance;

setupDi() async{
  await dotenv.load();
  await ApiService.init();
  getIt.registerLazySingleton(() => GetWeatherCubit());
}