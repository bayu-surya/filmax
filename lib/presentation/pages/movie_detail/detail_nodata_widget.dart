import 'package:flutter/material.dart';
import 'package:flutter_shine/flutter_shine.dart';

class DetailNoDataWidget extends StatelessWidget {
  final String message;
  final String jenis;

  const DetailNoDataWidget({
    Key? key,
    required this.message,
    required this.jenis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    height: 250,
                    color: Colors.grey,
                  ),
                  Positioned(
                    top: 100,
                    left: 10,
                    right: 10,
                    child: FlutterShine(builder:
                        (BuildContext context, ShineShadow? shineShadow) {
                      return Text(
                        "Detail Movie",
                        textAlign: TextAlign.center,
                        style: shineShadow != null
                            ? TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                shadows: shineShadow.shadows,
                              )
                            : TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                      );
                    }),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 200, left: 15, right: 15, bottom: 15),
                      child: Card(
                        elevation: 1.7,
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Description",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: 200,
                                child: jenis == "loading"
                                    ? Text(
                                        message,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : Center(
                                        child: CircularProgressIndicator(),
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
