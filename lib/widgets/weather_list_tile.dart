import 'package:cib_assessment/constants.dart';
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
      // openweathermap.org weather icon
      leading: CircleAvatar(
        backgroundColor: kLemonMeringue,
        radius: 25.0,
        backgroundImage: NetworkImage(
          weatherModel.getIconUrl(),
        ),
      ),
      // date
      title: Text(DateFormat('E d MMM').format(weatherModel.dt)),
      // min, max temp
      subtitle: Text('${weatherModel.minTemp.toString()}˚C to ${weatherModel.maxTemp.toString()}˚C'),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: kOrange,
      ),
      onTap: () {
        Navigator.push(
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
