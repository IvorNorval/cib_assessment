import 'package:cib_assessment/constants.dart';
import 'package:cib_assessment/models/weather_model.dart';
import 'package:cib_assessment/screens/exit_screen.dart';
import 'package:cib_assessment/screens/loading_screen.dart';
import 'package:cib_assessment/widgets/weather_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WeatherForecast extends StatelessWidget {
  final List<WeatherModel> dailyModels;

  const WeatherForecast({this.dailyModels});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (BuildContext context) => new ExitScreen()), (Route<dynamic> route) => false);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              // Heading & refresh button
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoadingScreen();
                      },
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20.0),
                  height: 60,
                  width: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ignore: missing_required_param
                      Shimmer.fromColors(
                        baseColor: Colors.white,
                        period: Duration(milliseconds: 5000),
                        highlightColor: kPrussianBlue,
                        child: Text(
                          'Weather outlook',
                          style: kHeadingTextStyle,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Icon(
                        Icons.refresh,
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: kOrange,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              // Day forecast summary
              Expanded(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: ListView.builder(
                      itemCount: dailyModels.length,
                      itemBuilder: (context, index) {
                        return WeatherListTile(
                          weatherModel: dailyModels[index],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
