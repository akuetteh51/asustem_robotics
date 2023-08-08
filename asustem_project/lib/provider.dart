import "package:dio/dio.dart";
import "package:flutter/material.dart";

class Sensor_provider extends ChangeNotifier {
   int? _status_code =0;
  int? get status_code => _status_code;
  Map _sensor_data = {};
  Map get sensor_data => _sensor_data;

  String? _message ;
  String? get message =>_message;

  final dio = Dio();
  Stream<Map> sensor() async* {
    try{

    final response = await dio.get(
        'https://vitalcheck-api-v2.onrender.com/api/sensorData/8efea8c7-1821-451b-b312-5a597d7af3a1');
    print("check this ${response.statusCode}");
    print(response.data);
   
    if(response.statusCode == 200 && response.data['status'] == 204){

      _message = response.data['SensorData'];
      _status_code = response.data['status'] ;
      print("from if  $_sensor_data");
      notifyListeners();
    }
    else if(response.statusCode == 200 && response.data['status'] == 200){
 _sensor_data = response.data['SensorData'];
 _status_code = response.data['status'] ;
  print("from else if $_sensor_data");
  notifyListeners();

    }
     else{
      
    _status_code = response.statusCode;
   print("from else $_sensor_data");
    notifyListeners();
    }
   
    }

    catch(e){
      _message="Check your Internet connectivity";

      print(e);
    }
  }
}
