import 'package:cib_assessment/models/weather_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherListTile extends StatelessWidget {
  final WeatherModel weatherModel;

  const WeatherListTile({this.weatherModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(weatherModel.getIconUrl()),
      title: Text(DateFormat.MMMd().format(weatherModel.dt)),
      subtitle: Text('${weatherModel.minTemp.toString()} / ${weatherModel.maxTemp.toString()}'),
    );
  }
}
