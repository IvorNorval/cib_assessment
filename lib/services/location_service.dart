import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;

  Future<void> getCurrentPosition() async {
    try {
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      longitude = position.longitude;
      latitude = position.latitude;
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<bool> idGpsOn() async {
    return (await Geolocator().isLocationServiceEnabled());
  }
}
