import 'package:asustem_project/provider.dart';
import 'package:asustem_project/sensor_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Sensor_provider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.blueGrey[900],
            appBar: AppBar(
              backgroundColor: Colors.white30,
              centerTitle: true,
              title: const Text("Sensor Data"),
            ),
            body: MyApp()),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
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
  List sensor_type = ["Temperature", "Blood Pressure", "Weight", "Height"];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: Sensor_provider().sensor(),
        initialData: {},
        builder: (context, snapshot) {
          // print(Sensor_provider().sensor_data);

          return ListView.builder(
              itemCount: 4,
              itemBuilder: (BuildContext, index) {
                final data1 = Provider.of<Sensor_provider>(context);
                print("Data checker ${data1.sensor_data}");
                return Sensor(
                  Data: data[index][sensor_type[index]]['data'],
                  image: Image.asset(
                    data[index][sensor_type[index]]['image'],
                    height: 127,
                    width: 127,
                  ),
                  Sensor_Name: sensor_type[index],
                  Unit: data[index][sensor_type[index]]['unit'],
                );
              });
        });
  }
}
