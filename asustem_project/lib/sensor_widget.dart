import 'package:flutter/material.dart';

class Sensor extends StatelessWidget {
  Sensor(
      {required this.image,
      required this.Sensor_Name,
      required this.Data,
      required this.Unit});
  final Image image;
  final String Sensor_Name;
  final String Data;
  final String Unit;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 43, right: 43, top: 10),
      height: 193,
      decoration: BoxDecoration(
          color: Colors.white30, borderRadius: BorderRadius.circular(38)),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Spacer(),
          Container(color: Colors.amber,
            height: 85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Sensor_Name,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                ),
                Row(
                  children: [
                    Text(
                      Data,
                      style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.w800),
                    ) 
                    ,
                    Text(
                      Unit,
                      style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                )
              ],
            ),
          ),
          Spacer(),
          image
        ],
      ),
    );
  }
}
