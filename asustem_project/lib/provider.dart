import "package:dio/dio.dart";
import "package:flutter/material.dart";

class Sensor_provider extends ChangeNotifier {
  Map _sensor_data = {};
  Map get sensor_data => _sensor_data;

  final dio = Dio();
  Stream<Map> sensor() async* {
    final response = await dio.get(
        'https://vitalcheck-api-v2.onrender.com/api/sensorData/8efea8c7-1821-451b-b312-5a597d7af3a1');
    print("check this ${response}");
    _sensor_data = response.data;
    print("provider data ${_sensor_data}");
    notifyListeners();
  }
}
