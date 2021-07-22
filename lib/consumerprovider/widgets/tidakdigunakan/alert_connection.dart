import 'package:flutter/material.dart';

class AlertConnection extends StatelessWidget {

  const AlertConnection({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.redAccent,
      padding: const EdgeInsets.all(16.0),
      child: Center(
          child: Text(
            "Perangkat anda dalam kondisi offline,\nmohon nyalakan koneksi internet",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),),),);
  }
}