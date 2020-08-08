import 'package:cib_assessment/constants.dart';
import 'package:cib_assessment/models/weather_model.dart';
import 'package:cib_assessment/services/location_service.dart';
import 'package:cib_assessment/services/network_service.dart';

class WeatherService {
  // get 7 day forecast
  Future<List<WeatherModel>> get7DayWeather() async {
    Location location = Location();
    await location.getCurrentPosition();

    NetworkHelper networkHelper = NetworkHelper(
        '$kOpenWeatherMapUrl$kOneCall?lat=${location.latitude}&lon=${location.longitude}&exclude=$kExclude&appid=$kApiKey&units=$kUnits');
    var weatherData = await networkHelper.getData();

    List<WeatherModel> dailyModels = getWeatherModels(weatherData);
    return dailyModels;
  }

  // convert json to decoded data to weather model
  List<WeatherModel> getWeatherModels(dynamic weatherData) {
    List<WeatherModel> weatherDays = [];
    if (weatherData != null) {
      for (int n = 0; n < 8; n++) {
        WeatherModel weather = new WeatherModel();
        weather.timezoneOffset = weatherData['timezone_offset'];

        int epochTime = weatherData['daily'][n]['dt']; //daily[0].dt
        weather.dt = DateTime.fromMillisecondsSinceEpoch(epochTime * 1000, isUtc: false);

        epochTime = weatherData['daily'][n]['sunrise'];
        weather.sunrise = DateTime.fromMillisecondsSinceEpoch(epochTime * 1000, isUtc: false);

        epochTime = weatherData['daily'][n]['sunset'];
        weather.sunset = DateTime.fromMillisecondsSinceEpoch(epochTime * 1000, isUtc: false);

        var temp = weatherData['daily'][n]['temp']['day']; //daily[0].temp.day
        weather.dayTemp = temp.round();
        temp = weatherData['daily'][n]['temp']['min']; //daily[0].temp.min
        weather.minTemp = temp.round();
        temp = weatherData['daily'][n]['temp']['max']; //daily[0].temp.max
        weather.maxTemp = temp.round();
        weather.pressure = weatherData['daily'][n]['pressure']; //daily[0].pressure
        weather.humidity = weatherData['daily'][n]['humidity']; //daily[0].humidity
        weather.windSpeed = weatherData['daily'][n]['wind_speed'].toDouble() * 3.6; //daily[0].wind_speed

        // change wind direction degrees to degrees to rotate wind direction image
        weather.windDeg = weatherData['daily'][n]['wind_deg'];
//        if (weatherData['daily'][n]['wind_deg'] < 180)
//          weather.windDeg = weatherData['daily'][n]['wind_deg']; //daily[0].wind_deg
//        else
//          weather.windDeg = -(360 - weatherData['daily'][n]['wind_deg']); //daily[0].wind_deg

        weather.weatherId = weatherData['daily'][n]['weather'][0]['id']; //daily[0].weather[0].id
        weather.weatherIcon = weatherData['daily'][n]['weather'][0]['icon']; //daily[0].weather[0].icon
        weather.weatherDescription = weatherData['daily'][n]['weather'][0]['description']; //daily[0].weather[0].description
        weather.clouds = weatherData['daily'][n]['clouds']; //daily[0].clouds

        // handle rain exceptions
        if (weatherData['daily'][n]['rain'] != null) {
          if (weatherData['daily'][n]['rain'] < 1)
            weather.rain = 1;
          else {
            double rain = weatherData['daily'][n]['rain'];
            weather.rain = rain.round();
          }
        } else
          weather.rain = 0;

        // handle probability of rain exceptions.
        if (weatherData['daily'][n]['pop'] == 1)
          weather.pop = 100;
        else if (weatherData['daily'][n]['pop'] != null && weatherData['daily'][n]['pop'] != 0) {
          double pop = weatherData['daily'][n]['pop'];
          weather.pop = (pop * 100).round();
        } else
          weather.pop = 0;

        weather.uvi = weatherData['daily'][n]['uvi'].toDouble(); //daily[0].uvi
        weatherDays.add(weather);
      }
    }
    return weatherDays;
  }
}
