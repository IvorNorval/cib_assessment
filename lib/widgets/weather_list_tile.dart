import 'package:cib_assessment/models/weather_model.dart';
import 'package:cib_assessment/screens/weather_details.dart';
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
      subtitle: Text('${weatherModel.minTemp.toString()}˚C to ${weatherModel.maxTemp.toString()}˚C'),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.deepOrangeAccent,
      ),
      onTap: () {
        var typedName = Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return WeatherDetail(
                weatherModel: weatherModel,
              );
            },
          ),
        );
      },
    );
  }
}
