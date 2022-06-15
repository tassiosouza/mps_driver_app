import 'package:mps_driver_app/models/Coordinates.dart';
import 'package:tuple/tuple.dart';
import './Coordinates.dart';

class Client {
  String name = '';
  String phone = '';
  String address = '';
  Coordinates coordinates = Coordinates(0, 0);
  int indexOnRoute = 0;
  int eta = 0;

  Client();

  void getDataFromLine(String line) {
    var endNameIndex = line.indexOf(')') + 1;
    name = line.substring(0, endNameIndex);
    phone = line.substring(name.length, name.length + 13);
    address = line.substring(name.length + phone.length);
  }
}
