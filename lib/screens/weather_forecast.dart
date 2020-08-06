import 'package:cib_assessment/models/weather_model.dart';
import 'package:cib_assessment/widgets/weather_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherForecast extends StatelessWidget {
  final List<WeatherModel> dailyModels;

  const WeatherForecast({this.dailyModels});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: dailyModels.length,
          itemBuilder: (context, index) {
            return WeatherListTile(
              weatherModel: dailyModels[index],
            );
          },
        ),
      ),
    );
  }
}
