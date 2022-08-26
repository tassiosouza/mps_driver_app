import 'package:location/location.dart';

class LocationService{
  late Location location;

  void initLocation(){
    location = Location();
    location.enableBackgroundMode(enable: true);
  }

  Future<List<double?>> getLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return [];
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return [];
      }
    }

    locationData = await location.getLocation();
    return [
      locationData.latitude,
      locationData.longitude
    ];
  }
}