import 'package:geolocator/geolocator.dart';

class Location {
  double latitude = -34.0803325;
  double longitude = 18.8643833;

  // Get current position
  Future<void> getCurrentPosition() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      longitude = position.longitude;
      latitude = position.latitude;
    } on Exception catch (e) {
      print(e);
    }
  }

  // Check GPS is on
  Future<bool> idGpsOn() async {
    return (await Geolocator().isLocationServiceEnabled());
  }
}
