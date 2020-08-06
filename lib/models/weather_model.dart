class WeatherModel {
  DateTime dt;
  String timezone;
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
  double rain;
  double pop;
  double uvi;
  String icoUrl;

  String getIconUrl() {
    if (weatherIcon != null)
      return 'http://openweathermap.org/img/wn/$weatherIcon@2x.png';
    else
      return null;
  }
}
