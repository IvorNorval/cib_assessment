import 'package:cib_assessment/constants.dart';
import 'package:cib_assessment/models/weather_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherDetail extends StatelessWidget {
  final WeatherModel weatherModel;

  WeatherDetail({this.weatherModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kLemonMeringue,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // heading as date
              Text(
                DateFormat('E d MMM').format(weatherModel.dt),
                style: kLabelTextStyle2,
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // sunrise time
                  Column(
                    children: [
                      Image.asset(
                        'images/icons8-sunrise-100.png',
                      ),
                      Text(
                        DateFormat.Hm().format(weatherModel.sunrise),
                        style: kLabelTextStyle1,
                      ),
                    ],
                  ),
                  // openweathermap.org weather icon
                  Image.network(weatherModel.getIconUrl()),
                  Column(
                    children: [
                      Image.asset('images/icons8-sunset-100.png'),
                      // sunset time
                      Text(
                        DateFormat.Hm().format(weatherModel.sunset),
                        style: kLabelTextStyle1,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              // min max temp
              Text(
                '${weatherModel.minTemp.toString()}˚C to ${weatherModel.maxTemp.toString()}˚C',
                style: kLabelTextStyle1,
              ),
              SizedBox(
                height: 15.0,
              ),
              // Wind direction indicator
              Container(
                width: 120.0,
                height: 120.0,
                child: RotationTransition(
                  turns: AlwaysStoppedAnimation((270 - weatherModel.windDeg) / 360),
                  child: Image.asset('images/arrow-icon-1162.png'),
                ),
              ),
              // wind speed
              Text(
                'Wind ${weatherModel.windSpeed} meter / second',
                style: kLabelTextStyle1,
              ),
              SizedBox(
                height: 15.0,
              ),
              // UV index
              Text(
                'UV index ${weatherModel.uvi}',
                style: kLabelTextStyle1,
              ),
              SizedBox(
                height: 15.0,
              ),
              // rain forecast
              Text(
                (weatherModel.rain != 0) ? '${weatherModel.pop} % chance of ${weatherModel.rain} mm of rain' : "No rain",
                style: kLabelTextStyle3,
              ),
            ],
          ),
        ),
        // back button
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.keyboard_backspace),
          backgroundColor: Colors.deepOrangeAccent,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
