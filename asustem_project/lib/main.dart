import 'package:asustem_project/sensor_widget.dart';
import 'package:flutter/material.dart';

void main() {
  List<Map> data = [
    {
      "Temperature": {"data": "5'7", "unit": "ft", "image": "images/temp.png"}
    },
    {
      "Blood Pressure": {"data": "5'7", "unit": "ft", "image": "images/bdp.png"}
    },
    {
      "Weight": {"data": "5'7", "unit": "ft", "image": "images/weight.png"}
    },
    {
      "Height": {"data": "5'7", "unit": "ft", "image": "images/height.png"}
    }
  ];
  List Sensor_type = ["Temperature", "Blood Pressure", "Weight", "Height"];
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          backgroundColor: Colors.white30,
          centerTitle: true,
          title: const Text("Sensor Data"),
        ),
        body: ListView.builder(
            itemCount: 4,
            itemBuilder: (BuildContext, index) {
              return Sensor(
                Data: data[index][Sensor_type[index]]['data'],
                image: Image.asset(
                  data[index][Sensor_type[index]]['image'],
                  height: 127,
                  width: 127,
                ),
                Sensor_Name: Sensor_type[index],
                Unit: data[index][Sensor_type[index]]['unit'],
              );
            }),
      ),
    ),
  );
}
