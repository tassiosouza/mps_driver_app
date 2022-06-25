import 'package:mobx/mobx.dart';
import 'package:mps_driver_app/models/Coordinates.dart';
import 'package:tuple/tuple.dart';
import './Coordinates.dart';

class Client {
  String id = '';
  String name = '';
  String phone = '';
  String address = '';
  String secondAddress = '';
  String city = '';
  String stateZipCode = '';
  String deliveryInstructions = '';
  String mealInstructions = '';
  Coordinates coordinates = Coordinates(0, 0);
  int indexOnRoute = 0;
  int eta = 0;
  @observable
  bool check = false;

  Client();
}
