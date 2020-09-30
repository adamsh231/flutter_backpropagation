import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  Detail({this.info, this.about});

  String info, about;
  double _flexHeight(BuildContext context, double height) {
    return (MediaQuery.of(context).size.height * height / 774.8571428571429);
  }

  double _flexWidth(BuildContext context, double width) {
    return (MediaQuery.of(context).size.width * width / 411.42857142857144);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(info),
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
            width: _flexWidth(context, 360),
            height: _flexHeight(context, 550),
            margin: EdgeInsets.fromLTRB(
                _flexWidth(context, 30),
                _flexHeight(context, 100),
                _flexWidth(context, 30),
                _flexHeight(context, 100)),
            child: Card(
              color: Colors.white,
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    about,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.justify,
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
