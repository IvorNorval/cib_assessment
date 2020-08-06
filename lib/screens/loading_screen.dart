import 'package:cib_assessment/screens/weather_forecast.dart';
import 'package:cib_assessment/services/weather_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  Future<void> getLocationData() async {
    WeatherService weatherService = WeatherService();
    var weatherData = await weatherService.get7DayWeather();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return WeatherForecast(
            dailyModels: weatherData,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/weather1.jpg'),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: SpinKitRipple(
            color: Color(0xffE76704),
            size: 220.0,
          ),
        ),
      ),
    );
  }
}
