import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/src/core/di/di.dart';
import 'package:untitled5/src/features/get_weather/presentation/logic/get_weather_cubit.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocProvider.value(
      value: getIt<GetWeatherCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Form(
                key: formKey,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please insert a city name';
                    }
                    return null;
                  },
                  controller: getIt<GetWeatherCubit>().controller,
                  decoration: InputDecoration(
                    labelText: 'Enter city name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    GetWeatherCubit().searchWeather();
                  }
                },
                child: Text('Search'),
              ),
              SizedBox(height: 20),
              BlocConsumer<GetWeatherCubit, GetWeatherState>(
                bloc: getIt<GetWeatherCubit>(),
                listener: (context, state) {
                  if (state is GetWeatherError) {
                    print('error');
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.errorMessae),
                    ));
                  }
                },
                builder: (context, state) {
                  print('build');
                  GetWeatherCubit cubit = getIt<GetWeatherCubit>();
                  return Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cubit.city.name.isNotEmpty
                                ? cubit.city.name
                                : 'City Name',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text('Temperature: ${cubit.city.temperature}'),
                          Text('Humidity: ${cubit.city.humidity}'),
                          Text('Cloudiness: ${cubit.city.cloudiness}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
