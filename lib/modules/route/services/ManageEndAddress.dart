import 'package:shared_preferences/shared_preferences.dart';

class ManageEndAddress{

  saveEndAddress(String endAddress) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('endaddress', endAddress);
  }

  Future<String?> getEndAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String endAddress = prefs.getString('endaddress') ?? 'Meal Prep Sunday';
    return endAddress;
  }
}