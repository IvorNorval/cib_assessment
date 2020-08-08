import 'package:cib_assessment/constants.dart';
import 'package:cib_assessment/models/weather_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherDetail extends StatefulWidget {
  final WeatherModel weatherModel;

  WeatherDetail({this.weatherModel});

  @override
  _WeatherDetailState createState() => _WeatherDetailState();
}

class _WeatherDetailState extends State<WeatherDetail> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation =
        Tween(begin: ((widget.weatherModel.windDeg - 3).toDouble()), end: ((widget.weatherModel.windDeg + 3).toDouble())).animate(_controller)
          ..addStatusListener((state) {
            if (state == AnimationStatus.completed) {
              print("completed");
            } else if (state == AnimationStatus.dismissed) {
              print("dismissed");
            }
          })
          ..addListener(() {
            setState(() {});
          });
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                DateFormat('E d MMM').format(widget.weatherModel.dt),
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
                        DateFormat.Hm().format(widget.weatherModel.sunrise),
                        style: kLabelTextStyle1,
                      ),
                    ],
                  ),
                  // openweathermap.org weather icon
                  Image.network(widget.weatherModel.getIconUrl()),
                  Column(
                    children: [
                      Image.asset('images/icons8-sunset-100.png'),
                      // sunset time
                      Text(
                        DateFormat.Hm().format(widget.weatherModel.sunset),
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
                '${widget.weatherModel.minTemp.toString()}˚C to ${widget.weatherModel.maxTemp.toString()}˚C',
                style: kLabelTextStyle1,
              ),
              SizedBox(
                height: 15.0,
              ),
              // Wind direction indicator
              Container(
                width: 150.0,
                height: 150.0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('images/wind_directions.png'),
                    RotationTransition(
                      turns: AlwaysStoppedAnimation(_animation.value / 360),
                      child: Image.asset(
                        'images/arrow-icon-1162.png',
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              // wind speed
              Text(
                'Wind ${widget.weatherModel.windSpeed.round()} km/h',
                style: kLabelTextStyle1,
              ),
              SizedBox(
                height: 15.0,
              ),
              // UV index
              Text(
                'UV index ${widget.weatherModel.uvi}',
                style: kLabelTextStyle1,
              ),
              SizedBox(
                height: 15.0,
              ),
              // rain forecast
              Text(
                (widget.weatherModel.rain != 0) ? '${widget.weatherModel.pop} % chance of ${widget.weatherModel.rain} mm of rain' : "No rain",
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
