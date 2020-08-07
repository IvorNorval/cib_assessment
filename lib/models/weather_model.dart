class WeatherModel {
  DateTime dt;
  String timezone;
  int timezoneOffset;
  DateTime sunrise;
  DateTime sunset;
  int dayTemp;
  int minTemp;
  int maxTemp;
  int pressure;
  int humidity;
  double windSpeed;
  int windDeg;
  int weatherId;
  String weatherIcon;
  String weatherDescription;
  int clouds;
  int rain;
  int pop;
  double uvi;
  String icoUrl;

  String getIconUrl() {
    if (weatherIcon != null)
      return 'http://openweathermap.org/img/wn/$weatherIcon@2x.png';
    else
      return null;
  }
}
