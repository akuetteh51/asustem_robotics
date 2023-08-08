import 'package:asustem_project/provider.dart';
import 'package:asustem_project/sensor_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class Sensor_data extends StatelessWidget {
   Sensor_data({super.key});

   List<Map> data = [
    {
      "Temperature": {"sensor_type":'Temp', "unit": " °C", "image": "images/temp.png"}
    },
    {
      "Blood Pressure": {"sensor_type":'Bmp',"unit": " mmhg", "image": "images/bdp.png"}
    },
    {
      "Weight": {"sensor_type": 'weight',"unit": " KG", "image": "images/weight.png"}
    },
    {
      "Height": {"sensor_type":'Height',"unit": " ft", "image": "images/height.png"}
    }
  ];
  List sensor_type = ["Temperature", "Blood Pressure", "Weight", "Height"];


  @override
  Widget build(BuildContext context) {
 
    final sensor_data=Provider.of<Sensor_provider>(context);
   
    
    

    return StreamBuilder<Object>(
    
        stream: sensor_data.sensor(),
        initialData: {},
        builder: (context, snapshot) {
          if(snapshot.hasData && sensor_data.status_code==200){
            
            return

          Scaffold(
            backgroundColor: Colors.blueGrey[900],
            appBar: AppBar(
           
              backgroundColor: Colors.white30,
              centerTitle: true,
              title: const Text("Sensor Data"),
            ),
            body:
          ListView.builder(
              itemCount: 4,
              itemBuilder: (BuildContext, index) {
                return Sensor(
                  Data:sensor_data.status_code==200 ? sensor_data.sensor_data[data[index][sensor_type[index]]['sensor_type'] ].toString():'--',
                  image: Image.asset(
                    data[index][sensor_type[index]]['image'],
                    height: 127,
                    width: 127,
                  ),
                  Sensor_Name: sensor_type[index],
                  Unit: data[index][sensor_type[index]]['unit'],
                );
              
              }),
              );

          }
        else  if(snapshot.hasData && sensor_data.status_code == 204 ){
            print("world else if");
                 return 
        Scaffold(
            backgroundColor: Colors.blueGrey[900],
            appBar: AppBar(
           
              backgroundColor: Colors.white30,
              centerTitle: true,
              title: const Text("Sensor Data"),
            ),
            body:
            CupertinoAlertDialog(title: Text("Check your Device"),
            content: Column(
              children: [
                Text("seems you have no device connected to vital system Checker "),
                Text(sensor_data.message.toString(),style: TextStyle(color: Colors.red),)          
                   ],
            ),
            ));
       
          }else{
print("from else state ${sensor_data.status_code}");
       return
       Scaffold(
            backgroundColor: Colors.blueGrey[900],
            appBar: AppBar(
           
              backgroundColor: Colors.white30,
              centerTitle: true,
              title: const Text("Sensor Data"),
            ),
            body: Container (
child:
          Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10,),
              Text("loading.... Please wait.",style: TextStyle(fontSize: 18,color: Colors.white),)
            ],
          ))
          )
       );  
          }

          
        });
  }
}