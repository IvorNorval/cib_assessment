import 'package:cib_assessment/constants.dart';
import 'package:cib_assessment/models/weather_model.dart';
import 'package:cib_assessment/services/location_service.dart';
import 'package:cib_assessment/services/network_service.dart';

class WeatherService {
  Future<List<WeatherModel>> get7DayWeather() async {
    Location location = Location();
    await location.getCurrentPosition();

    NetworkHelper networkHelper = NetworkHelper(
        '$kOpenWeatherMapUrl$kOneCall?lat=${location.latitude}&lon=${location.longitude}&exclude=$kExclude&appid=$kApiKey&units=$kUnits');
    var weatherData = await networkHelper.getData();

    List<WeatherModel> dailyModels = getWeatherModels(weatherData);
    return dailyModels;
  }

  List<WeatherModel> getWeatherModels(dynamic weatherData) {
    List<WeatherModel> weatherDays = [];
    if (weatherData != null) {
      for (int n = 0; n < 7; n++) {
        WeatherModel weather = new WeatherModel();
        weather.timezone = weatherData['timezone'];
        int epochTime = weatherData['daily'][n]['dt']; //daily[0].dt
        weather.dt = DateTime.fromMillisecondsSinceEpoch(epochTime * 1000, isUtc: true);
        epochTime = weatherData['daily'][n]['sunrise'];
        weather.sunrise = DateTime.fromMillisecondsSinceEpoch(epochTime * 1000, isUtc: true);
        epochTime = weatherData['daily'][n]['sunset'];
        weather.sunset = DateTime.fromMillisecondsSinceEpoch(epochTime * 1000, isUtc: true);
        double temp = weatherData['daily'][n]['temp']['day']; //daily[0].temp.day
        weather.dayTemp = temp.round();
        temp = weatherData['daily'][n]['temp']['min']; //daily[0].temp.min
        weather.minTemp = temp.round();
        temp = weatherData['daily'][n]['temp']['max']; //daily[0].temp.max
        weather.maxTemp = temp.round();
        weather.pressure = weatherData['daily'][n]['pressure']; //daily[0].pressure
        weather.humidity = weatherData['daily'][n]['humidity']; //daily[0].humidity
        weather.windSpeed = weatherData['daily'][n]['wind_speed']; //daily[0].wind_speed
        weather.windDeg = weatherData['daily'][n]['wind_deg']; //daily[0].wind_deg
        weather.weatherId = weatherData['daily'][n]['weather'][0]['id']; //daily[0].weather[0].id
        weather.weatherIcon = weatherData['daily'][n]['weather'][0]['icon']; //daily[0].weather[0].icon
        weather.weatherDescription = weatherData['daily'][n]['weather'][0]['description']; //daily[0].weather[0].description
        weather.clouds = weatherData['daily'][n]['clouds']; //daily[0].clouds
        if (weatherData['daily'][n]['rain'] != null) {
          weather.rain = weatherData['daily'][n]['rain']; //daily[0].rain
        }

        //var tempPop = weatherData['daily'][n]['pop'];
        //weather.pop = tempPop; //daily[0].pop
        weather.uvi = weatherData['daily'][n]['uvi']; //daily[0].uvi
        weatherDays.add(weather);
      }
    }
    return weatherDays;
  }
}
