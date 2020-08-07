import 'package:cib_assessment/constants.dart';
import 'package:cib_assessment/screens/weather_forecast.dart';
import 'package:cib_assessment/services/location_service.dart';
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
    Location location = Location();

    // Show popup is GPS is off
    if (!(await location.idGpsOn())) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    // Get 7 day forecast
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
          // spinner while loading
          child: SpinKitRipple(
            color: kMaxRed,
            size: 220.0,
          ),
        ),
      ),
    );
  }

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("On Locatin"),
    content: Text("Please switch on location service?"),
    actions: [
      FlatButton(
        child: Text("OK"),
        onPressed: () {},
      ),
    ],
  );
}
