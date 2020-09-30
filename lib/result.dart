import 'package:flutter/material.dart';
import 'dart:math';

class Result extends StatelessWidget {
  Result({this.hasil});

  List hasil;

  double _flexHeight(BuildContext context, double height) {
    return (MediaQuery.of(context).size.height * height / 774.8571428571429);
  }

  double _flexWidth(BuildContext context, double width) {
    return (MediaQuery.of(context).size.width * width / 411.42857142857144);
  }

  int result(List hasil) {
    int diabetes = 0;
    hasil = floor(hasil);
    for (var i = 0; i < hasil.length; i++) {
      if (hasil[i] == 1) {
        diabetes = i;
      }
    }
    return diabetes;
  }

  List floor(List hasil) {
    for (var i = 0; i < hasil.length; i++) {
      if ((hasil[i] - 1).abs() < hasil[i]) {
        hasil[i] = 1;
      }
    }
    return hasil;
  }

  double resultError(List hasil) {
    double ori = result(hasil).toDouble();
    double error = 0;
    for (var i = 0; i < hasil.length; i++) {
      if (i == ori) {
        error += 1 - hasil[i];
      } else {
        error += hasil[i];
      }
    }

    error = error / hasil.length;
    return error * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('img/background.jpg'), fit: BoxFit.cover),
            ),
          ),
          Container(
            width: _flexWidth(context, 460),
            height: _flexHeight(context, 250),
            margin: EdgeInsets.fromLTRB(
                _flexWidth(context, 5),
                _flexHeight(context, 220),
                _flexWidth(context, 5),
                _flexHeight(context, 220)),
            child: Card(
              color: Colors.white,
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: _flexHeight(context, 220),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        result(hasil) == 1 ? "DIABETES" : "TIDAK DIABETES",
                        style: TextStyle(fontSize: 40, color: result(hasil) == 1 ? Colors.pink : Colors.lightBlue),
                      ),
                      Text(
                        "terdiagnosa dengan tingkat Error " +
                            resultError(hasil).toString() +
                            "%",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
